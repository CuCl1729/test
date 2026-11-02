---------------------------- MODULE KillRewards ----------------------------
(* Kill rewards of the data pack (namespace test).                           *)
(* Promise: every enemy that is killed and removed was paid exactly once     *)
(* (test:battle/grant_reward: drops, exp, job exp, quest kill progress).     *)
(*                                                                           *)
(* One server tick is the fixed order of test:tick (tick.mcfunction), with   *)
(* player-driven actions (advancement triggers) between ticks. Only what     *)
(* decides who gets paid is modelled: where the enemy is, whether it is at   *)
(* HP <= 0, its tags (kill, battle_reward_pending, battle_killed), and how   *)
(* often grant_reward ran for it. Damage is abstracted to "lethal or none".  *)
(* The CONSTANTS below are facts read from the code by run.ps1 on each run.  *)
EXTENDS Naturals

CONSTANTS
  Enemies,
  KillTagsPending,            \* damage/kill: battle_member enemy -> battle_reward_pending
  KillTagsBattleKilled,       \* damage/kill: battle_member enemy -> battle_killed
  FieldKillSkipsMember,       \* tick: reward/field_kill selector has tag=!battle_member
  FieldKillSkipsBattleKilled, \* tick: reward/field_kill selector has tag=!battle_killed
  AttackSkipsMember,          \* attack/damage: hit_apply selector has tag=!battle_member
  MagicSkipsMember,           \* projectile/move + magic/aoe/apply (magic/hit) skip battle_member
  BuffStepBeforeProcAll,      \* battle/turn_end: buff/step runs before proc_all
  ProcAllBeforeCheckEnd       \* battle/turn_end: proc_all runs before check_end

VARIABLES
  pc,      \* phase of the tick
  step,    \* position inside battle/turn_end
  loc,     \* "action" | "turn" (field maps) | "arena" (battle_member) | "gone" (entity killed)
  up,      \* test.status.hp >= 1
  killT,   \* tag kill
  pend,    \* tag battle_reward_pending
  bkill,   \* tag battle_killed
  paid     \* times test:battle/grant_reward ran with @s = this enemy

vars == <<pc, step, loc, up, killT, pend, bkill, paid>>

Live(e) == loc[e] # "gone"
InArena == {e \in Enemies : loc[e] = "arena"}
TE == IF ProcAllBeforeCheckEnd
        THEN IF BuffStepBeforeProcAll THEN <<"buff", "proc", "check">> ELSE <<"proc", "buff", "check">>
        ELSE IF BuffStepBeforeProcAll THEN <<"buff", "check", "proc">> ELSE <<"check", "proc", "buff">>

(* damage/.mcfunction line "if hp ..0 run function test:damage/kill"; damage/kill.mcfunction *)
Kill(e) ==
  /\ up'    = [up EXCEPT ![e] = FALSE]
  /\ pend'  = [pend EXCEPT ![e] = pend[e] \/ (KillTagsPending /\ loc[e] = "arena" /\ ~killT[e])]
  /\ bkill' = [bkill EXCEPT ![e] = bkill[e] \/ (KillTagsBattleKilled /\ loc[e] = "arena")]
  /\ killT' = [killT EXCEPT ![e] = TRUE]

(* A lethal hit on some live enemy at HP >= 1 that the hit path may target, or no kill. *)
MayKill(canHit(_)) ==
  \/ \E e \in Enemies : Live(e) /\ up[e] /\ canHit(e) /\ Kill(e)
  \/ UNCHANGED <<up, killT, pend, bkill>>

SwordCanHit(e) == loc[e] # "arena" \/ ~AttackSkipsMember
MagicCanHit(e) == loc[e] # "arena" \/ ~MagicSkipsMember
AnyCanHit(e)   == TRUE

(* battle/end -> return_member (alive) / return_member_defeated (HP <= 0, HP reset to max):
   both remove battle_member and teleport into test:turn. *)
EndBattle ==
  /\ loc' = [x \in Enemies |-> IF loc[x] = "arena" THEN "turn" ELSE loc[x]]
  /\ up'  = [x \in Enemies |-> IF loc[x] = "arena" THEN TRUE ELSE up[x]]

(* battle/start + enter_arena: a live field enemy in test:turn at HP >= 1 joins a battle
   (contact by field AI, or a non-lethal first strike). One battle instance is modelled. *)
StartBattle ==
  /\ InArena = {}
  /\ \E e \in Enemies : loc[e] = "turn" /\ up[e] /\ loc' = [loc EXCEPT ![e] = "arena"]

Init ==
  /\ pc = "player" /\ step = 1
  /\ loc \in [Enemies -> {"action", "turn"}]
  /\ up = [e \in Enemies |-> TRUE]
  /\ killT = [e \in Enemies |-> FALSE]
  /\ pend = [e \in Enemies |-> FALSE]
  /\ bkill = [e \in Enemies |-> FALSE]
  /\ paid = [e \in Enemies |-> 0]

(* Between ticks: trigger/left_click -> attack/ (sword), trigger/right_click/mainhand ->
   magic/ (aoe hits at once), or a non-lethal hit / contact that starts a battle. *)
Player ==
  /\ pc = "player" /\ pc' = "projectiles"
  /\ \/ MayKill(SwordCanHit) /\ UNCHANGED loc
     \/ MayKill(MagicCanHit) /\ UNCHANGED loc
     \/ StartBattle /\ UNCHANGED <<up, killT, pend, bkill>>
  /\ UNCHANGED <<step, paid>>

(* tick line: projectile/move -> magic/hit for a projectile cast earlier. *)
Projectiles ==
  /\ pc = "projectiles" /\ pc' = "battle"
  /\ MayKill(MagicCanHit)
  /\ UNCHANGED <<step, loc, paid>>

(* tick line: battle/tick. Either no turn ends this tick, the acting player flees
   (action/flee ends the battle without a result), or an action (attack, skill, item,
   enemy AI, equipment proc) possibly kills a battle enemy and turn_end runs. *)
BattleAct ==
  /\ pc = "battle" /\ step = 1
  /\ \/ InArena = {} /\ pc' = "fieldai" /\ UNCHANGED <<step, loc, up, killT, pend, bkill>>
     \/ InArena # {} /\ pc' = "fieldai" /\ UNCHANGED <<step, loc, up, killT, pend, bkill>>
     \/ InArena # {} /\ pc' = "fieldai" /\ EndBattle /\ UNCHANGED <<step, killT, pend, bkill>>
     \/ InArena # {} /\ pc' = "turnend" /\ step' = 1
        /\ \E e \in InArena : up[e] /\ Kill(e) /\ UNCHANGED loc
  /\ UNCHANGED paid

TurnEnd ==
  /\ pc = "turnend"
  /\ \/ /\ TE[step] = "buff"   \* buff/step: poison on the actor may kill it
        /\ \/ \E e \in InArena : up[e] /\ Kill(e)
           \/ UNCHANGED <<up, killT, pend, bkill>>
        /\ UNCHANGED <<loc, paid>>
     \/ /\ TE[step] = "proc"   \* battle/proc_all -> grant_reward for battle_reward_pending
        /\ paid' = [x \in Enemies |-> IF loc[x] = "arena" /\ pend[x] THEN paid[x] + 1 ELSE paid[x]]
        /\ pend' = [x \in Enemies |-> IF loc[x] = "arena" THEN FALSE ELSE pend[x]]
        /\ UNCHANGED <<loc, up, killT, bkill>>
     \/ /\ TE[step] = "check"  \* battle/check_end -> end_victory when no battle enemy is at HP >= 1
        /\ IF \A e \in InArena : ~up[e] THEN EndBattle ELSE UNCHANGED <<loc, up>>
        /\ UNCHANGED <<killT, pend, bkill, paid>>
  /\ IF step = 3 THEN pc' = "fieldai" /\ step' = 1 ELSE pc' = "turnend" /\ step' = step + 1

(* tick line: battle/field_ai/tick for enemies in test:turn at HP >= 1, not battle_member. *)
FieldAI ==
  /\ pc = "fieldai" /\ pc' = "poison"
  /\ \/ StartBattle
     \/ UNCHANGED loc
  /\ UNCHANGED <<step, up, killT, pend, bkill, paid>>

(* tick line: buff/tick_second_all, only outside test:turn and test:arena: poison may kill. *)
Poison ==
  /\ pc = "poison" /\ pc' = "fieldkill"
  /\ \/ \E e \in Enemies : loc[e] = "action" /\ up[e] /\ Kill(e)
     \/ UNCHANGED <<up, killT, pend, bkill>>
  /\ UNCHANGED <<step, loc, paid>>

(* tick line: execute as @e[tag=kill,tag=enemy,...] run function test:reward/field_kill *)
FieldPaid(e) ==
  /\ Live(e) /\ killT[e]
  /\ (loc[e] # "arena" \/ ~FieldKillSkipsMember)
  /\ (~bkill[e] \/ ~FieldKillSkipsBattleKilled)
FieldKill ==
  /\ pc = "fieldkill" /\ pc' = "remove"
  /\ paid' = [x \in Enemies |-> IF FieldPaid(x) THEN paid[x] + 1 ELSE paid[x]]
  /\ pend' = [x \in Enemies |-> IF FieldPaid(x) THEN FALSE ELSE pend[x]]
  /\ UNCHANGED <<step, loc, up, killT, bkill>>

(* tick line: kill @e[tag=kill] *)
Remove ==
  /\ pc = "remove" /\ pc' = "player"
  /\ loc' = [x \in Enemies |-> IF killT[x] THEN "gone" ELSE loc[x]]
  /\ killT' = [x \in Enemies |-> FALSE]
  /\ UNCHANGED <<step, up, pend, bkill, paid>>

Next == Player \/ Projectiles \/ BattleAct \/ TurnEnd \/ FieldAI \/ Poison \/ FieldKill \/ Remove

Spec == Init /\ [][Next]_vars

(* No enemy is paid twice (duplicated drops, exp and quest progress). *)
AtMostOnce == \A e \in Enemies : paid[e] <= 1
(* An enemy that was killed and removed was paid (no lost reward). *)
PaidWhenRemoved == \A e \in Enemies : loc[e] = "gone" => paid[e] = 1
=============================================================================
