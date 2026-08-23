#> test:magic/registry/queue_effects
# 効果レジストリを registry_work.effect_queue へ、末尾から取り出すとレジストリ定義順になる形で積む
# registry_workは呼び出し元が先に書いた値(combo等)を保持したまま使うため、ここで丸ごと初期化しないこと
# (かつて入れていた「複合タグでなければ{}にする」ガードは判定が効かず毎回リセットしてしまい、
#  確定処理で直前に書いた選択状態が消える不具合になった)

data modify storage test: registry_work.reverse_src set from storage test: asset.magic.effects
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop
data modify storage test: registry_work.effect_queue set from storage test: registry_work.reverse_dst
