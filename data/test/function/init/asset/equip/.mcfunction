#> test:init/asset/equip/
# 防具・アクセサリーのレジストリ。1品ずつ asset.equip.items.<id> に宣言し、シリーズ(セット効果)は sets に宣言する。
# 生成は test:asset/equip/apply {id}、能力の集計は test:equip/recalc が行う
#
# custom_dataの形(武器と共通のキー。ただしbase_statusは持たせない):
#   equip:        {slot:"head"|"chest"|"legs"|"feet"|"accessory", set:"<シリーズid>"(任意)}
#   status_bonus: メインステータス {type, value}
#   level / max_level: 強化炉でのレベル
#   equip.procs:  自動発動の枠 [{event, magic?, name?}, …]。eventは作るとき(test:asset/equip/apply)にレア度の数だけ
#                 proc_eventsから抽選する。magic(魔法アイテムのcustom_data.test)とname(その名前)は魔法付与台(craft/equip_magic/)で入る

data modify storage test: asset.equip set value {items:{},sets:[]}

# 自動発動の枠のイベント(抽選はこのリストの何番目かを引くので、増やすときはここに足すだけでよい)。
# labelは説明文の表示名。idはtest:equip/eventのeventと同じもの
data modify storage test: asset.equip.proc_events set value [{id:"magic_cast",label:"魔法を唱えたとき"},{id:"attack_hit",label:"攻撃が当たったとき"},{id:"damaged",label:"ダメージを受けたとき"}]

# アクセサリーはインベントリに入れておくだけで効く。効くのは先頭からこの個数まで
data modify storage test: asset.equip.accessory_limit set value 2

# 各品とシリーズの宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1。生成先はgenerated/)
function test:init/asset/equip/generated/items
function test:init/asset/equip/generated/sets
