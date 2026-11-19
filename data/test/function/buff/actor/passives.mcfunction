#> test:buff/actor/passives
# @s = 対象。層カーネル(test:buff/layers/evaluate)の arg.passives に渡す受け身の取り分を作る。
#   storage test: buff_actor.passives = [{stat:"<名前>",value:<P>}, …](asset.buff.stats の全ステータス)
# P の中身は test:status/passive(プレイヤーは装備＋職業＋レベル、それ以外は召喚時の基礎値)。
# プレイヤーは装備ぶんのキャッシュを作り直してから読む(test:status/gear)。
# 全部そろったら 1、1件でも作れなかったら storage から passives を消して 0 を返す

scoreboard players set #ba_mode test.buff.work 0
data modify storage test: buff_actor.passives set value []
function test:buff/actor/stat_loop

# 1件でも作れなかったら途中までの一覧は捨てる(欠けた一覧を成功として渡さない)
execute if score #ba_err test.buff.work matches 1.. run data remove storage test: buff_actor.passives
execute if score #ba_err test.buff.work matches 1.. run return 0
return 1
