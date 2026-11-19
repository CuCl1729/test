#> test:buff/events/fire
# 内部。@macro target: 仕事の的の OhMyDatID。距離を付けない @e は別の次元も見るので、
# 自作次元でもそのまま見つかる。的が見当たらなければ、何もせず静かに流す。
# 公開イベントを書くのは枠を退避したあと(fire_at)。ここで書くと呼び出し元の分を取り逃がす

$execute as @e[scores={OhMyDatID=$(target)},limit=1] at @s run function test:buff/events/fire_at
