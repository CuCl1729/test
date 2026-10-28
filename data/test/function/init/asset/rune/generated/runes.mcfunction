# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/rune/generated/runes
# ルーンの宣言(スプレッドシートの「ルーン」タブ)。asset.rune.<id> = {item, name, status:[{type,value}…]}。
# 付与台(craft/equip_magic/)で装備の自動発動の枠に入れると、statusが枠に写され、常に能力を上げる。
# asset.rune_ids は全種類のidの一覧(デバッグで配るときに使う)

data modify storage test: asset.rune.power_rune set value {item:"amethyst_shard",name:"力のルーン",status:[{type:"atk_m",value:5}]}
data modify storage test: asset.rune_ids append value "power_rune"
data modify storage test: asset.rune.guard_rune set value {item:"prismarine_crystals",name:"守りのルーン",status:[{type:"def_add",value:20}]}
data modify storage test: asset.rune_ids append value "guard_rune"
data modify storage test: asset.rune.vigor_rune set value {item:"echo_shard",name:"活力のルーン",status:[{type:"hp_max_m",value:5}]}
data modify storage test: asset.rune_ids append value "vigor_rune"
data modify storage test: asset.rune.mana_rune set value {item:"experience_bottle",name:"知識のルーン",status:[{type:"mp_max_m",value:5}]}
data modify storage test: asset.rune_ids append value "mana_rune"
