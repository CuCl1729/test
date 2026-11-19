#> test:job/skill/magic/use
# @s = プレイヤー。@macro recipe/job/node: test:job/skill/handler/magicが渡す。学習済み/アクティブ/
# ダウン判定は呼び出し元(test:job/skill/use)で済んでいる。ここは「同じジョブビームの選択はトグルで
# 止める」「別のビームへ切り替えるときは古い方を先に止める」というジョブビーム専用の分岐だけを持ち、
# 詠唱本体(MP/バーンアウト/解禁/演者/ダメージ/届け方)は既存のtest:magic/へそのまま渡して共通化する

# ターン制の戦闘中はリアルタイムのジョブビームは使えない(手番のスキルは別途実装する)
execute if score @s test.battle.id matches 1.. run return 0

function #oh_my_dat:please

# 同じジョブ・ノードのビームを選び直した: 新しい詠唱/支払いをせずにトグルで止めるだけ
scoreboard players set #job_beam_same_toggle test.temporary 0
$execute if score @s test.magic.beam matches 1 if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.beam.data.job_skill{job:"$(job)",node:"$(node)"} run scoreboard players set #job_beam_same_toggle test.temporary 1
execute if score #job_beam_same_toggle test.temporary matches 1 run function test:magic/beam/stop
execute if score #job_beam_same_toggle test.temporary matches 1 run return 0

$function test:job/skill/magic/profile {recipe:"$(recipe)",job:"$(job)",node:"$(node)"}
execute unless data storage test: magic.player run return 0

# 新しくビーム(維持MPがある)を立てるなら、選んでいた別のビーム(ジョブ/アイテムどちらでも)を先に止める。
# ビームでないジョブ魔法を選んだときは、鳴らしているビームをここで止めない
execute if data storage test: magic.player.upkeep if score @s test.magic.beam matches 1 run function test:magic/beam/stop

function test:magic/
