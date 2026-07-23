say Crafting

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

data modify storage test: loot.context set value "loot"
execute positioned ~ ~1 ~ run function test:item/magic/give
