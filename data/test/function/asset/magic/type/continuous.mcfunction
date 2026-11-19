# 継続: 一度の詠唱が時間をかけて効き続けるようにする修飾子。届け方そのものではないので、
# どんな形になるか(場 / ビーム / 自己持続)は「組み合わせ」タブの表が決める(test:magic/combo/match)
#   period:        効果を出す間隔(tick)。20 なら1秒ごと。表示の数値は「1秒あたり」なので、
#                  1パルスぶんは period / 20 倍になる
#   duration:      有限の持続形態(場・自己持続・自動ビーム)が続く秒数
#   mp_per_second: プレイヤーが押し続けるビームの毎秒の維持MP(内部値)。ビーム1本あたり
$data modify storage test: magic.loot.status.continuous merge value {period:$(period),duration:$(duration),mp_per_second:$(mp_per_second)}

data modify storage test: magic.loot.status.type_flags.continuous set value 1b
data modify storage test: magic.loot.status.types append value "continuous"

$scoreboard players add #cost test.temporary $(cost)
