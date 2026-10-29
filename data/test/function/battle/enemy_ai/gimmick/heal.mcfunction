#> test:battle/enemy_ai/gimmick/heal
# @s = 手番の敵。@macro percent: 回復量(最大HPの何%)。自分のHPを回復する

scoreboard players operation #heal_before test.temporary = @s test.status.hp
$function test:consumable/heal {stat:"hp",percent:$(percent),flat:0}
scoreboard players operation #heal_amount test.temporary = @s test.status.hp
scoreboard players operation #heal_amount test.temporary -= #heal_before test.temporary
scoreboard players operation #heal_amount test.temporary /= #100 test.constant

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は",color:gray},{score:{name:"#heal_amount",objective:"test.temporary"},color:green},{text:"回復した！",color:gray}]

function test:battle/turn_end
