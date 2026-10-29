#> test:job/station/click_arrow
# @s = Jobステーション本体。@macro dir: -1(前へ)/ 1(次へ)。今のビュー(一覧/ツリー)のページを送る。
# 取った矢印がまだカーソルに乗っていれば普通のクリック=1件、それ以外(Shiftクリックなど)は7件動かす
# (test:craft/magic/research/click_arrow と同じ)

scoreboard players set #arrow_step test.buff.work 7
execute if items entity @p[distance=..3] player.cursor arrow[custom_data~{test:{job_ui:1b}}] run scoreboard players set #arrow_step test.buff.work 1
$scoreboard players operation #arrow_step test.buff.work *= #$(dir) test.constant

scoreboard players set #page test.buff.work 0
execute store result score #page test.buff.work run data get entity @s data.job_ui.page
scoreboard players operation #page test.buff.work += #arrow_step test.buff.work
execute if score #page test.buff.work matches ..-1 run scoreboard players set #page test.buff.work 0
execute store result entity @s data.job_ui.page int 1 run scoreboard players get #page test.buff.work

execute if entity @s[nbt={data:{job_ui:{view:"list"}}}] run function test:job/station/populate_list
execute if entity @s[nbt={data:{job_ui:{view:"tree"}}}] run function test:job/station/populate_tree
