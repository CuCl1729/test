#> test:magic/root/commit
# @s = 呪文を唱えた本人。今のステージ(magic.player.root)がまだ1回も数えられていなければ、
# 持ち主のルート元帳(magic_roots)から1回分を消費して「数えた」ことにする。
# 複数発射などで同じステージの効果が何度出ても、最初の1回だけ数える
execute unless data storage test: magic.player.root run return 1
execute if data storage test: magic.player.root{child:0} run return 1
execute if data storage test: magic.player.root{counted:1b} run return 1

return run function test:magic/root/commit_entry with storage test: magic.player.root
