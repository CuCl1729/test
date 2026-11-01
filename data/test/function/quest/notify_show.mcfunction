#> test:quest/notify_show
# @s = プレイヤー。@macro name/desc/c/n/tgt: 表示する中身と、出す相手(@s か、メインなら @a)

$execute as $(tgt) store success score @s test.ui.bar_shown run execute store success score @s test.ui.bar_shown run title @s actionbar [{text:"$(name): ",color:"gold"},{text:"$(desc) ",color:"white"},{text:"$(c)/$(n)",color:"aqua"}]
$execute as $(tgt) at @s run playsound minecraft:entity.experience_orb.pickup master @s
