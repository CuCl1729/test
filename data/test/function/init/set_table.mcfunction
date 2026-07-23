data modify storage test: loot.table.substatus set value \
[{type:"atk_m",value:3.0,status_type:"%"},{type:"atk_add",value:30.0d},\
{type:"def_m",value:3.0,status_type:"%"},{type:"def_add",value:30.0d},\
{type:"max_hp_m",value:3.0,status_type:"%"},{type:"max_hp_add",value:30.0d},\
{type:"crit_damage_add",value:4.8,status_type:"% "},{type:"crit_rate_add",value:2.4,status_type:"%"},\
{type:"effect_damage_add",value:10.0d},{type:"magic_efficiency_add",value:5.0d}]

data modify storage test: loot.table.substatusName set value \
[[{italic:false,color:gray,text:"攻撃力:"},{color:aqua,italic:false,text:"3.0"},{italic:false,color:gray,text:"% "}],[{italic:false,color:gray,text:"攻撃力:"},{color:aqua,italic:false,text:"30"},{text:" "}],\
[{italic:false,color:gray,text:"防御力:"},{color:aqua,italic:false,text:"3.0"},{italic:false,color:gray,text:"% "}],[{italic:false,color:gray,text:"防御力:"},{color:aqua,italic:false,text:"30"},{text:" "}],\
[{italic:false,color:gray,text:"HP:"},{color:aqua,italic:false,text:"3.0"},{italic:false,color:gray,text:"% "}],[{italic:false,color:gray,text:"HP:"},{color:aqua,italic:false,text:"30"},{text:" "}],\
[{italic:false,color:gray,text:"会心ダメージ:"},{color:aqua,italic:false,text:"4.8"},{italic:false,color:gray,text:"% "}],[{italic:false,color:gray,text:"会心率:"},{color:aqua,italic:false,text:"2.4"},{italic:false,color:gray,text:"% "}],\
[{italic:false,color:gray,text:"神秘:"},{color:aqua,italic:false,text:"10"},{text:" "}],[{italic:false,color:gray,text:"魔導掌握:"},{color:aqua,italic:false,text:"5"},{text:" "}]]

data modify storage test: loot.table.grow set value \
[{type:"atk_m",value:0.3,},{type:"atk_add",value:8},\
{type:"def_m",value:0.3},{type:"def_add",value:8},\
{type:"max_hp_m",value:0.3},{type:"max_hp_add",value:8},\
{type:"crit_damage_add",value:0.48},{type:"crit_rate_add",value:0.24},\
{type:"effect_damage_add",value:2},{type:"magic_efficiency_add",value:1}]
