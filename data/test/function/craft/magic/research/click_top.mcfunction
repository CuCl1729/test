# @s = 魔法台。研究のidは描画時に台へ保存したものを使う。
data modify storage test: station_action.args set value {}
$data modify storage test: station_action.args.id set from entity @s data.research_ui.page_ids[$(index)]
$function test:station/action/accept {slot:$(slot),call:"research/try"}
function test:craft/magic/research/populate_top
