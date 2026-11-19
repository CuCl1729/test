#> test:magic/crafter/stage_link
# @s = クラフター本体。@macro id: つなぎの要素id。今の段を閉じ、前の段の形態がこのつなぎの after と合うかを見て、
# つなぎの数値(magic.loot.link)と費用を取り、次の段を始める
function test:magic/crafter/stage_close

$data modify storage test: registry_work.link_id set value "$(id)"

# 前の段が「ビームへの直接つなぎ」(持続・飛翔物の段から着弾/一定間隔へ)かを見る
scoreboard players set #beam_link test.temporary 0
execute if data storage test: registry_work.stages[-1].status.type_flags{continuous:1b,projectile:1b} if data storage test: registry_work{link_id:"on_land"} run scoreboard players set #beam_link test.temporary 1
execute if data storage test: registry_work.stages[-1].status.type_flags{continuous:1b,projectile:1b} if data storage test: registry_work{link_id:"periodic"} run scoreboard players set #beam_link test.temporary 1

data modify storage test: registry_work.link_after.list set value []
$data modify storage test: registry_work.link_after.list set from storage test: asset.magic.types[{id:"$(id)"}].after
function test:magic/crafter/stage_link_check

function test:asset/magic/reset
$function test:asset/magic/run {id:"$(id)",folder:"type"}
# 生成レシピ向けのつなぎ数値設定(あれば)。段の設定は前の stage_close で registry_work.stage_setting に残っている
execute if data storage test: registry_work.stage_setting.link.params run data modify storage test: magic.loot.link merge from storage test: registry_work.stage_setting.link.params
execute if data storage test: registry_work.stage_setting.link.cost store result score #cost test.temporary run data get storage test: registry_work.stage_setting.link.cost
# つなぎ自身の費用は払う(「一定間隔」の最初のぶんも払う。無料になるのはその先と、ビームへのつなぎ自身)
execute unless score #child_free test.temporary matches 1 unless score #beam_link test.temporary matches 1 run scoreboard players operation #cost_total test.temporary += #cost test.temporary
$data modify storage test: registry_work.stage_link set value "$(id)"
data modify storage test: registry_work.stage_link_params set value {}
data modify storage test: registry_work.stage_link_params set from storage test: magic.loot.link

# このつなぎが「前の段のどれと組んだときに何をするか」も組み合わせの表が決める。
# 行が無いつなぎ(着弾で・再使用で・接触で・時間で)は、次の段をそのまま始めるだけなので表に行を持たない
data modify storage test: registry_work.stage_link_behavior set value ""
data remove storage test: combo_work.flags
data modify storage test: combo_work.flags set from storage test: registry_work.stages[-1].status.type_flags
$data modify storage test: combo_work.flags.$(id) set value 1b
data modify storage test: combo_work.apply set value "link"
data modify storage test: combo_work.emitter set value "any"
function test:magic/combo/match
execute if score #combo_found test.temporary matches 1 run data modify storage test: registry_work.stage_link_behavior set from storage test: combo_work.hit.behavior

# ここから後ろの段は、起こされる側なので費用を取らない(初めの見積りにも、起動時の支払いにも入れない)
execute if data storage test: registry_work{link_id:"periodic"} run scoreboard players set #child_free test.temporary 1
execute if score #beam_link test.temporary matches 1 run scoreboard players set #child_free test.temporary 1
