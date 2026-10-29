#> test:battle/drop_log
# test:battle/grant_reward が抽選したドロップを、デバッグ表示がオンのときだけ1行出す(敵1体につき1回)。
# 見た目は test:debug/log と同じ(debug/log は文字列しか受け取れないので、一覧を出すためにここで直接書く)

execute if score #debug test.debug.enabled matches 1 run tellraw @a [{text:"[DEBUG] ",color:gray},{text:"ドロップ: 素材 "},{storage:"test:",nbt:"battle.temporary.material_hits"},{text:" 装備 "},{storage:"test:",nbt:"battle.temporary.equip_hits"}]
