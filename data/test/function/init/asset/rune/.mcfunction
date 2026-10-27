#> test:init/asset/rune/
# ルーンのレジストリ。asset.rune.<id> = {item, name, status:[{type,value}…]}(statusの書き方は装備のサブステータスと同じ)。
# ルーンのアイテムは custom_data.test.rune:"<id>" で見分ける(作るのは test:item/rune/build {id})。
# 付与台(craft/equip_magic/)で装備の自動発動の枠に入れると、その時点のstatusが枠に写され、常に能力を上げる

data modify storage test: asset.rune set value {}
data modify storage test: asset.rune_ids set value []

# 各ルーンの宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1。生成先はgenerated/)
function test:init/asset/rune/generated/runes
