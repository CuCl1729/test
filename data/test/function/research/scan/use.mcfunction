#> test:research/scan/use
# @s = 観測鏡で右クリックを押しているプレイヤー(test:trigger/right_click/mainhand から毎tick。oh_my_dat は @s を指している)。
# 視線の先(5ブロックまで)のエンティティかブロック、何も無ければ左手のアイテムを調べる。同じものを20tick見続けると調べ終わる。
# 観測鏡はエンティティに触れる距離を0にしてあるので、敵や採取ポイントに向けて押してもエンティティへの右クリックにならない

execute store result score #scan_now test.temporary run time query gametime
# 押し始め(前に押していたのが2tickより前)なら、見ているものを忘れて数え直す
scoreboard players add @s test.research.scan_last 0
scoreboard players operation #scan_gap test.temporary = #scan_now test.temporary
scoreboard players operation #scan_gap test.temporary -= @s test.research.scan_last
scoreboard players operation @s test.research.scan_last = #scan_now test.temporary
execute unless score #scan_gap test.temporary matches 1..2 run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.scan_target set value ""

data modify storage test: research_work.found set value ""
scoreboard players set #scan_hit test.temporary 0
scoreboard players set #scan_ray test.temporary 50
execute at @s anchored eyes positioned ^ ^ ^ anchored feet run function test:research/scan/ray
execute if score #scan_hit test.temporary matches 0 run function test:research/scan/offhand
execute if data storage test: research_work{found:""} run return run function test:research/scan/none

# 見ているものが変わったら数え直す
data modify storage test: research_work.cmp set value ""
data modify storage test: research_work.cmp set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.scan_target
execute store success score #scan_changed test.temporary run data modify storage test: research_work.cmp set from storage test: research_work.found
execute if score #scan_changed test.temporary matches 1 run scoreboard players operation @s test.research.scan_start = #scan_now test.temporary
execute if score #scan_changed test.temporary matches 1 run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.scan_target set from storage test: research_work.found

scoreboard players operation #scan_t test.temporary = #scan_now test.temporary
scoreboard players operation #scan_t test.temporary -= @s test.research.scan_start
function test:research/scan/progress with storage test: research_work
