#> test:battle/action/skill_cast/refused
# @s = 手番のプレイヤー。組み立てた魔法が今の禁止設定(battle:0b)に該当したので、使わずに行動の選び直しに戻す
# (手番は終えない。test:battle/action/passive_refusedと同じ戻し方。data.turnやキャッシュを壊すreopen_turn/open_player_turnは使わない)

tellraw @s [{text:"使えない魔法",color:gray}]
function test:battle/ui/cleanup
execute if score @s test.settings.battle_ui matches 1 run function test:battle/ui/chat
execute if score @s test.settings.battle_ui matches 2 run function test:battle/ui/item
