#> test:equip/add_entry
# @s = プレイヤー。@macro type: ステータスの種類。storage test: equip_work.entry.value を×100して test.equip.<type> に足す
# (test.equip.<type>が無い種類は、目的変数が無いのでこの行だけが失敗して足されない)

execute store result score #equip_v test.temporary run data get storage test: equip_work.entry.value 100
$scoreboard players operation @s test.equip.$(type) += #equip_v test.temporary
