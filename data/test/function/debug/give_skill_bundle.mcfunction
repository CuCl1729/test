#> test:debug/give_skill_bundle
# @s(プレイヤー)にスキルバンドルを渡し、test:job/bundle/rebuildで解放済みスキルぶん満杯にする

give @s bundle[custom_data={test:{skill_bundle:1b}},custom_name={text:"スキルバンドル",italic:false}]

function #oh_my_dat:please
function test:job/bundle/rebuild
