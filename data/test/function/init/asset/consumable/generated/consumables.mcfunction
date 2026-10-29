# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/consumable/generated/consumables
# 消耗品の宣言(スプレッドシートの「消耗品」タブ)。asset.consumable.<id> = {item, name, every, effect:{kind, params}}。
# 効果は test:consumable/use {id} が test:consumable/effect/<kind> にparamsを渡して実行する。
# 付与台で装備の自動発動の枠に設定すると、イベントが every 回起きるごとに1個自動で使う。
# asset.consumable_ids は全種類のidの一覧(デバッグで配るときに使う)

data modify storage test: asset.consumable.healing_potion set value {item:"glistering_melon_slice",name:"回復薬",every:3,effect:{kind:"heal_hp",params:{percent:20,flat:10}}}
data modify storage test: asset.consumable_ids append value "healing_potion"
data modify storage test: asset.consumable.mana_dust set value {item:"lapis_lazuli",name:"魔力の粉",every:3,effect:{kind:"heal_mp",params:{flat:20,percent:0}}}
data modify storage test: asset.consumable_ids append value "mana_dust"
data modify storage test: asset.consumable.power_dust set value {item:"sugar",name:"力の粉",every:3,effect:{kind:"self_buff",params:{id:"atk_up",stacks:1}}}
data modify storage test: asset.consumable_ids append value "power_dust"
data modify storage test: asset.consumable.revive_feather set value {item:"feather",name:"蘇生の羽",every:1,effect:{kind:"revive",params:{percent:30,radius:8}}}
data modify storage test: asset.consumable_ids append value "revive_feather"
