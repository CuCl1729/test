#> test:battle/action/skill_cast/apply_self
# @s = 詠唱者。組み立て済みの magic.player をそのまま自分に唱える(回復とバフ)。
# 手番の行動(test:battle/action/skill_cast/self)と防具の自動発動(test:equip/proc/cast_battle)の両方で使う。手番は終えない

# 消費MP(反動・魔導掌握込み)はリアルタイムと同じ test:magic/pay で払う
scoreboard players set #skill_sufficient test.temporary 0
execute store result score #skill_sufficient test.temporary run function test:magic/pay
execute if score #skill_sufficient test.temporary matches 0 run return run tellraw @s [{text:"MPが足りません",color:gray}]

# 防具のセット効果(magic_cast)。自己タイプもリアルタイムと同じく詠唱したことになる
execute if entity @s[type=player] run function test:equip/event {event:"magic_cast"}

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は自分に魔法を唱えた！",color:light_purple}]
execute if data storage test: magic.player.heal run function test:battle/action/skill_cast/heal_target

# 選んだバフを自分に付与する。自己タイプは支援系の効果しか組み合わせられないため振り分けは不要
execute if data storage test: magic.player.buff[0] run data modify storage test: buff_work.pending set from storage test: magic.player.buff
execute if data storage test: magic.player.buff[0] run function test:buff/apply_list
