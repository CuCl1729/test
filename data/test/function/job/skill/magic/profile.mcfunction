#> test:job/skill/magic/profile
# @s = プレイヤー。@macro job/node/recipe: 信頼済みレジストリID。既存の魔法レシピ(asset.action.recipes.$(recipe))を
# コンパイルして magic.player を用意するだけの内部処理(詠唱・ダメージ・MP/バーンアウト/SP消費・解禁・
# 演者生成・ステータス準備・ゲームメッセージ・レシピ書き換えはしない)

data remove storage test: magic.player
data remove storage test: magic_recipe

$execute unless data storage test: asset.action.recipes.$(recipe).build[0] run return 0

$data modify storage test: magic_recipe.build set from storage test: asset.action.recipes.$(recipe).build
$data modify storage test: magic_recipe.settings set from storage test: asset.action.recipes.$(recipe).settings
function test:magic/recipe/compile

scoreboard players set #job_magic_profile_invalid test.temporary 0
execute if data storage test: magic.loot.invalid run scoreboard players set #job_magic_profile_invalid test.temporary 1
execute unless data storage test: magic.loot.status.magic_type run scoreboard players set #job_magic_profile_invalid test.temporary 1
execute if score #job_magic_profile_invalid test.temporary matches 1 run return 0

# コンパイル済み状態(段・つなぎ・費用含む)を magic.player にそのまま積む。.data.action は
# 凍結武器ダメージ専用の印なので、純粋魔法のここでは持ち込まない
data modify storage test: magic.player set from storage test: magic.loot.status
execute store result storage test: magic.player.cost int 1 run scoreboard players get #cost test.temporary
data remove storage test: magic.player.data.action

# 永続UIDはプレイヤー×職業×ノードごとに1つ(リセットやレシピ変更をまたいで同じ印を使い続ける)。
# コンパイル成功後にだけ割り当てる
function #oh_my_dat:please
scoreboard players set #job_magic_uid_known test.temporary 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.magic_uids.$(job).$(node) run scoreboard players set #job_magic_uid_known test.temporary 1
execute if score #job_magic_uid_known test.temporary matches 0 run scoreboard players add #magic_uid test.time 1
$execute if score #job_magic_uid_known test.temporary matches 0 run execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.magic_uids.$(job).$(node) int 1 run scoreboard players get #magic_uid test.time

# つなぎ(chain[0])か持続(continuous)のときだけ押すUIDを付ける。単発は再発動のたびに新規扱いのまま
data remove storage test: magic.player.uid
scoreboard players set #job_magic_press_uid test.temporary 0
execute if data storage test: magic.player.chain[0] run scoreboard players set #job_magic_press_uid test.temporary 1
execute if data storage test: magic.player.type_flags{continuous:1b} run scoreboard players set #job_magic_press_uid test.temporary 1
$execute if score #job_magic_press_uid test.temporary matches 1 run data modify storage test: magic.player.uid set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.magic_uids.$(job).$(node)

$data modify storage test: magic.player.data.job_skill set value {job:"$(job)",node:"$(node)"}

return 1
