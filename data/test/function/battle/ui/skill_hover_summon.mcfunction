#> test:battle/ui/skill_hover_summon
# @s = メインハンドに「スキル」アイテムを持っているプレイヤー。目線の位置にトロッコを新規召喚する
# (自己=glass_bottle、投射=snowball。素材と同じアイコンで統一)
# 「スキル」の選択自体はメインハンドに持っているだけで検知するため、右クリックとの競合はない

execute anchored eyes positioned ^ ^-0.35 ^ run summon chest_minecart ~ ~ ~ {Tags:[skill_minecart],NoGravity:1b,Invulnerable:1b}

data modify entity @n[tag=skill_minecart] Items append value {Slot:0b,id:"glass_bottle",count:1,components:{"minecraft:custom_name":{text:"自己",italic:false},"minecraft:custom_data":{test:{skill_choice:"self"}}}}
data modify entity @n[tag=skill_minecart] Items append value {Slot:1b,id:"snowball",count:1,components:{"minecraft:custom_name":{text:"投射",italic:false},"minecraft:custom_data":{test:{skill_choice:"projectile"}}}}
