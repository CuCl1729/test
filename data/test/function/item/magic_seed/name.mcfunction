#> test:item/magic_seed/name
# @macro name: 魔法作物の名前(ほかのキーも渡ってくるが使わない)。種の名前を「<名前>の種」にする

$data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"$(name)の種",italic:false}
