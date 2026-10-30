#> test:machine/port/out/insert_one
# 実行位置 = 入れる先の入れ物。@macro id/components: 入れるアイテム(ほかのキーも渡ってくるが使わない)。
# そのアイテムを1個、入れ物に入れる(入れ物が無い・いっぱいなら入らない)。入ったら #ins = 1。
# その場で書いたルートテーブルで作るので、どのディメンションでも入れられる。1個ずつ入れるのは、loot insert が
# 入りきらなかった分を黙って消すため(1個なら、入ったかどうかが戻り値で分かる)

scoreboard players set #ins test.temporary 0
$execute store result score #ins test.temporary run loot insert ~ ~ ~ loot {pools:[{rolls:1,entries:[{type:"minecraft:item",name:"$(id)",modifier:[{type:"minecraft:set_components",components:$(components)}]}]}]}
