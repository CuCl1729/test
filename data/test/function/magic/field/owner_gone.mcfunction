#> test:magic/field/owner_gone
# @s = 持ち主が使えない状態になった場。掛けていたバフを外して終わる
# (設置物は残すが、場は残さないという決まり)
tag @a remove magic_owner
function test:magic/field/end
