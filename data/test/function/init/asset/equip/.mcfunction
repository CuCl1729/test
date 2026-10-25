#> test:init/asset/equip/
# 防具・アクセサリーのレジストリ。1品ずつ asset.equip.items.<id> に宣言し、シリーズ(セット効果)は sets に宣言する。
# 生成は test:asset/equip/apply {id}、能力の集計は test:equip/recalc が行う
#
# custom_dataの形(武器と共通のキー。ただしbase_statusは持たせない):
#   equip:        {slot:"head"|"chest"|"legs"|"feet"|"accessory", set:"<シリーズid>"(任意)}
#   status_bonus: メインステータス {type, value}
#   level / max_level: 強化炉でのレベル

data modify storage test: asset.equip set value {items:{},sets:[]}

# アクセサリーはインベントリに入れておくだけで効く。効くのは先頭からこの個数まで
data modify storage test: asset.equip.accessory_limit set value 2

# 各品とシリーズの宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1。生成先はgenerated/)
function test:init/asset/equip/generated/items
function test:init/asset/equip/generated/sets
