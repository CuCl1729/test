#> test:item/weapon/lore/render
# storage test: loot.item(剣・杖)の説明文(lore)を、custom_dataから毎回まるごと作り直す。
# 作成時(test:asset/weapon/)とレベルアップ時(test:item/weapon/level_up/)の両方から呼ぶ。
# 名前(種類・素材・レベル・レア度の色)で分かることは書かず、数値・性能・特殊効果だけを書く
#
# 1行は storage test: lore_work.line に部品を積んで作り(line_begin → 部品 → commit)、
# 数値はnumが@n[tag=text](text_display)に通して文字列に解決してから部品にする
# (text_displayはtextを読み込むときにscoreコンポーネントを解決するため)

data modify storage test: loot.item.components."minecraft:lore" set value []
data modify storage test: lore_work.data set from storage test: loot.item.components."minecraft:custom_data"

# メインの2行(基礎ステータスと、+で足されるステータスボーナス)
execute if data storage test: lore_work.data.base_status run function test:item/weapon/lore/stat_entry_main {key:"base_status",sign:""}
execute if data storage test: lore_work.data.status_bonus run function test:item/weapon/lore/stat_entry_main {key:"status_bonus",sign:"+"}

# 性能(射程・ダメージ式・魔法ダメージ)。どれも無い武器では見出しごと出さない
scoreboard players set #lore_has_perf test.temporary 0
execute if data storage test: lore_work.data.weapon[{type:"reach"}] run scoreboard players set #lore_has_perf test.temporary 1
execute if data storage test: lore_work.data.damage run scoreboard players set #lore_has_perf test.temporary 1
execute if data storage test: lore_work.data.magic_damage_bonus run scoreboard players set #lore_has_perf test.temporary 1
execute if score #lore_has_perf test.temporary matches 1 run function test:item/weapon/lore/section_performance

# サブステータス
execute if data storage test: lore_work.data.substatus[0] run function test:item/weapon/lore/header {title:"サブステータス"}
data modify storage test: lore_work.sub_queue set value []
data modify storage test: lore_work.sub_queue set from storage test: lore_work.data.substatus
function test:item/weapon/lore/substatus_loop

# 特殊効果(素材で付いた能力)。無ければ見出しごと出さない
scoreboard players set #lore_has_special test.temporary 0
execute if data storage test: lore_work.data.test{aoe_attack:1b} run scoreboard players set #lore_has_special test.temporary 1
execute if data storage test: lore_work.data.test.buff_on_hit[0] run scoreboard players set #lore_has_special test.temporary 1
execute if score #lore_has_special test.temporary matches 1 run function test:item/weapon/lore/section_special

# 防具・アクセサリーの自動発動の枠(イベントは作るときに抽選、魔法は魔法付与台で付ける)
execute if data storage test: lore_work.data.equip.procs[0] run function test:item/weapon/lore/section_proc

# 防具のシリーズ(セット効果)。宣言はasset.equip.sets
execute if data storage test: lore_work.data.equip.set run function test:item/weapon/lore/section_set with storage test: lore_work.data.equip

# アクセサリーは着けるのではなく、インベントリに入れておくと効く(名前からは分からないので書いておく)
execute if data storage test: lore_work.data.equip{slot:"accessory"} run function test:item/weapon/lore/accessory_note
