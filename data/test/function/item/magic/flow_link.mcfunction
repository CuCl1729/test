#> test:item/magic/flow_link
# @macro t: つなぎのid。「 →<名前>→ 」を registry_work.flow に足す
data modify storage test: registry_work.flow append value {text:" →",color:"gray",italic:false}
data modify storage test: registry_work.flow append value {text:"",color:"gray",italic:false}
$data modify storage test: registry_work.flow[-1].text set from storage test: asset.magic.types[{id:"$(t)"}].label
data modify storage test: registry_work.flow append value {text:"→ ",color:"gray",italic:false}
