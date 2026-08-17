#> test:battle/ui/target_hover_show
# @s = 対象選択中のプレイヤー。持ち手のアイテムに関係なく、対象選択トロッコを目線の位置に追従させる

execute anchored eyes positioned ^ ^-0.35 ^ run tp @e[tag=target_minecart,sort=nearest,limit=1] ~ ~ ~
