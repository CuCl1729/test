#> test:item/magic/flow_effect
# @macro t: 効果のid。「 <名前>」を色付きで registry_work.flow に足す
data modify storage test: registry_work.flow append value {text:" ",italic:false}
data modify storage test: registry_work.flow append value {text:"",color:"white",italic:false}
$data modify storage test: registry_work.flow[-1].text set from storage test: asset.magic.effects[{id:"$(t)"}].label
$data modify storage test: registry_work.flow[-1].color set from storage test: asset.magic.effects[{id:"$(t)"}].color
