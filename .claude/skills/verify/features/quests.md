# Quests

A player accepts a quest through dialogue. Each stage advances by reaching an area, killing enemies,
delivering items to an NPC or talking to an NPC. The last stage pays the reward. `/trigger test.quest`
lists active quests with the bank and coin totals, and each step shows `<name>: <stage> n/m` on the action bar.

## Sub-features

- `quest-accept` a dialogue action `start:<id>` prints `クエスト開始: <name>`, with no quotes.
- `quest-reach` entering the area advances the stage. It is checked every second, in both maps.
- `quest-kill` a kill of the target enemy adds 1. See kill-rewards.md.
- `quest-deliver` talking to the NPC with enough items removes them and advances. With too few, nothing happens.
- `quest-talk` talking to the target NPC advances the stage.
- `quest-reward` completion prints `クエスト完了: <name>` and runs the reward: coins, items, flags, exp.
- `quest-main` a main quest is shared and completes for everyone.
- `quest-list` `/trigger test.quest` shows each active stage `n/m` and `口座 …G / コイン …G`.

## How to get to it (user POV)

- Accept from dialogue: elder `[見回りを手伝う]` (patrol), herbalist `[引き受ける]` (herb), elder
  `[村の行く末について]` (village, main).
- Type `/trigger test.quest` for the list.

## Driving it with mc.ps1

Preconditions:

- The baseline is met. The quest under test is `none`: reset it with `test:debug/quest_op`.

- **Accept patrol.** Talk to the elder and click `[見回りを手伝う]`. The log shows `クエスト開始: 見回り`.
- **Reach.** Run `MC -Cmd "/tp @s -15 1 -25"` and wait 2 s. The area is `-20 0 -30` to `-10 5 -20`.
  Then teleport back and right click the elder. The log shows `クエスト完了: 見回り` before the dialogue text.
- **Reward check.** Run `MC -Cmd "/trigger test.quest"` and `MC -Cmd "/function test:debug/flags"`. The coins
  rose by 20 and the personal flags show `{patrolled: 1}`.
- **Deliver, short.** With herb at stage 2, use `quest_op advance` to skip the kills and give 2 herbs with
  `test:item/material/give {id:"herb_leaf",count:2}`. Right click the herbalist. The log shows only `[薬師]
  ゴブリンを倒して、薬草を3つ持ってきてね。`, and the stage stays 0/3.
- **Deliver, enough.** Give 1 more and talk again. The log shows `クエスト完了: 薬草集め`. Then
  `/clear @s *[custom_data~{test:{material:{kind:"herb_leaf"}}}] 0` finds none, and healing potions rose by 2.
- **Main quest.** Accept `[村の行く末について]`, then right click the elder again. The log shows `クエスト完了:
  村の決断` and the 全員 node `[村長] 村の行く末を、皆で決めてほしい。` with `[森を守る] [鉱山を広げる]`.
  Click `[森を守る]`. `test:debug/flags` shows the story flags `{decided: 1, path: 1}`.
- **Proof.** Run `MC -Since $N -Save "$TEMP/mc-verify/<run>/quests.txt"`.

## Gotchas

- The `notify` action-bar line is not in the log. Prove the progress with `/trigger test.quest`, and take a
  shot only when the action bar itself is the claim.
- Completed quests stay done. Reset them with `quest_op … reset` before a rerun, and tell the user about any
  state you leave behind.
- Main-quest state is shared world state (`storage test: story`). Story flags cannot be reset from the quest
  buttons; use `test:debug/flag_set`.
