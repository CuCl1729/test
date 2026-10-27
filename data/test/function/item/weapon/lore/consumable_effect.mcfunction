#> test:item/weapon/lore/consumable_effect
# @macro kind: 消耗品の効果の種類。効果の説明の1行を test:consumable/lore/<kind> に描かせる(paramsは効果と同じ)

$function test:consumable/lore/$(kind) with storage test: consumable_work.lore.params
