function test:asset/magic/reset

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.magic

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.magic

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:11b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:11b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:11b}].components."minecraft:custom_data".test.magic

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:12b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:12b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:12b}].components."minecraft:custom_data".test.magic

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:13b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:13b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:13b}].components."minecraft:custom_data".test.magic

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:14b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:14b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:14b}].components."minecraft:custom_data".test.magic

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:15b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:15b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:15b}].components."minecraft:custom_data".test.magic

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:16b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:16b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:16b}].components."minecraft:custom_data".test.magic

function test:magic/crafter/type with block ~ ~ ~ Items[{Slot:17b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/effect with block ~ ~ ~ Items[{Slot:17b}].components."minecraft:custom_data".test.magic
function test:magic/crafter/status with block ~ ~ ~ Items[{Slot:17b}].components."minecraft:custom_data".test.magic

# タイプの組み合わせを検証し、順序非依存に集計した数値を反映してから成否を判定する
function test:magic/crafter/validate
function test:magic/crafter/finalize

execute if data storage test: magic.loot.status.magic_type if score #combo_invalid test.temporary matches 0 run function test:magic/crafter/success
execute unless data storage test: magic.loot.status.magic_type run function test:magic/crafter/failure
execute if data storage test: magic.loot.status.magic_type if score #combo_invalid test.temporary matches 1 run function test:magic/crafter/failure

# 組み合わせが不正な場合はアイテムを渡さないよう、組み立て済みのデータを破棄する
execute if score #combo_invalid test.temporary matches 1 run data remove storage test: magic.loot

data modify storage test: loot.context set value "loot"
execute positioned ~ ~1 ~ run function test:item/magic/give
