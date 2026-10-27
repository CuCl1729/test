#> test:init/asset/consumable/
# 消耗品のレジストリ。asset.consumable.<id> = {item, name, every, effect:{kind, params}}。
# 消耗品のアイテムは custom_data.test.consumable:"<id>" で見分ける(作るのは test:item/consumable/build {id})。
# 効果は test:consumable/use {id} で実行する(@s = 使う人)。効果の強さはすべてparamsに持たせ、関数に数値を書かない。
# every: 装備の自動発動の枠に設定したとき、イベントが何回起きるごとに1個使うか

data modify storage test: asset.consumable set value {}
data modify storage test: asset.consumable_ids set value []

# 各消耗品の宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1。生成先はgenerated/)
function test:init/asset/consumable/generated/consumables
