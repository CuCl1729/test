#> test:battle/action/passive_refused
# @s = 手番のプレイヤー。選んだ職業スキルがパッシブ(古い一覧やアイテムから選ばれた)なので、何も使わずに
# 行動の選び直しに戻す(手番は終えない。test:battle/action/no_target と同じ戻し方)

tellraw @s [{text:"使えないスキル",color:gray}]
function test:battle/ui/cleanup
execute if score @s test.settings.battle_ui matches 1 run function test:battle/ui/chat
execute if score @s test.settings.battle_ui matches 2 run function test:battle/ui/item
