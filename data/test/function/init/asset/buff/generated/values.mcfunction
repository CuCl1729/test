# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/buff/generated/values
# バフの数値(スプレッドシートの「バフの数値」タブ)。手書きの一覧(init/asset/buff/buffs)に duration・max_stacks・interval・params を足す。
# params は内部の値(×100済み)で、test:buff/fire_entry が buff/on/<event>/<id> にマクロ引数として渡す

data modify storage test: asset.buff.types[{id:"atk_up"}] merge value {duration:30,max_stacks:3,params:{per_stack:500}}
data modify storage test: asset.buff.types[{id:"poison"}] merge value {duration:30,max_stacks:3,interval:5,params:{per_stack:200}}
data modify storage test: asset.buff.types[{id:"guard"}] merge value {duration:30,max_stacks:1,params:{amount:1000}}
