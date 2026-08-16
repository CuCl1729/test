#> test:battle/ui/skill_minecart_poll
# @s = 戦闘マーカー。トロッコからアイテムが取られていないか毎tick確認する

execute unless entity @e[tag=skill_minecart,nbt={Items:[{Slot:0b}]}] if entity @e[tag=skill_minecart] run function test:battle/ui/skill_minecart_resolve {type:"self"}
execute unless entity @e[tag=skill_minecart,nbt={Items:[{Slot:1b}]}] if entity @e[tag=skill_minecart] run function test:battle/ui/skill_minecart_resolve {type:"projectile"}
