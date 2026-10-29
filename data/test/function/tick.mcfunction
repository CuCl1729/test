#> test:tick
# 
# @private



execute as @e[tag=projectile] at @s run function test:projectile/move
execute as @a run function test:cache/slot_check
execute as @a run function test:job/skill/bundle_check_inventory
execute as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{test:{skill_marker:1b}}}}}] run function test:job/skill/bundle_check_dropped
execute as @e[type=player] run function test:ui/status/
# ステーション(工房・強化台・魔法台・Jobステーション)。種類ごとの違いは init/asset/station のレジストリにある
execute as @e[tag=station] at @s if entity @e[type=player,distance=..6] run function test:station/tick
execute as @e[tag=attract] at @s run function test:motion/player/attract/main
# ログインし直したプレイヤー(戦闘中にログアウトしていたら、戦闘の続きに戻すか元の場所へ帰す)
execute as @a[scores={test.leave_game=1..}] at @s run function test:battle/rejoin
execute in test:arena as @e[tag=battle_marker] at @s run function test:battle/tick
# 戦闘中の入り口(フィールドに残る。叩くと途中参加できる)を見えるようにする
execute in test:turn as @e[tag=battle_entrance,distance=0..] at @s run particle minecraft:portal ~ ~1 ~ 0.3 0.6 0.3 0 2
execute as @e[tag=skill_minecart,tag=!skill_effect_minecart,tag=!target_minecart,tag=!skill_category_minecart,tag=!active_skill_minecart] at @s run function test:battle/ui/skill_type_cart_tick
execute as @e[tag=skill_category_minecart] at @s run function test:battle/ui/skill_category_cart_tick
execute as @e[tag=active_skill_minecart] at @s run function test:battle/ui/active_skill_cart_tick
execute as @e[tag=skill_effect_minecart] at @s run function test:battle/ui/skill_effect_cart_tick
execute as @e[tag=target_minecart] at @s run function test:battle/ui/target_cart_tick
execute as @e[tag=item_minecart] at @s run function test:battle/ui/item_cart_tick
execute as @e[tag=enemy] at @s run function test:status/hp_display_tick
execute in test:turn as @e[tag=enemy,tag=!battle_member,distance=0..,scores={test.status.hp=1..}] at @s if data entity @s data.ai_field_enabled run function test:battle/field_ai/tick

# 防具の自動発動の魔法(イベントの最中には唱えず、test:equip/proc/queueがタグで予約したものをここで唱える)
execute as @a[scores={test.equip.has_watch=1}] at @s run function test:equip/proc/watch_check
# ターン制の戦闘中の予約は、手番の終わり(test:battle/proc_all)で実行する
execute as @a[tag=equip_proc_queued] at @s unless score @s test.battle.id matches 1.. run function test:equip/proc/run

# 召喚と同じtick内でtextを設定するとクライアントに反映されないことがあるため、次のtickで確定させる
# (毎ticktpして浮き上がらせる案は、tpのたびにtextの描画が崩れることが判明したため不採用。静止表示のみ)
execute as @e[tag=damage_pop_text_pending] run data modify entity @s text set value {text:"",extra:[{score:{name:"@s",objective:"test.damage_pop.value"},color:"red"}]}
tag @e[tag=damage_pop_text_pending] remove damage_pop_text_pending

execute as @e[tag=damage_pop] run scoreboard players remove @s test.damage_pop.life 1
execute as @e[tag=damage_pop,scores={test.damage_pop.life=..0}] run tag @s add kill

function test:debug/tick
execute as @a[tag=downed] run function test:status/downed_tick

scoreboard players add @e[tag=time] test.time 1

# 全体共通の1秒クロック。バフ/デバフの継続時間は「秒」で持っているためここで進める
scoreboard players add #clock test.time 1
execute if score #clock test.time matches 20.. run scoreboard players set #clock test.time 0
execute if score #clock test.time matches 0 run function test:buff/tick_second_all

execute as @e[tag=executer] at @s rotated as @n[tag=Temp] run teleport @s ~ ~ ~ ~ ~

tag @e[tag=executer] remove executer

# ターン制の戦闘の外(test:action・フィールドの先制攻撃など)で倒した敵の報酬を、近くのプレイヤーに渡す
# (戦闘中の敵は手番の終わりに test:battle/proc_all が渡す。ダミーは報酬を持たない)
execute as @e[tag=kill,tag=enemy,tag=!battle_member,tag=!dummy] at @s run function test:reward/field_kill

# 死亡するエンティティに騎乗しているtext_display(HP表示等)は道連れにしないと取り残されるため、
# 同じタイミングでkillタグを付けてまとめて消す
execute as @e[tag=kill] on passengers run tag @s add kill

scoreboard players reset @e[tag=kill]
kill @e[tag=kill]
