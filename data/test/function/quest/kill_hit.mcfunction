#> test:quest/kill_hit
# @s = 倒した敵。@macro id/stage/need/main: 討伐の段階。サブは報酬を受け取る人(tag=battle_reward_recipient)それぞれの数を1増やし、
# メインは1体につき1回だけ増やす(状態はパーティで共有なので、受け取る人の1人として処理する)

$execute if data storage test: asset.quest.$(id){main:1b} run return run execute as @p[tag=battle_reward_recipient] run function test:quest/hit {id:"$(id)",stage:$(stage),need:$(need),add:1}
$execute as @a[tag=battle_reward_recipient] run function test:quest/hit_p {id:"$(id)",stage:$(stage),need:$(need)}
