# ステータスの表(サブステータスの抽選表・レベルアップの伸び・説明文の表示)はスプレッドシートの「ステータス」タブから
# 生成している(tools/datasheet/generate.ps1 → init/asset/generated/stats)。
# 抽選表は抽選値(0始まり)がそのまま添字。武器は0..loot.table.substatus_weapon_max、防具・アクセサリーは
# 0..loot.table.substatus_armor_max を引く(storage test: loot.substatus_maxで指定)
function test:init/asset/generated/stats

# 武器の説明文で属性ごとのダメージ式を描くときの表示定義(elemはcustom_data.damageのキー)
data modify storage test: loot.table.element_display set value \
[{elem:"physics",icon:"⚔",label:"物理",color:"white"},{elem:"fire",icon:"♨",label:"火",color:"red"},\
{elem:"water",icon:"≈",label:"水",color:"blue"},{elem:"wood",icon:"♣",label:"木",color:"green"},\
{elem:"metal",icon:"⚙",label:"金",color:"gray"},{elem:"earth",icon:"▲",label:"土",color:"gold"}]
