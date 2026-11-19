#> test:battle/reward_flush
# @s = 手番の外で倒れた戦闘中の敵(battle_reward_pending のまま、このtickの終わりに消える。at @s)。test:tick から呼ぶ。
# バフの効果切れ(場から出たときなど)は手番の終わりを通らないので、test:battle/proc_all と同じく
# その戦闘の参加者全員へ報酬を渡す。grant_reward が保留の印を外すので、二重には渡らない

scoreboard players operation #flush_battle test.battle.id = @s test.battle.id
execute as @a[tag=battle_member] if score @s test.battle.id = #flush_battle test.battle.id run tag @s add battle_reward_recipient
function test:battle/grant_reward
tag @a remove battle_reward_recipient
