#> test:talk/skip_button
scoreboard players operation #tv test.temporary = @s test.talk_seq
scoreboard players operation #tv test.temporary *= #10 test.constant
data modify storage test: talk_work.b set value {v:0,label:"スキップ"}
execute store result storage test: talk_work.b.v int 1 run scoreboard players get #tv test.temporary
function test:talk/btn_show with storage test: talk_work.b
