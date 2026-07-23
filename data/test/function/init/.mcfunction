#> test:init/
#
# @private
forceload add 0 0 0 0

execute unless data storage test: {installed:1b} run summon marker 0.0 0.0 0.0 {data:{"is_class_manager":1b}}
execute unless data storage test: {installed:1b} run summon text_display 0.0 0.0 0.0 {Tags:[text]}
execute unless data storage test: {installed:1b} run summon armor_stand 0.0 0.0 0.0 {Tags:[Ray],Marker:1b}
execute unless data storage test: {installed:1b} run summon armor_stand 0.0 0.0 0.0 {Tags:[Temp],Marker:1b}
execute unless data storage test: {installed:1b} run setblock 0 -64 0 red_shulker_box
execute unless data storage test: {installed:1b} run summon armor_stand 0.0 0.0 0.0 {Tags:[Axis],Marker:1b}
execute unless data storage test: {installed:1b} run summon armor_stand 0.0 0.0 0.0 {Tags:[Axis],Marker:1b}

data remove storage test: class
data remove storage test: asset

function test:init/scoreboard
function test:init/class
function test:init/asset/

function test:init/set_table

data modify storage test: installed set value 1b
