#> test:job/skill/bundle_pick_front
# @s = 対象プレイヤー(please実行済み)。@macro job/node: インベントリ画面で取り出されたスキル。
# バンドルの中身はskill_orderを反転して書くため、skill_orderの末尾へ移すとバンドルの先頭
# (手に持って右クリックしたときに次に出てくる位置)になる

$data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order[{job:"$(job)",node:"$(node)"}]
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order append value {job:"$(job)",node:"$(node)"}

function test:job/bundle/rebuild
