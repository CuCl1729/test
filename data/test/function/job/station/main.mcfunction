#> test:job/station/main
# @s = Jobステーションのマーカー(バレルの位置、test:station/tickから毎tick呼ばれる)

execute if entity @s[nbt={data:{job_ui:{view:"list"}}}] run function test:job/station/main_list
execute if entity @s[nbt={data:{job_ui:{view:"tree"}}}] run function test:job/station/main_tree

clear @p[distance=..3] *[custom_data~{test:{job_ui:1b}}]
