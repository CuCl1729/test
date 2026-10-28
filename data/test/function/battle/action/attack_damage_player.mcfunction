#> test:battle/action/attack_damage_player
# @s = 攻撃するプレイヤー。手番の開始時に控えた武器の custom_data(battle.actor_weapon.item)で、リアルタイムと
# 同じ計算(test:attack/prepare_damage)をする。アイテム式UIはメインハンドが行動アイテムに入れ替わっているため、
# 手に持っている物は読まない。damage の無い物(素手・杖)は、攻撃力をそのまま物理ダメージにする

data modify storage test: attack.player set value {}
data modify storage test: attack.player set from storage test: battle.actor_weapon.item
execute unless data storage test: attack.player.damage run data modify storage test: attack.player.damage set value {physics:{atk:100}}

function test:attack/prepare_damage
