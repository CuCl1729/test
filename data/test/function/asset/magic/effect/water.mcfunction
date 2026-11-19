data modify storage test: magic.loot.status.effect append value "water"

# setではなくmergeを使う。setだとdata.magic.waterコンパウンド全体を上書きしてしまい、
# 既存のレガシーな属性別キー(.atk等、古い魔法アイテム互換用)を消してしまうことがあった
# (要素は追加した順とは逆順で組み立てられるため、水流を先・他の設定を後にクリックした場合に発生)
$data modify storage test: magic.loot.status.data.magic.water merge value {base:$(base)}

$scoreboard players add #cost test.temporary $(cost)
