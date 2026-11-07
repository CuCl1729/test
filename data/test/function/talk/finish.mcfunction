#> test:talk/finish
execute store result score #to test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.opts
execute if score #to test.temporary matches 0 run return run function test:talk/end
execute if entity @s[tag=talk_skipping] run return run function test:talk/skip_continue
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.next run function test:talk/skip_button
