# @s = 話している人。循環や長い会話は現在の次へへ戻し、同じノードの処理を繰り返さない。
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.visited[{node:"$(node)"}] run return run function test:talk/skip_resume with storage test: talk_work.skip
execute store result score #talk_skip_left test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.skip_left
execute if score #talk_skip_left test.temporary matches ..0 run return run function test:talk/skip_resume with storage test: talk_work.skip
scoreboard players remove #talk_skip_left test.temporary 1
execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.skip_left int 1 run scoreboard players get #talk_skip_left test.temporary
function test:talk/skip_visit with storage test: talk_work.skip
function test:talk/goto with storage test: talk_work.skip
