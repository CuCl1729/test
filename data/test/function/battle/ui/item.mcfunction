#> test:battle/ui/item

# 行動アイテムを配る前に、実際に装備している武器(両手分)を反映したステータスを計算しておく。
# 配った後はメインハンドが行動アイテムに入れ替わってしまうため、ここで計算した値をそのまま使う。
# (魔法・通常攻撃の計算が参照するものをまとめて計算しておく。戦闘中は test:status/refresh が計算し直さない)
function test:status/update {status:"atk"}
function test:status/update {status:"hp_max"}
function test:status/update {status:"def"}
function test:status/update {status:"crit_rate"}
function test:status/update {status:"crit_damage"}
function test:status/update {status:"magic_efficiency"}
function test:status/update {status:"effect_damage"}

# 前のターンでスキル選択を完了せずに終わった場合、blaze_powderが手元に残り続けることがあるため、
# 新しい行動アイテムを配る前に必ず一度全部消しておく(トロッコ/追従状態も合わせて片付ける)
clear @s minecraft:iron_sword[custom_data~{test:{battle_action:"attack"}}]
clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]
clear @s minecraft:potion[custom_data~{test:{battle_action:"item"}}]
clear @s minecraft:shield[custom_data~{test:{battle_action:"defend"}}]
clear @s minecraft:feather[custom_data~{test:{battle_action:"flee"}}]
clear @s *[custom_data~{test:{active_skill:1b}}]
clear @s *[custom_data~{test:{battle_item_pick:1b}}]
kill @e[tag=skill_minecart,distance=..8]
kill @e[tag=item_minecart,distance=..8]

# 「アイテム」はスキルと同じく、持つとトロッコが出る(test:battle/ui/item_hover_show)。右クリックで飲めないよう、
# 飲む時間を長くしておく
give @s minecraft:iron_sword[custom_data={test:{right_click:true,battle_action:"attack"}},custom_name={text:"攻撃",italic:false},consumable={consume_seconds:100000,animation:none}]
give @s minecraft:blaze_powder[custom_data={test:{right_click:true,battle_action:"skill"}},custom_name={text:"スキル",italic:false},consumable={consume_seconds:100000,animation:none}]
give @s minecraft:potion[custom_data={test:{right_click:true,battle_action:"item"}},custom_name={text:"アイテム",italic:false},consumable={consume_seconds:100000,animation:none}]
give @s minecraft:shield[custom_data={test:{right_click:true,battle_action:"defend"}},custom_name={text:"防御",italic:false}]
give @s minecraft:feather[custom_data={test:{right_click:true,battle_action:"flee"}},custom_name={text:"逃げる",italic:false},consumable={consume_seconds:100000,animation:none}]

tellraw @s [{text:"あなたの番です。使いたい行動のアイテムを右クリックしてください",color:yellow}]
