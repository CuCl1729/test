#> test:job/skill/magic/hold
# @s = ビームを出しているプレイヤー(test:magic/beam/tickから、発動時に積んだjob_skillで毎tick呼ばれる。
# 選び直し自体は既存のbeam tickが済ませている)。@macro job/node: 発動時のジョブ・ノード。
# リセット/未学習/ノードの種類変更(magic以外に変わった)だけを確認する軽い入力で、
# コンパイルやステータス再構築、支払いはしない(費用は維持MPの既存処理が担う)
function #oh_my_dat:please
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(node):1b} run return 0
$execute unless data storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)",kind:"magic"}] run return 0

function test:magic/cont/hold
return 1
