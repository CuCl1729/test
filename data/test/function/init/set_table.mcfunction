data modify storage test: loot.table.substatus set value \
[{type:"atk_m",value:3.0,status_type:"%"},{type:"atk_add",value:30.0d},\
{type:"def_m",value:3.0,status_type:"%"},{type:"def_add",value:30.0d},\
{type:"max_hp_m",value:3.0,status_type:"%"},{type:"max_hp_add",value:30.0d},\
{type:"crit_damage_add",value:4.8,status_type:"% "},{type:"crit_rate_add",value:2.4,status_type:"%"},\
{type:"effect_damage_add",value:10.0d},{type:"magic_efficiency_add",value:5.0d}]

# 武器の説明文(test:item/weapon/lore/)でステータスを描くときの表示定義。
# icon=行頭の記号(BMPの記号なので日本語フォントでも出る) / color=記号の色 / unit=値の後ろに付ける単位
data modify storage test: loot.table.stat_display set value \
[{type:"atk_m",icon:"⚔",label:"攻撃力",color:"red",unit:"%"},{type:"atk_add",icon:"⚔",label:"攻撃力",color:"red",unit:""},\
{type:"def_m",icon:"⛨",label:"防御力",color:"blue",unit:"%"},{type:"def_add",icon:"⛨",label:"防御力",color:"blue",unit:""},\
{type:"max_hp_m",icon:"❤",label:"HP",color:"green",unit:"%"},{type:"max_hp_add",icon:"❤",label:"HP",color:"green",unit:""},\
{type:"crit_rate_add",icon:"✦",label:"会心率",color:"yellow",unit:"%"},{type:"crit_damage_add",icon:"✸",label:"会心ダメージ",color:"gold",unit:"%"},\
{type:"effect_damage_add",icon:"✧",label:"神秘",color:"light_purple",unit:""},{type:"magic_efficiency_add",icon:"✎",label:"魔導掌握",color:"aqua",unit:""}]

# 武器の説明文で属性ごとのダメージ式を描くときの表示定義(elemはcustom_data.damageのキー)
data modify storage test: loot.table.element_display set value \
[{elem:"physics",icon:"⚔",label:"物理",color:"white"},{elem:"fire",icon:"♨",label:"火",color:"red"},\
{elem:"water",icon:"≈",label:"水",color:"blue"},{elem:"wood",icon:"♣",label:"木",color:"green"},\
{elem:"metal",icon:"⚙",label:"金",color:"gray"},{elem:"earth",icon:"▲",label:"土",color:"gold"}]

data modify storage test: loot.table.grow set value \
[{type:"atk_m",value:0.3,},{type:"atk_add",value:8},\
{type:"def_m",value:0.3},{type:"def_add",value:8},\
{type:"max_hp_m",value:0.3},{type:"max_hp_add",value:8},\
{type:"crit_damage_add",value:0.48},{type:"crit_rate_add",value:0.24},\
{type:"effect_damage_add",value:2},{type:"magic_efficiency_add",value:1}]
