#> test:battle/action/defend
# @s = 防御を選んだ行動者(プレイヤー・敵どちらも共通)。防御力を底上げするバフを自分に付与する

function test:buff/apply {id:"guard",stacks:1}

function test:battle/turn_end