#> test:battle/ui/skill_hover_summon
# @s = メインハンドに「スキル」アイテムを持っているプレイヤー。目線の位置にトロッコを新規召喚し、
# 魔法と職業/剣のアクティブスキルの両方が使える場合は先に2択のカートを、片方だけなら
# 直接そちらの一覧を出す(レジストリ駆動でタイプ選択の中身を詰める)
# 「スキル」の選択自体はメインハンドに持っているだけで検知するため、右クリックとの競合はない

execute anchored eyes positioned ^ ^-0.35 ^ run summon chest_minecart ~ ~ ~ {Tags:[skill_minecart],NoGravity:1b,Invulnerable:1b}

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select

function test:battle/action/skill_category_count

execute if score #has_magic test.temporary matches 1 if score #has_active_skill test.temporary matches 0 run return run function test:battle/ui/skill_type_minecart_populate
execute if score #has_magic test.temporary matches 0 if score #has_active_skill test.temporary matches 1 run return run function test:battle/ui/active_skill_minecart_populate

function test:battle/ui/skill_category_minecart_populate
