#> test:item/magic/flow_type
# @macro t: 形態のid。その名前を色付きで registry_work.flow に足す
data modify storage test: registry_work.flow append value {text:"",color:"white",italic:false}
$data modify storage test: registry_work.flow[-1].text set from storage test: asset.magic.types[{id:"$(t)"}].label
$data modify storage test: registry_work.flow[-1].color set from storage test: asset.magic.types[{id:"$(t)"}].color
