#> test:job/grant_exp_all
# @s = 戦闘報酬を得たプレイヤー(please実行済みであること。呼び出し元test:battle/grant_reward_to_player
# で実行済み)。転職の概念が無いため、#reward test.temporaryぶんのEXPを解放済みの全職業へ同時に与える

data modify storage test: job_work.exp_queue set from storage test: asset.job.jobs

function test:job/grant_exp_loop

function test:job/recalc_bonus
