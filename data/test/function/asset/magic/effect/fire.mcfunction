data modify storage test: magic.loot.status.effect append value "fire"

# setではなくmergeを使う。setだとdata.magic.fireコンパウンド全体を上書きしてしまい、
# 威力上昇(asset/magic/status/atk)が先に書き込んだ.atkキーを消してしまうことがあった
# (要素は追加した順とは逆順で組み立てられるため、火炎を先・威力上昇を後にクリックした場合に発生)
data modify storage test: magic.loot.status.data.magic.fire merge value {base:1000}

scoreboard players add #cost test.temporary 50