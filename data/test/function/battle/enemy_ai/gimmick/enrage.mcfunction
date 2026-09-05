#> test:battle/enemy_ai/gimmick/enrage
# @s = 手番の敵。自分に攻撃力上昇バフを与えてから通常攻撃する(「怒り」演出)

tellraw @a ["",{selector:"@s"},{text:" は怒りに震えている！",color:red}]

function test:buff/apply {id:"atk_up",stacks:2}

function test:battle/action/attack
