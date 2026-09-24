#> test:job/station/main
# @s = Jobステーション本体(バレルの位置、test:tickから毎tick呼ばれる)

execute unless block ~ ~ ~ barrel run function test:job/station/place
execute unless block ~ ~ ~ barrel run return 0

execute if entity @s[nbt={data:{job_ui:{view:"list"}}}] run function test:job/station/main_list
execute if entity @s[nbt={data:{job_ui:{view:"tree"}}}] run function test:job/station/main_tree

clear @p[distance=..3] *[custom_data~{test:{job_ui:1b}}]
