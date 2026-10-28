#> test:asset/magic/run
# @macro id/folder: 魔法の要素のidと、その関数のフォルダ(type / effect / status)。
# 要素の数値(一覧の cost と params。スプレッドシートの「魔法の数値」タブから生成)を作業用に写し、
# test:asset/magic/<folder>/<id> にマクロ引数として渡して呼ぶ(魔法の組み立てはすべてここを通す)

data modify storage test: registry_work.magic_args set value {}
$execute if data storage test: asset.magic.types[{id:"$(id)"}] run data modify storage test: registry_work.magic_args set from storage test: asset.magic.types[{id:"$(id)"}].params
$execute if data storage test: asset.magic.types[{id:"$(id)"}] run data modify storage test: registry_work.magic_args.cost set from storage test: asset.magic.types[{id:"$(id)"}].cost
$execute if data storage test: asset.magic.effects[{id:"$(id)"}] run data modify storage test: registry_work.magic_args set from storage test: asset.magic.effects[{id:"$(id)"}].params
$execute if data storage test: asset.magic.effects[{id:"$(id)"}] run data modify storage test: registry_work.magic_args.cost set from storage test: asset.magic.effects[{id:"$(id)"}].cost

$function test:asset/magic/$(folder)/$(id) with storage test: registry_work.magic_args
