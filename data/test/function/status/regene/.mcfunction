execute unless score @s test.status.hp_max matches 1.. run function test:init/player
# 防御側の初期値が追加される前に作られたプレイヤー向け(未設定のときだけ一度入れる)
execute unless score @s test.def.coefficient matches 1.. run function test:init/asset/status/defense

function test:status/level_up

# ターン制のマップ(test:turn とその戦闘用アリーナ test:arena)にいる間は毎秒の回復を止める
# (回復魔法が意味を持たなくなるため)。代わりにbattle/turn_start_playerで
# 手番が回ってくるたびに1回だけ回復させる。ダウン中も回復しない(蘇生でだけ起き上がるように)
execute unless entity @s[tag=downed] unless dimension test:turn unless dimension test:arena run function test:status/regene/hp
execute unless entity @s[tag=downed] unless dimension test:turn unless dimension test:arena run function test:status/regene/mp

scoreboard players operation @s test.status.burnout -= @s test.status.divergence

execute if score @s test.status.burnout matches ..-1 run scoreboard players set @s test.status.burnout 0

advancement revoke @s only test:status/regene