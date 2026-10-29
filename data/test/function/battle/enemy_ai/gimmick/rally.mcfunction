#> test:battle/enemy_ai/gimmick/rally
# @s = 手番の敵。@macro buff/stacks: 付けるバフと段数。同じ戦闘で生きている敵全員(自分も含む)にバフを付ける

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は仲間を鼓舞した！",color:gold}]

scoreboard players operation #rally_battle test.battle.id = @s test.battle.id
$execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] if score @s test.battle.id = #rally_battle test.battle.id run function test:buff/apply {id:"$(buff)",stacks:$(stacks)}

function test:battle/turn_end
