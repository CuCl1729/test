#> test:battle/join
# @s を、最も近くの入り口マーカーの戦闘へ参加させ、対応するエリアへ転送する

execute if entity @s[type=player] unless score @s test.settings.battle_ui matches 1.. run scoreboard players set @s test.settings.battle_ui 2

execute if score @s test.battle.id matches 1.. run return 0

scoreboard players operation @s test.battle.id = @e[tag=battle_entrance,sort=nearest,limit=1] test.battle.id
scoreboard players operation @s test.battle.arena = @e[tag=battle_entrance,sort=nearest,limit=1] test.battle.arena

# battle_memberタグは次元をまたぐテレポート(enter_arena内)の前に付与する。
# テレポート後に付けると、プレイヤー以外のエンティティではタグが反映されないことがある。
tag @s add battle_member

# y座標は構造物の原点(y:100、test:battle/start参照)より1高い位置に着地させる(床が原点の1つ上に生成されるため)
execute if score @s test.battle.arena matches 1 in test:arena run function test:battle/enter_arena {x:0,y:101,z:0}
execute if score @s test.battle.arena matches 2 in test:arena run function test:battle/enter_arena {x:500,y:101,z:0}
execute if score @s test.battle.arena matches 3 in test:arena run function test:battle/enter_arena {x:1000,y:101,z:0}
execute if score @s test.battle.arena matches 4 in test:arena run function test:battle/enter_arena {x:1500,y:101,z:0}
