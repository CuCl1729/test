#> test:battle/action/job_skill/handler/magic
# @s = 詠唱者(手番)。test:battle/action/job_skill_cast が読み込んだ job_work.skill_entry から
# ジョブ/ノードを取り直し、都度レジストリ再読込みの test:job/skill/magic/prepare へそのまま渡す
# (このハンドラへmacro展開済みのparamsは古いレシピを握ったままになり得るため、ここでは使わない)

data remove storage test: job_magic_handler
data modify storage test: job_magic_handler.job set from storage test: job_work.skill_entry.job
data modify storage test: job_magic_handler.node set from storage test: job_work.skill_entry.id

scoreboard players set #job_magic_prepared test.job.work 0
execute store result score #job_magic_prepared test.job.work run function test:job/skill/magic/prepare with storage test: job_magic_handler
execute if score #job_magic_prepared test.job.work matches 0 run return run function test:battle/action/passive_refused

# 自己/範囲は既存の届け方(届け方を増やしても型・効果側の表だけ直せばよい)にそのまま渡して手番を終える。
# 投射と範囲の組み合わせも、飛翔体を持たないターン制では範囲側(敵全員)へ回す(apply_aoeのコメント参照)
execute if data storage test: magic.player.type_flags{self:1b} run function test:battle/action/skill_cast/apply_self
execute if data storage test: magic.player.type_flags{self:1b} run return run function test:battle/turn_end

execute if data storage test: magic.player.type_flags{aoe:1b} run function test:battle/action/skill_cast/apply_aoe
execute if data storage test: magic.player.type_flags{aoe:1b} run return run function test:battle/turn_end

return run function test:battle/action/job_skill/magic/projectile with storage test: job_magic_handler
