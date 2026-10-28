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
#   id:      test:equip/event・test:equip/proc/queue に渡すイベント名
#   label:   説明文の表示名
#   instant: 1bなら、消耗品の枠は回数(every)を数えず、発動のたびに1個使う(たまにしか起きないイベント向け)
#   below:   {stat, max, percent} があれば、test.status.<stat> が test.status.<max> の percent% を
#            下回った瞬間に1回発動する(戻ったらまた発動できる。tickで見張る: test:equip/proc/watch_check)
data modify storage test: asset.equip.proc_events set value [\
  {id:"magic_cast",label:"詠唱時"},\
  {id:"attack_hit",label:"命中時"},\
  {id:"damaged",label:"被ダメージ時"},\
  {id:"hp_low",label:"HP低下時",instant:1b,below:{stat:"hp",max:"hp_max",percent:30}}\
]

# アクセサリーはインベントリに入れておくだけで効く。効くのは先頭からこの個数まで
data modify storage test: asset.equip.accessory_limit set value 2

# 各品とシリーズの宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1。生成先はgenerated/)
function test:init/asset/equip/generated/items
function test:init/asset/equip/generated/sets
