# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:quest/generated/kill
# 討伐の段階(@s = 倒した敵。test:battle/grant_reward から。報酬を受け取る人は tag=battle_reward_recipient)

execute if entity @s[tag=goblin] run function test:quest/kill_hit {id:"herb",stage:1,need:3,main:0b}
