#> test:projectile/on/hit_block/aoe
# @s = 壁や地面に阻まれた、範囲タイプと組み合わせた投射体。跳ね返らずその場で爆発して消える
# (「N回まで跳ね返ってから爆発する」ようにしたい場合は、跳ね返り回数のスコアを見て
#  まだ余裕があれば #event_result を 0 にすれば既定動作の反射にまかせられる)

function test:projectile/burst

scoreboard players set #event_result test.temporary 2
