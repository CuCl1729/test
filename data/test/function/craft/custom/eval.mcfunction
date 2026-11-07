#> test:craft/custom/eval
# 実行位置 = カスタムクラフターの樽。材料の種類・配置・個数だけでレシピを決める。
#   #cc_ok = 0 不一致 / 1 一致。研究条件はボタンを取った人について make が確かめる。
# 9マスを1マスの文字(素材 m:<id> / custom_data の無いアイテム v:<id> / 空)にして , でつなぎ、asset.recipe_index を引く
# (索引には、生成スクリプトが形を3×3の置ける位置すべてに置いたキーを入れてあるので、ずらして置いても当たる)

scoreboard players set #cc_ok test.temporary 0
data remove storage test: craft_work.match
data modify storage test: craft_work.cells set value {c0:"",c1:"",c2:"",c3:"",c4:"",c5:"",c6:"",c7:"",c8:""}
data modify storage test: craft_work.bad set value 0b
function test:craft/custom/cell {slot:3,i:0}
function test:craft/custom/cell {slot:4,i:1}
function test:craft/custom/cell {slot:5,i:2}
function test:craft/custom/cell {slot:12,i:3}
function test:craft/custom/cell {slot:13,i:4}
function test:craft/custom/cell {slot:14,i:5}
function test:craft/custom/cell {slot:21,i:6}
function test:craft/custom/cell {slot:22,i:7}
function test:craft/custom/cell {slot:23,i:8}
execute if data storage test: craft_work{bad:1b} run return 0
function test:craft/custom/lookup with storage test: craft_work.cells
execute unless data storage test: craft_work.match run return 0

# 枠ごとの数: 全部の枠に、必要な数以上が置かれていること
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[0]
execute if score #cn0 test.temporary < #cc_nd test.temporary run return 0
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[1]
execute if score #cn1 test.temporary < #cc_nd test.temporary run return 0
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[2]
execute if score #cn2 test.temporary < #cc_nd test.temporary run return 0
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[3]
execute if score #cn3 test.temporary < #cc_nd test.temporary run return 0
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[4]
execute if score #cn4 test.temporary < #cc_nd test.temporary run return 0
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[5]
execute if score #cn5 test.temporary < #cc_nd test.temporary run return 0
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[6]
execute if score #cn6 test.temporary < #cc_nd test.temporary run return 0
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[7]
execute if score #cn7 test.temporary < #cc_nd test.temporary run return 0
execute store result score #cc_nd test.temporary run data get storage test: craft_work.match.need[8]
execute if score #cn8 test.temporary < #cc_nd test.temporary run return 0

scoreboard players set #cc_ok test.temporary 1
function test:craft/custom/load_recipe with storage test: craft_work.match
