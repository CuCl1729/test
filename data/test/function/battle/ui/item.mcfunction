#> test:battle/ui/item

give @s minecraft:iron_sword[custom_data={test:{right_click:true,battle_action:"attack"}},custom_name={text:"攻撃",italic:false}]
give @s minecraft:blaze_powder[custom_data={test:{right_click:true,battle_action:"skill"}},custom_name={text:"スキル",italic:false}]
give @s minecraft:potion[custom_data={test:{right_click:true,battle_action:"item"}},custom_name={text:"アイテム",italic:false}]
give @s minecraft:shield[custom_data={test:{right_click:true,battle_action:"defend"}},custom_name={text:"防御",italic:false}]

tellraw @s [{text:"あなたの番です。使いたい行動のアイテムを右クリックしてください",color:yellow}]