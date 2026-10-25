# サブステータスの抽選表。抽選値(0始まり)がそのまま添字になる。
# 武器は0..9、防具・アクセサリーは0..15(属性耐性を含む)を引く(storage test: loot.substatus_maxで指定)。
# 並び順を変えると抽選結果の意味が変わるので、増やすときは末尾に足すこと
# HPは以前max_hp_*という名前だったが、status/updateが読むのはhp_max_*なので一度も効いていなかった。hp_max_*に改めた
data modify storage test: loot.table.substatus set value \
[{type:"atk_m",value:3.0,status_type:"%"},{type:"atk_add",value:30.0d},\
{type:"def_m",value:3.0,status_type:"%"},{type:"def_add",value:30.0d},\
{type:"hp_max_m",value:3.0,status_type:"%"},{type:"hp_max_add",value:30.0d},\
{type:"crit_damage_add",value:4.8,status_type:"% "},{type:"crit_rate_add",value:2.4,status_type:"%"},\
{type:"effect_damage_add",value:10.0d},{type:"magic_efficiency_add",value:5.0d},\
{type:"fire_resist_add",value:3.0},{type:"water_resist_add",value:3.0},\
{type:"wood_resist_add",value:3.0},{type:"metal_resist_add",value:3.0},\
{type:"earth_resist_add",value:3.0},{type:"physics_resist_add",value:3.0}]

# 説明文(test:item/weapon/lore/)でステータスを描くときの表示定義。
# icon=行頭の記号(BMPの記号なので日本語フォントでも出る) / color=記号の色 / unit=値の後ろに付ける単位
# max_hp_*は古い名前のまま作られた武器の説明文を描くために残している
data modify storage test: loot.table.stat_display set value \
[{type:"atk_m",icon:"⚔",label:"攻撃力",color:"red",unit:"%"},{type:"atk_add",icon:"⚔",label:"攻撃力",color:"red",unit:""},\
{type:"def_m",icon:"⛨",label:"防御力",color:"blue",unit:"%"},{type:"def_add",icon:"⛨",label:"防御力",color:"blue",unit:""},\
{type:"hp_max_m",icon:"❤",label:"HP",color:"green",unit:"%"},{type:"hp_max_add",icon:"❤",label:"HP",color:"green",unit:""},\
{type:"max_hp_m",icon:"❤",label:"HP",color:"green",unit:"%"},{type:"max_hp_add",icon:"❤",label:"HP",color:"green",unit:""},\
{type:"mp_max_m",icon:"❂",label:"MP",color:"aqua",unit:"%"},{type:"mp_max_add",icon:"❂",label:"MP",color:"aqua",unit:""},\
{type:"crit_rate_add",icon:"✦",label:"会心率",color:"yellow",unit:"%"},{type:"crit_damage_add",icon:"✸",label:"会心ダメージ",color:"gold",unit:"%"},\
{type:"effect_damage_add",icon:"✧",label:"神秘",color:"light_purple",unit:""},{type:"magic_efficiency_add",icon:"✎",label:"魔導掌握",color:"aqua",unit:""},\
{type:"fire_resist_add",icon:"♨",label:"火耐性",color:"red",unit:"%"},{type:"water_resist_add",icon:"≈",label:"水耐性",color:"blue",unit:"%"},\
{type:"wood_resist_add",icon:"♣",label:"木耐性",color:"green",unit:"%"},{type:"metal_resist_add",icon:"⚙",label:"金耐性",color:"gray",unit:"%"},\
{type:"earth_resist_add",icon:"▲",label:"土耐性",color:"gold",unit:"%"},{type:"physics_resist_add",icon:"⛨",label:"物理耐性",color:"white",unit:"%"}]

# 武器の説明文で属性ごとのダメージ式を描くときの表示定義(elemはcustom_data.damageのキー)
data modify storage test: loot.table.element_display set value \
[{elem:"physics",icon:"⚔",label:"物理",color:"white"},{elem:"fire",icon:"♨",label:"火",color:"red"},\
{elem:"water",icon:"≈",label:"水",color:"blue"},{elem:"wood",icon:"♣",label:"木",color:"green"},\
{elem:"metal",icon:"⚙",label:"金",color:"gray"},{elem:"earth",icon:"▲",label:"土",color:"gold"}]

# レベルアップ1回ぶんの伸び(メインステータス・サブステータス共通)
data modify storage test: loot.table.grow set value \
[{type:"atk_m",value:0.3,},{type:"atk_add",value:8},\
{type:"def_m",value:0.3},{type:"def_add",value:8},\
{type:"hp_max_m",value:0.3},{type:"hp_max_add",value:8},\
{type:"max_hp_m",value:0.3},{type:"max_hp_add",value:8},\
{type:"mp_max_m",value:0.3},{type:"mp_max_add",value:8},\
{type:"crit_damage_add",value:0.48},{type:"crit_rate_add",value:0.24},\
{type:"effect_damage_add",value:2},{type:"magic_efficiency_add",value:1},\
{type:"fire_resist_add",value:0.3},{type:"water_resist_add",value:0.3},\
{type:"wood_resist_add",value:0.3},{type:"metal_resist_add",value:0.3},\
{type:"earth_resist_add",value:0.3},{type:"physics_resist_add",value:0.3}]
