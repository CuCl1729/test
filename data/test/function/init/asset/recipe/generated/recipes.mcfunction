# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/recipe/generated/recipes
# カスタムクラフターのレシピ(スプレッドシートの「レシピ」タブ)。asset.recipe.<id> = {id, name, shape_text, mat_text, out:{kind,id,count}, pred, locked?, inputs}、
# asset.recipe_index."<9マスのキー>" = {recipe, need:[9マスの必要数]}(形を3×3の置ける位置すべてに置いたもの)。作るのは test:craft/custom/

data modify storage test: asset.recipe.factory_key set value {id:"factory_key",name:"工場の鍵",shape_text:".a./.a./.b.",mat_text:"a=material:copper_ingot; b=material:iron_ingot",out:{kind:"factory_key",id:"factory_key",count:1},pred:"*[minecraft:custom_data~{test:{factory_key:1b}}]",inputs:[{kind:"material",id:"copper_ingot",count:2},{kind:"material",id:"iron_ingot",count:1}]}
data modify storage test: asset.recipe_ids append value "factory_key"
data modify storage test: asset.recipe.scanner set value {id:"scanner",name:"観測鏡",shape_text:".a./aba/.a.",mat_text:"a=material:copper_ingot; b=material:mana_shard",out:{kind:"scanner",id:"scanner",count:1},pred:"*[minecraft:custom_data~{test:{scanner:1b}}]",inputs:[{kind:"material",id:"copper_ingot",count:4},{kind:"material",id:"mana_shard",count:1}]}
data modify storage test: asset.recipe_ids append value "scanner"
data modify storage test: asset.recipe.casing_copper set value {id:"casing_copper",name:"銅の筐体",shape_text:"aaa/a.a/aaa",mat_text:"a=material:copper_ingot*2",out:{kind:"machine_part",id:"casing_copper",count:4},pred:"*[minecraft:custom_data~{test:{machine_item:\"casing_copper\"}}]",inputs:[{kind:"material",id:"copper_ingot",count:16}]}
data modify storage test: asset.recipe_ids append value "casing_copper"
data modify storage test: asset.recipe.casing_iron set value {id:"casing_iron",name:"鉄の筐体",shape_text:"aaa/a.a/aaa",mat_text:"a=material:iron_ingot*2",out:{kind:"machine_part",id:"casing_iron",count:4},pred:"*[minecraft:custom_data~{test:{machine_item:\"casing_iron\"}}]",inputs:[{kind:"material",id:"iron_ingot",count:16}],locked:1b}
data modify storage test: asset.recipe_ids append value "casing_iron"
data modify storage test: asset.recipe.port_in set value {id:"port_in",name:"搬入口",shape_text:"aaa/a.a/a.a",mat_text:"a=material:copper_ingot",out:{kind:"machine_part",id:"port_in",count:1},pred:"*[minecraft:custom_data~{test:{machine_item:\"port_in\"}}]",inputs:[{kind:"material",id:"copper_ingot",count:7}]}
data modify storage test: asset.recipe_ids append value "port_in"
data modify storage test: asset.recipe.port_out set value {id:"port_out",name:"搬出口",shape_text:"a.a/a.a/aaa",mat_text:"a=material:copper_ingot",out:{kind:"machine_part",id:"port_out",count:1},pred:"*[minecraft:custom_data~{test:{machine_item:\"port_out\"}}]",inputs:[{kind:"material",id:"copper_ingot",count:7}]}
data modify storage test: asset.recipe_ids append value "port_out"
data modify storage test: asset.recipe.wrench set value {id:"wrench",name:"レンチ",shape_text:"a.a/.a./.b.",mat_text:"a=material:iron_ingot; b=vanilla:stick",out:{kind:"wrench",id:"wrench",count:1},pred:"*[minecraft:custom_data~{test:{machine_item:\"wrench\"}}]",inputs:[{kind:"material",id:"iron_ingot",count:3},{kind:"vanilla",id:"stick",count:1}]}
data modify storage test: asset.recipe_ids append value "wrench"
data modify storage test: asset.recipe.crusher_egg set value {id:"crusher_egg",name:"粉砕機",shape_text:"aba/bcb/aba",mat_text:"a=material:iron_ingot; b=material:stone_dust; c=material:steel",out:{kind:"machine_egg",id:"crusher",count:1},pred:"*[minecraft:custom_data~{test:{egg:\"machine:crusher\"}}]",inputs:[{kind:"material",id:"iron_ingot",count:4},{kind:"material",id:"stone_dust",count:4},{kind:"material",id:"steel",count:1}],locked:1b}
data modify storage test: asset.recipe_ids append value "crusher_egg"
data modify storage test: asset.recipe.smelter_egg set value {id:"smelter_egg",name:"精錬炉",shape_text:"aba/bcb/aba",mat_text:"a=material:iron_ingot; b=material:slag; c=material:pure_copper",out:{kind:"machine_egg",id:"smelter",count:1},pred:"*[minecraft:custom_data~{test:{egg:\"machine:smelter\"}}]",inputs:[{kind:"material",id:"iron_ingot",count:4},{kind:"material",id:"slag",count:4},{kind:"material",id:"pure_copper",count:1}],locked:1b}
data modify storage test: asset.recipe_ids append value "smelter_egg"
data modify storage test: asset.recipe.novice_pickaxe set value {id:"novice_pickaxe",name:"見習いのツルハシ",shape_text:"aaa/.b./.b.",mat_text:"a=material:copper_ingot; b=vanilla:stick",out:{kind:"pickaxe",id:"novice_pickaxe",count:1},pred:"*[minecraft:custom_data~{test:{pickaxe:{id:\"novice_pickaxe\"}}}]",inputs:[{kind:"material",id:"copper_ingot",count:3},{kind:"vanilla",id:"stick",count:2}]}
data modify storage test: asset.recipe_ids append value "novice_pickaxe"
data modify storage test: asset.recipe.miner_pickaxe set value {id:"miner_pickaxe",name:"鉱夫のツルハシ",shape_text:"aaa/.b./.b.",mat_text:"a=material:iron_ingot; b=vanilla:stick",out:{kind:"pickaxe",id:"miner_pickaxe",count:1},pred:"*[minecraft:custom_data~{test:{pickaxe:{id:\"miner_pickaxe\"}}}]",inputs:[{kind:"material",id:"iron_ingot",count:3},{kind:"vanilla",id:"stick",count:2}]}
data modify storage test: asset.recipe_ids append value "miner_pickaxe"
data modify storage test: asset.recipe.copper_sickle set value {id:"copper_sickle",name:"銅の鎌",shape_text:".aa/.b./b..",mat_text:"a=material:copper_ingot; b=vanilla:stick",out:{kind:"gather_tool",id:"copper_sickle",count:1},pred:"*[minecraft:custom_data~{test:{gather_tool:{id:\"copper_sickle\"}}}]",inputs:[{kind:"material",id:"copper_ingot",count:2},{kind:"vanilla",id:"stick",count:2}]}
data modify storage test: asset.recipe_ids append value "copper_sickle"
data modify storage test: asset.recipe.iron_sickle set value {id:"iron_sickle",name:"鉄の鎌",shape_text:".aa/.b./b..",mat_text:"a=material:iron_ingot; b=vanilla:stick",out:{kind:"gather_tool",id:"iron_sickle",count:1},pred:"*[minecraft:custom_data~{test:{gather_tool:{id:\"iron_sickle\"}}}]",inputs:[{kind:"material",id:"iron_ingot",count:2},{kind:"vanilla",id:"stick",count:2}]}
data modify storage test: asset.recipe_ids append value "iron_sickle"
data modify storage test: asset.recipe.earth_seed set value {id:"earth_seed",name:"土の作物の種",shape_text:".a./aba/.a.",mat_text:"a=material:herb_leaf; b=material:earth_essence",out:{kind:"magic_seed",id:"earth_crop",count:2},pred:"*[minecraft:custom_data~{test:{magic_seed:\"earth_crop\"}}]",inputs:[{kind:"material",id:"herb_leaf",count:4},{kind:"material",id:"earth_essence",count:1}]}
data modify storage test: asset.recipe_ids append value "earth_seed"
data modify storage test: asset.recipe.water_seed set value {id:"water_seed",name:"水の作物の種",shape_text:".a./aba/.a.",mat_text:"a=material:herb_leaf; b=material:water_essence",out:{kind:"magic_seed",id:"water_crop",count:2},pred:"*[minecraft:custom_data~{test:{magic_seed:\"water_crop\"}}]",inputs:[{kind:"material",id:"herb_leaf",count:4},{kind:"material",id:"water_essence",count:1}]}
data modify storage test: asset.recipe_ids append value "water_seed"
data modify storage test: asset.recipe.wheat_seeds set value {id:"wheat_seeds",name:"小麦の種",shape_text:"a../.../...",mat_text:"a=material:herb_leaf",out:{kind:"vanilla",id:"wheat_seeds",count:2},pred:"minecraft:wheat_seeds",inputs:[{kind:"material",id:"herb_leaf",count:1}]}
data modify storage test: asset.recipe_ids append value "wheat_seeds"
data modify storage test: asset.recipe.carrot set value {id:"carrot",name:"ニンジン",shape_text:"a../.../...",mat_text:"a=material:medicinal_root",out:{kind:"vanilla",id:"carrot",count:1},pred:"minecraft:carrot",inputs:[{kind:"material",id:"medicinal_root",count:1}]}
data modify storage test: asset.recipe_ids append value "carrot"
data modify storage test: asset.recipe.potato set value {id:"potato",name:"ジャガイモ",shape_text:"ab./.../...",mat_text:"a=material:medicinal_root; b=material:herb_leaf",out:{kind:"vanilla",id:"potato",count:1},pred:"minecraft:potato",inputs:[{kind:"material",id:"medicinal_root",count:1},{kind:"material",id:"herb_leaf",count:1}]}
data modify storage test: asset.recipe_ids append value "potato"
data modify storage test: asset.recipe.beetroot_seeds set value {id:"beetroot_seeds",name:"ビートルートの種",shape_text:"a../.../...",mat_text:"a=material:flower_petal",out:{kind:"vanilla",id:"beetroot_seeds",count:2},pred:"minecraft:beetroot_seeds",inputs:[{kind:"material",id:"flower_petal",count:1}]}
data modify storage test: asset.recipe_ids append value "beetroot_seeds"
data modify storage test: asset.recipe.power_rune set value {id:"power_rune",name:"力のルーン",shape_text:".a./aba/.a.",mat_text:"a=material:mana_shard; b=material:bone",out:{kind:"rune",id:"power_rune",count:1},pred:"*[minecraft:custom_data~{test:{rune:\"power_rune\"}}]",inputs:[{kind:"material",id:"mana_shard",count:4},{kind:"material",id:"bone",count:1}]}
data modify storage test: asset.recipe_ids append value "power_rune"
data modify storage test: asset.recipe.guard_rune set value {id:"guard_rune",name:"守りのルーン",shape_text:".a./aba/.a.",mat_text:"a=material:mana_shard; b=material:goblin_hide",out:{kind:"rune",id:"guard_rune",count:1},pred:"*[minecraft:custom_data~{test:{rune:\"guard_rune\"}}]",inputs:[{kind:"material",id:"mana_shard",count:4},{kind:"material",id:"goblin_hide",count:1}]}
data modify storage test: asset.recipe_ids append value "guard_rune"
data modify storage test: asset.recipe.vigor_rune set value {id:"vigor_rune",name:"活力のルーン",shape_text:".a./aba/.a.",mat_text:"a=material:mana_shard; b=material:medicinal_root",out:{kind:"rune",id:"vigor_rune",count:1},pred:"*[minecraft:custom_data~{test:{rune:\"vigor_rune\"}}]",inputs:[{kind:"material",id:"mana_shard",count:4},{kind:"material",id:"medicinal_root",count:1}]}
data modify storage test: asset.recipe_ids append value "vigor_rune"
data modify storage test: asset.recipe.mana_rune set value {id:"mana_rune",name:"知識のルーン",shape_text:".a./aaa/.a.",mat_text:"a=material:mana_shard",out:{kind:"rune",id:"mana_rune",count:1},pred:"*[minecraft:custom_data~{test:{rune:\"mana_rune\"}}]",inputs:[{kind:"material",id:"mana_shard",count:5}]}
data modify storage test: asset.recipe_ids append value "mana_rune"
data modify storage test: asset.recipe.healing_potion set value {id:"healing_potion",name:"回復薬",shape_text:"a../b../...",mat_text:"a=material:herb_leaf; b=material:small_fish",out:{kind:"consumable",id:"healing_potion",count:1},pred:"*[minecraft:custom_data~{test:{consumable:\"healing_potion\"}}]",inputs:[{kind:"material",id:"herb_leaf",count:1},{kind:"material",id:"small_fish",count:1}]}
data modify storage test: asset.recipe_ids append value "healing_potion"
data modify storage test: asset.recipe.mana_dust set value {id:"mana_dust",name:"魔力の粉",shape_text:"ab./.../...",mat_text:"a=material:mana_shard; b=material:stone_dust",out:{kind:"consumable",id:"mana_dust",count:2},pred:"*[minecraft:custom_data~{test:{consumable:\"mana_dust\"}}]",inputs:[{kind:"material",id:"mana_shard",count:1},{kind:"material",id:"stone_dust",count:1}]}
data modify storage test: asset.recipe_ids append value "mana_dust"
data modify storage test: asset.recipe.power_dust set value {id:"power_dust",name:"力の粉",shape_text:"ab./.../...",mat_text:"a=material:bone; b=material:stone_dust",out:{kind:"consumable",id:"power_dust",count:2},pred:"*[minecraft:custom_data~{test:{consumable:\"power_dust\"}}]",inputs:[{kind:"material",id:"bone",count:1},{kind:"material",id:"stone_dust",count:1}]}
data modify storage test: asset.recipe_ids append value "power_dust"
data modify storage test: asset.recipe.revive_feather set value {id:"revive_feather",name:"蘇生の羽",shape_text:".a./aba/.a.",mat_text:"a=material:flower_petal; b=material:big_fish",out:{kind:"consumable",id:"revive_feather",count:1},pred:"*[minecraft:custom_data~{test:{consumable:\"revive_feather\"}}]",inputs:[{kind:"material",id:"flower_petal",count:4},{kind:"material",id:"big_fish",count:1}]}
data modify storage test: asset.recipe_ids append value "revive_feather"
data modify storage test: asset.recipe.earth_essence_iron set value {id:"earth_essence_iron",name:"土のエッセンスから鉄",shape_text:"aaa/a.a/aaa",mat_text:"a=material:earth_essence",out:{kind:"material",id:"iron_ingot",count:1},pred:"*[minecraft:custom_data~{test:{material:{kind:\"iron_ingot\"}}}]",inputs:[{kind:"material",id:"earth_essence",count:8}]}
data modify storage test: asset.recipe_ids append value "earth_essence_iron"
data modify storage test: asset.recipe.water_essence_mana set value {id:"water_essence_mana",name:"水のエッセンスから魔力",shape_text:"aaa/a.a/aaa",mat_text:"a=material:water_essence",out:{kind:"material",id:"mana_shard",count:1},pred:"*[minecraft:custom_data~{test:{material:{kind:\"mana_shard\"}}}]",inputs:[{kind:"material",id:"water_essence",count:8}]}
data modify storage test: asset.recipe_ids append value "water_essence_mana"
data modify storage test: asset.recipe_index."m:copper_ingot,,,m:copper_ingot,,,m:iron_ingot,," set value {recipe:"factory_key",need:[1,0,0,1,0,0,1,0,0]}
data modify storage test: asset.recipe_index.",m:copper_ingot,,,m:copper_ingot,,,m:iron_ingot," set value {recipe:"factory_key",need:[0,1,0,0,1,0,0,1,0]}
data modify storage test: asset.recipe_index.",,m:copper_ingot,,,m:copper_ingot,,,m:iron_ingot" set value {recipe:"factory_key",need:[0,0,1,0,0,1,0,0,1]}
data modify storage test: asset.recipe_index.",m:copper_ingot,,m:copper_ingot,m:mana_shard,m:copper_ingot,,m:copper_ingot," set value {recipe:"scanner",need:[0,1,0,1,1,1,0,1,0]}
data modify storage test: asset.recipe_index."m:copper_ingot,m:copper_ingot,m:copper_ingot,m:copper_ingot,,m:copper_ingot,m:copper_ingot,m:copper_ingot,m:copper_ingot" set value {recipe:"casing_copper",need:[2,2,2,2,0,2,2,2,2]}
data modify storage test: asset.recipe_index."m:iron_ingot,m:iron_ingot,m:iron_ingot,m:iron_ingot,,m:iron_ingot,m:iron_ingot,m:iron_ingot,m:iron_ingot" set value {recipe:"casing_iron",need:[2,2,2,2,0,2,2,2,2]}
data modify storage test: asset.recipe_index."m:copper_ingot,m:copper_ingot,m:copper_ingot,m:copper_ingot,,m:copper_ingot,m:copper_ingot,,m:copper_ingot" set value {recipe:"port_in",need:[1,1,1,1,0,1,1,0,1]}
data modify storage test: asset.recipe_index."m:copper_ingot,,m:copper_ingot,m:copper_ingot,,m:copper_ingot,m:copper_ingot,m:copper_ingot,m:copper_ingot" set value {recipe:"port_out",need:[1,0,1,1,0,1,1,1,1]}
data modify storage test: asset.recipe_index."m:iron_ingot,,m:iron_ingot,,m:iron_ingot,,,v:minecraft:stick," set value {recipe:"wrench",need:[1,0,1,0,1,0,0,1,0]}
data modify storage test: asset.recipe_index."m:iron_ingot,m:stone_dust,m:iron_ingot,m:stone_dust,m:steel,m:stone_dust,m:iron_ingot,m:stone_dust,m:iron_ingot" set value {recipe:"crusher_egg",need:[1,1,1,1,1,1,1,1,1]}
data modify storage test: asset.recipe_index."m:iron_ingot,m:slag,m:iron_ingot,m:slag,m:pure_copper,m:slag,m:iron_ingot,m:slag,m:iron_ingot" set value {recipe:"smelter_egg",need:[1,1,1,1,1,1,1,1,1]}
data modify storage test: asset.recipe_index."m:copper_ingot,m:copper_ingot,m:copper_ingot,,v:minecraft:stick,,,v:minecraft:stick," set value {recipe:"novice_pickaxe",need:[1,1,1,0,1,0,0,1,0]}
data modify storage test: asset.recipe_index."m:iron_ingot,m:iron_ingot,m:iron_ingot,,v:minecraft:stick,,,v:minecraft:stick," set value {recipe:"miner_pickaxe",need:[1,1,1,0,1,0,0,1,0]}
data modify storage test: asset.recipe_index.",m:copper_ingot,m:copper_ingot,,v:minecraft:stick,,v:minecraft:stick,," set value {recipe:"copper_sickle",need:[0,1,1,0,1,0,1,0,0]}
data modify storage test: asset.recipe_index.",m:iron_ingot,m:iron_ingot,,v:minecraft:stick,,v:minecraft:stick,," set value {recipe:"iron_sickle",need:[0,1,1,0,1,0,1,0,0]}
data modify storage test: asset.recipe_index.",m:herb_leaf,,m:herb_leaf,m:earth_essence,m:herb_leaf,,m:herb_leaf," set value {recipe:"earth_seed",need:[0,1,0,1,1,1,0,1,0]}
data modify storage test: asset.recipe_index.",m:herb_leaf,,m:herb_leaf,m:water_essence,m:herb_leaf,,m:herb_leaf," set value {recipe:"water_seed",need:[0,1,0,1,1,1,0,1,0]}
data modify storage test: asset.recipe_index."m:herb_leaf,,,,,,,," set value {recipe:"wheat_seeds",need:[1,0,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",m:herb_leaf,,,,,,," set value {recipe:"wheat_seeds",need:[0,1,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,m:herb_leaf,,,,,," set value {recipe:"wheat_seeds",need:[0,0,1,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,m:herb_leaf,,,,," set value {recipe:"wheat_seeds",need:[0,0,0,1,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,m:herb_leaf,,,," set value {recipe:"wheat_seeds",need:[0,0,0,0,1,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,m:herb_leaf,,," set value {recipe:"wheat_seeds",need:[0,0,0,0,0,1,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,,m:herb_leaf,," set value {recipe:"wheat_seeds",need:[0,0,0,0,0,0,1,0,0]}
data modify storage test: asset.recipe_index.",,,,,,,m:herb_leaf," set value {recipe:"wheat_seeds",need:[0,0,0,0,0,0,0,1,0]}
data modify storage test: asset.recipe_index.",,,,,,,,m:herb_leaf" set value {recipe:"wheat_seeds",need:[0,0,0,0,0,0,0,0,1]}
data modify storage test: asset.recipe_index."m:medicinal_root,,,,,,,," set value {recipe:"carrot",need:[1,0,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",m:medicinal_root,,,,,,," set value {recipe:"carrot",need:[0,1,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,m:medicinal_root,,,,,," set value {recipe:"carrot",need:[0,0,1,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,m:medicinal_root,,,,," set value {recipe:"carrot",need:[0,0,0,1,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,m:medicinal_root,,,," set value {recipe:"carrot",need:[0,0,0,0,1,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,m:medicinal_root,,," set value {recipe:"carrot",need:[0,0,0,0,0,1,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,,m:medicinal_root,," set value {recipe:"carrot",need:[0,0,0,0,0,0,1,0,0]}
data modify storage test: asset.recipe_index.",,,,,,,m:medicinal_root," set value {recipe:"carrot",need:[0,0,0,0,0,0,0,1,0]}
data modify storage test: asset.recipe_index.",,,,,,,,m:medicinal_root" set value {recipe:"carrot",need:[0,0,0,0,0,0,0,0,1]}
data modify storage test: asset.recipe_index."m:medicinal_root,m:herb_leaf,,,,,,," set value {recipe:"potato",need:[1,1,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",m:medicinal_root,m:herb_leaf,,,,,," set value {recipe:"potato",need:[0,1,1,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,m:medicinal_root,m:herb_leaf,,,," set value {recipe:"potato",need:[0,0,0,1,1,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,m:medicinal_root,m:herb_leaf,,," set value {recipe:"potato",need:[0,0,0,0,1,1,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,,m:medicinal_root,m:herb_leaf," set value {recipe:"potato",need:[0,0,0,0,0,0,1,1,0]}
data modify storage test: asset.recipe_index.",,,,,,,m:medicinal_root,m:herb_leaf" set value {recipe:"potato",need:[0,0,0,0,0,0,0,1,1]}
data modify storage test: asset.recipe_index."m:flower_petal,,,,,,,," set value {recipe:"beetroot_seeds",need:[1,0,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",m:flower_petal,,,,,,," set value {recipe:"beetroot_seeds",need:[0,1,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,m:flower_petal,,,,,," set value {recipe:"beetroot_seeds",need:[0,0,1,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,m:flower_petal,,,,," set value {recipe:"beetroot_seeds",need:[0,0,0,1,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,m:flower_petal,,,," set value {recipe:"beetroot_seeds",need:[0,0,0,0,1,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,m:flower_petal,,," set value {recipe:"beetroot_seeds",need:[0,0,0,0,0,1,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,,m:flower_petal,," set value {recipe:"beetroot_seeds",need:[0,0,0,0,0,0,1,0,0]}
data modify storage test: asset.recipe_index.",,,,,,,m:flower_petal," set value {recipe:"beetroot_seeds",need:[0,0,0,0,0,0,0,1,0]}
data modify storage test: asset.recipe_index.",,,,,,,,m:flower_petal" set value {recipe:"beetroot_seeds",need:[0,0,0,0,0,0,0,0,1]}
data modify storage test: asset.recipe_index.",m:mana_shard,,m:mana_shard,m:bone,m:mana_shard,,m:mana_shard," set value {recipe:"power_rune",need:[0,1,0,1,1,1,0,1,0]}
data modify storage test: asset.recipe_index.",m:mana_shard,,m:mana_shard,m:goblin_hide,m:mana_shard,,m:mana_shard," set value {recipe:"guard_rune",need:[0,1,0,1,1,1,0,1,0]}
data modify storage test: asset.recipe_index.",m:mana_shard,,m:mana_shard,m:medicinal_root,m:mana_shard,,m:mana_shard," set value {recipe:"vigor_rune",need:[0,1,0,1,1,1,0,1,0]}
data modify storage test: asset.recipe_index.",m:mana_shard,,m:mana_shard,m:mana_shard,m:mana_shard,,m:mana_shard," set value {recipe:"mana_rune",need:[0,1,0,1,1,1,0,1,0]}
data modify storage test: asset.recipe_index."m:herb_leaf,,,m:small_fish,,,,," set value {recipe:"healing_potion",need:[1,0,0,1,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",m:herb_leaf,,,m:small_fish,,,," set value {recipe:"healing_potion",need:[0,1,0,0,1,0,0,0,0]}
data modify storage test: asset.recipe_index.",,m:herb_leaf,,,m:small_fish,,," set value {recipe:"healing_potion",need:[0,0,1,0,0,1,0,0,0]}
data modify storage test: asset.recipe_index.",,,m:herb_leaf,,,m:small_fish,," set value {recipe:"healing_potion",need:[0,0,0,1,0,0,1,0,0]}
data modify storage test: asset.recipe_index.",,,,m:herb_leaf,,,m:small_fish," set value {recipe:"healing_potion",need:[0,0,0,0,1,0,0,1,0]}
data modify storage test: asset.recipe_index.",,,,,m:herb_leaf,,,m:small_fish" set value {recipe:"healing_potion",need:[0,0,0,0,0,1,0,0,1]}
data modify storage test: asset.recipe_index."m:mana_shard,m:stone_dust,,,,,,," set value {recipe:"mana_dust",need:[1,1,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",m:mana_shard,m:stone_dust,,,,,," set value {recipe:"mana_dust",need:[0,1,1,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,m:mana_shard,m:stone_dust,,,," set value {recipe:"mana_dust",need:[0,0,0,1,1,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,m:mana_shard,m:stone_dust,,," set value {recipe:"mana_dust",need:[0,0,0,0,1,1,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,,m:mana_shard,m:stone_dust," set value {recipe:"mana_dust",need:[0,0,0,0,0,0,1,1,0]}
data modify storage test: asset.recipe_index.",,,,,,,m:mana_shard,m:stone_dust" set value {recipe:"mana_dust",need:[0,0,0,0,0,0,0,1,1]}
data modify storage test: asset.recipe_index."m:bone,m:stone_dust,,,,,,," set value {recipe:"power_dust",need:[1,1,0,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",m:bone,m:stone_dust,,,,,," set value {recipe:"power_dust",need:[0,1,1,0,0,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,m:bone,m:stone_dust,,,," set value {recipe:"power_dust",need:[0,0,0,1,1,0,0,0,0]}
data modify storage test: asset.recipe_index.",,,,m:bone,m:stone_dust,,," set value {recipe:"power_dust",need:[0,0,0,0,1,1,0,0,0]}
data modify storage test: asset.recipe_index.",,,,,,m:bone,m:stone_dust," set value {recipe:"power_dust",need:[0,0,0,0,0,0,1,1,0]}
data modify storage test: asset.recipe_index.",,,,,,,m:bone,m:stone_dust" set value {recipe:"power_dust",need:[0,0,0,0,0,0,0,1,1]}
data modify storage test: asset.recipe_index.",m:flower_petal,,m:flower_petal,m:big_fish,m:flower_petal,,m:flower_petal," set value {recipe:"revive_feather",need:[0,1,0,1,1,1,0,1,0]}
data modify storage test: asset.recipe_index."m:earth_essence,m:earth_essence,m:earth_essence,m:earth_essence,,m:earth_essence,m:earth_essence,m:earth_essence,m:earth_essence" set value {recipe:"earth_essence_iron",need:[1,1,1,1,0,1,1,1,1]}
data modify storage test: asset.recipe_index."m:water_essence,m:water_essence,m:water_essence,m:water_essence,,m:water_essence,m:water_essence,m:water_essence,m:water_essence" set value {recipe:"water_essence_mana",need:[1,1,1,1,0,1,1,1,1]}
