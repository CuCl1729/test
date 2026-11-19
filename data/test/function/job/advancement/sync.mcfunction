# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:job/advancement/sync
# @s = 同期するプレイヤー。職業ツリーの見た目(アドバンスメント)を、今の解放・習得フラグに合わせて付与・剥奪するだけ(SP/MP・canonicalな状態は変えない)

function #oh_my_dat:please

# 職業「warrior」
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.warrior run advancement grant @s only test:job_tree/warrior/root
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.warrior run advancement revoke @s only test:job_tree/warrior/root
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.warrior.skills{cleave:1b} run advancement grant @s only test:job_tree/warrior/skills/cleave
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.warrior.skills{cleave:1b} run advancement revoke @s only test:job_tree/warrior/skills/cleave
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.warrior.skills{iron_wall:1b} run advancement grant @s only test:job_tree/warrior/skills/iron_wall
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.warrior.skills{iron_wall:1b} run advancement revoke @s only test:job_tree/warrior/skills/iron_wall
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.warrior.skills{might:1b} run advancement grant @s only test:job_tree/warrior/skills/might
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.warrior.skills{might:1b} run advancement revoke @s only test:job_tree/warrior/skills/might
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.warrior.skills{endurance:1b} run advancement grant @s only test:job_tree/warrior/skills/endurance
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.warrior.skills{endurance:1b} run advancement revoke @s only test:job_tree/warrior/skills/endurance
advancement grant @s only test:job_tree/warrior/visibility/iron_wall
advancement grant @s only test:job_tree/warrior/visibility/endurance
# 職業「paladin」
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.paladin run advancement grant @s only test:job_tree/paladin/root
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.paladin run advancement revoke @s only test:job_tree/paladin/root
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.paladin.skills{smite:1b} run advancement grant @s only test:job_tree/paladin/skills/smite
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.paladin.skills{smite:1b} run advancement revoke @s only test:job_tree/paladin/skills/smite
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.paladin.skills{blessing:1b} run advancement grant @s only test:job_tree/paladin/skills/blessing
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.paladin.skills{blessing:1b} run advancement revoke @s only test:job_tree/paladin/skills/blessing
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.paladin.skills{resurrection:1b} run advancement grant @s only test:job_tree/paladin/skills/resurrection
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.paladin.skills{resurrection:1b} run advancement revoke @s only test:job_tree/paladin/skills/resurrection
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.paladin.skills{vigor:1b} run advancement grant @s only test:job_tree/paladin/skills/vigor
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.paladin.skills{vigor:1b} run advancement revoke @s only test:job_tree/paladin/skills/vigor
advancement grant @s only test:job_tree/paladin/visibility/resurrection
advancement grant @s only test:job_tree/paladin/visibility/vigor
