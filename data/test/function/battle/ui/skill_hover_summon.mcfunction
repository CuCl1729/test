#> test:battle/ui/skill_hover_summon
# @s = メインハンドに「スキル」アイテムを持っているプレイヤー。目線の位置にトロッコを新規召喚し、
# レジストリ駆動でタイプ選択の中身を詰める
# 「スキル」の選択自体はメインハンドに持っているだけで検知するため、右クリックとの競合はない

execute anchored eyes positioned ^ ^-0.35 ^ run summon chest_minecart ~ ~ ~ {Tags:[skill_minecart],NoGravity:1b,Invulnerable:1b}

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select

function test:battle/ui/skill_type_minecart_populate
