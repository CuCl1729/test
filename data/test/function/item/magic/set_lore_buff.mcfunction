#> test:item/magic/set_lore_buff
# @macro id: 付与するバフid / stacks: スタック数
# 表示名・色・継続時間はバフのレジストリ(test:init/asset/buff/buffs)から引くため、
# バフを増やしてもここは無改修で済む

data remove storage test: registry_work.lore_buff_reg
$data modify storage test: registry_work.lore_buff_reg set from storage test: asset.buff.types[{id:"$(id)"}]
$execute if data storage test: registry_work.lore_buff_reg.label run data modify storage test: registry_work.lore_buff_reg.stacks set value $(stacks)

execute if data storage test: registry_work.lore_buff_reg.label run function test:item/magic/set_lore_buff_line with storage test: registry_work.lore_buff_reg
