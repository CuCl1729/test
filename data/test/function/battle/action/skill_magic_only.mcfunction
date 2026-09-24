#> test:battle/action/skill_magic_only
# @s = 詠唱者(チャット式)。魔法だけが使える場合の分岐。test:battle/action/skill_category_countが
# 既にtest:magic/registry/queue_types+skill_known_loopを実行済みなので、その結果(#known_type_count/
# registry_work.only_type)をそのまま使う(=以前のtest:battle/action/skillと全く同じ挙動)

execute if score #known_type_count test.temporary matches 1 run return run function test:battle/action/skill_single_type with storage test: registry_work.only_type

function test:battle/ui/skill_type_select
