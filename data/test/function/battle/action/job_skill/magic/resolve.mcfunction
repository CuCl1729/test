#> test:battle/action/job_skill/magic/resolve
# @s = 決定した詠唱者(手番)。@e[tag=battle_target] = 決定済みの対象。test:battle/ui/target_confirm/
# target_minecart_resolveのpending_target_action=3から呼ばれる。レジストリ変更・未習得化・種類変更など、
# 対象選択中に手番の前提が崩れていないかをtest:job/skill/magic/prepareで再確認し、崩れていれば
# 支払い・ターン消費をせずに選び直しへ戻す(passive_refusedを使い回す)

execute unless function test:battle/ui/current_actor run return 0
execute unless score @s test.battle.pending_target_action matches 3 run return 0

# 対象選択中の他の効果(カート片付け等)で個別ストレージの指す先が変わっていることがあるため、
# ここで@s向けに取り直してから、呼び先を巻き込む前に控えを自分のスコープへ写す
function #oh_my_dat:please
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.pending_magic.node run return 0
data remove storage test: job_magic_handler
data modify storage test: job_magic_handler set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.pending_magic

scoreboard players set #job_magic_prepared test.job.work 0
execute store result score #job_magic_prepared test.job.work run function test:job/skill/magic/prepare with storage test: job_magic_handler
execute if score #job_magic_prepared test.job.work matches 0 run return run function test:battle/action/passive_refused

# レジストリ変更で自己/範囲に変わっていたら、投射専用のここでは発動させない(選び直しへ戻す)
execute if data storage test: magic.player.type_flags{self:1b} run return run function test:battle/action/passive_refused
execute if data storage test: magic.player.type_flags{aoe:1b} run return run function test:battle/action/passive_refused

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.pending_magic
scoreboard players set @s test.battle.pending_target_action 0

# 支払い・MP不足時の打ち切りは既存のapply_projectileに委ねる(ここで二重に払わない)
function test:battle/action/skill_cast/apply_projectile

function test:battle/target/clear
function test:battle/turn_end
