execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone

execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "attribute_modifiers"
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "weapon"
# 防具の染め色(「染色済み」の行)は説明文の邪魔なので隠す
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "dyed_color"

# loot.context が "inventory" なら、落とさずに@s(プレイヤー)のインベントリへ直接入れる。
# 戦闘の報酬はアリーナで配った直後にプレイヤーが元の場所へ戻されるので、足元に落とすと拾えずに置き去りになるため
execute if data storage test: loot{context:"inventory"} in minecraft:overworld run return run loot give @s mine 0 -64 0 debug_stick

# 組み立て自体はオーバーワールドの 0 -64 0 で行い、できたアイテムを呼び出し元(@s)の位置・次元へ転送する。
# 呼び出し元が別の次元(戦闘アリーナなど)にいると、呼び出し元の座標から探す@nでは関係のない落ちているアイテムを
# 拾いかねないので、今spawnした位置の近くから探す
execute in minecraft:overworld run loot spawn 0 -64 1 mine 0 -64 0 debug_stick
execute in minecraft:overworld positioned 0 -64 1 run tp @n[type=item,distance=..2] @s

execute if data storage test: loot{context:"give"} run data modify entity @n[type=item] PickupDelay set value 0
