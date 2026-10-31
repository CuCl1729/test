#> test:gather/drop/start
# @s = 採るプレイヤー。@macro point/type/dim: 採ったポイント(ほかのキーも渡ってくるが使わない)。中身の行を写して1行ずつ抽選する

$data modify storage test: gather_work.drops set from storage test: asset.gather.$(type).drops
$function test:debug/log {msg:"採取 $(point)($(dim))"}
function test:gather/drop/loop
