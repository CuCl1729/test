#> test:battle/enemy_ai/gimmick/enrage
# @s = 手番の敵。@macro buff/stacks: 自分に付けるバフと段数。バフを付けてから通常攻撃する(「怒り」演出)

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は怒りに震えている！",color:red}]

$function test:buff/apply {id:"$(buff)",stacks:$(stacks)}

function test:battle/action/attack
