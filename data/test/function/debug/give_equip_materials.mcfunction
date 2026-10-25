#> test:debug/give_equip_materials
# 防具工房で使う素材と型紙を配る。
# 防具工房の置き方: スロット9に素材(個数でレア度: 5〜9=3 / 10〜19=4 / 20以上=5)、スロット10に型紙(消費しない)

give @s rabbit_hide[custom_data={test:{material:{source:"goblin",kind:"goblin_hide"}}},custom_name={text:"ゴブリンの革",italic:false}] 20
give @s prismarine_crystals[custom_data={test:{material:{kind:"mana_shard"}}},custom_name={text:"魔力の欠片",italic:false}] 20

give @s paper[custom_data={test:{pattern:{part:"head"}}},custom_name={text:"兜の型紙",italic:false}]
give @s paper[custom_data={test:{pattern:{part:"chest"}}},custom_name={text:"鎧の型紙",italic:false}]
give @s paper[custom_data={test:{pattern:{part:"legs"}}},custom_name={text:"脚甲の型紙",italic:false}]
give @s paper[custom_data={test:{pattern:{part:"feet"}}},custom_name={text:"靴の型紙",italic:false}]
give @s paper[custom_data={test:{pattern:{part:"accessory"}}},custom_name={text:"装飾の型紙",italic:false}]
