#> test:magic/root/open
# @s = 詠唱者。magic.player = 唱えた最初の段(magic.player.chain が後続、magic.player.cast が今回の通し番号)。
# つないだ先(コピー)のどこかに「一定間隔」があるか、連続+投射の段のすぐ先が「着弾」であれば、
# 今回のキャスト(cast)を発動ルートとして開く(上限は asset.config.magic_root_max_alive。繰り返す魔法すべてで共通。
# 数えるのは子ステージが出す持続物のみ)。無ければ数える必要が無いので何もしない。
# 元のmagic.player.chainは読むだけで変更しない
data remove storage test: magic.player.root
execute unless data storage test: magic.player.chain[0] run return 0

data modify storage test: root_work.chain set from storage test: magic.player.chain
data remove storage test: root_work.prev
data modify storage test: root_work.prev set from storage test: magic.player.type_flags
data remove storage test: root_work.found
function test:magic/root/open_loop
execute unless data storage test: root_work.found run return 0

data modify storage test: root_work.begin set value {}
data modify storage test: root_work.begin.id set from storage test: magic.player.cast
data modify storage test: root_work.begin.max_alive set from storage test: asset.config.magic_root_max_alive
function test:magic/root/begin with storage test: root_work.begin

data modify storage test: magic.player.root set value {child:0,counted:0b,source:0}
data modify storage test: magic.player.root.id set from storage test: magic.player.cast
return 1
