#> test:magic/crafter/stage_requires
# @macro id: 要素id。requires_type のある効果なら、そのタイプの type_flags が今の段にあるかを見る(無ければ不正)
$execute unless data storage test: asset.magic.effects[{id:"$(id)"}].requires_type run return 0
data modify storage test: registry_work.requires_type set value {t:""}
$data modify storage test: registry_work.requires_type.t set from storage test: asset.magic.effects[{id:"$(id)"}].requires_type
function test:magic/crafter/stage_requires_flag with storage test: registry_work.requires_type
