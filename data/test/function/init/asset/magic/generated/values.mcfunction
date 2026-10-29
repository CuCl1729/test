# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/magic/generated/values
# 魔法の要素の数値(スプレッドシートの「魔法の数値」タブ)。手書きの一覧(init/asset/magic/types・effects)に cost と params を足す。
# test:asset/magic/run が params と cost を asset/magic/<folder>/<id> にマクロ引数として渡す

data modify storage test: asset.magic.types[{id:"self"}] merge value {cost:20,params:{}}
data modify storage test: asset.magic.types[{id:"projectile"}] merge value {cost:50,params:{speed:100,range:20}}
data modify storage test: asset.magic.types[{id:"aoe"}] merge value {cost:80,params:{radius:5}}
data modify storage test: asset.magic.effects[{id:"fire"}] merge value {cost:50,params:{base:1000}}
data modify storage test: asset.magic.effects[{id:"atk"}] merge value {cost:100,params:{per_stack:1000,max_stacks:3}}
data modify storage test: asset.magic.effects[{id:"gravity"}] merge value {cost:10,params:{gravity:100}}
data modify storage test: asset.magic.effects[{id:"heal"}] merge value {cost:200,params:{power:3}}
data modify storage test: asset.magic.effects[{id:"range"}] merge value {cost:60,params:{per_stack:2,max_stacks:3}}
data modify storage test: asset.magic.effects[{id:"atk_up"}] merge value {cost:120,params:{max_stacks:3}}
data modify storage test: asset.magic.effects[{id:"poison"}] merge value {cost:90,params:{max_stacks:3}}
data modify storage test: asset.magic.effects[{id:"revive"}] merge value {cost:300,params:{percent:30}}
