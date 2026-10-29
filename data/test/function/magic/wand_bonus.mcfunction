#> test:magic/wand_bonus
# @s = 詠唱者。両手に持った武器(杖など)の「魔法ダメージ%」(custom_data.magic_damage_bonus)の合計を
# test.magic.wand_bonus に入れる(test:magic/prepare_damage が魔法の与ダメ補正に足す)。
# プレイヤー以外は0。戦闘中に手に行動UIを持っているときは、手番の始めに計算した値のまま(test:status/ui_in_hand)

execute unless entity @s[type=player] run return run scoreboard players set @s test.magic.wand_bonus 0
execute if function test:status/ui_in_hand run return 0

function #oh_my_dat:please
scoreboard players set @s test.magic.wand_bonus 0
scoreboard players set #wand_offhand test.temporary 0
execute store result score @s test.magic.wand_bonus run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".magic_damage_bonus
execute store result score #wand_offhand test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components."minecraft:custom_data".magic_damage_bonus
scoreboard players operation @s test.magic.wand_bonus += #wand_offhand test.temporary
