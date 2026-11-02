# NPC dialogue

Right clicking a talking NPC prints the node text in chat with clickable choices. A click advances to the
next node. Choices whose condition fails are hidden. Buttons from earlier screens do nothing. Moving more
than 8 blocks away ends the talk.

## Sub-features

- `talk-start` right click starts the entry node chosen by the NPC's `入口` conditions.
- `talk-choice` a choice button goes to its node; `[次へ]` goes to `次`.
- `talk-speaker` the NPC name, the player's own name (`player`) or narration (no speaker) is shown.
- `talk-hidden` a choice whose condition fails is not shown.
- `talk-stale` a button from an earlier screen does nothing.
- `talk-range` the talk ends when the player is more than 8 blocks away.

## How to get to it (user POV)

- Right click the elder or the herbalist.
- Sneak + right click the shopkeeper (a shop NPC with an entry).

## Driving it with mc.ps1

Preconditions:

- The baseline is met, the player is flying, and the quest `patrol` is `none`. Reset it with
  `test:debug/quest_op {id:"patrol",op:"reset"}`.

- **Start.** Run `MC -Cmd "/tp @s 0.5 0.2 -12.5 180 0"` and `MC -Click <center> -Right`. The log shows
  `[村長] ようこそ、旅の人。` followed by `[村のことを聞く] [見回りを手伝う] [村の行く末について] [話を終える]`.
- **Choose.** Run `MC -Keys "t"` and `MC -Shot …`, find `[村のことを聞く]`, and run `MC -Click x,y`. The log
  shows `[test.talk]をトリガーしました（値を<seq>1…）` and `[村長] この村は小さいが、皆で支え合っておる。`.
- **Stale button.** Click the earlier `[見回りを手伝う]` line. The log shows only the trigger line and no new
  node.
- **Walk through.** Click the newest `[次へ]` three times. The log shows `[<player name>] なるほど。`, then
  `[村長] また来なされ。`, then the gray narration `村長はゆっくりとうなずいた。`, with no buttons after it.
- **Hidden choice.** Complete `patrol` (see quests.md) and talk again. `[見回りを手伝う]` is gone.
- **Proof.** Run `MC -Since $N -Save "$TEMP/mc-verify/<run>/npc-dialogue.txt"`.

## Gotchas

- The click position comes from a shot. The chat stays open after a click, and new lines push older ones up
  by about 18 px each.
- If the player sinks or drifts more than 8 blocks away, the talk silently ends. Then a later click only logs
  the trigger. Fly before talking.
- A click that lands on a plain line, not a button, does nothing. Check the log before you click again.
- The 全員 (party) nodes need every online player within 16 blocks. With one player this is always true, so
  test it with 2 players by hand.
