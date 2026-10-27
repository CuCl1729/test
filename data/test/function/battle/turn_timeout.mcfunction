#> test:battle/turn_timeout
# @s = 手番のプレイヤー(at @s)。30秒以内に行動しなかったので、行動UIを片付けて防御させる(防御がturn_endまで進める)

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は時間切れのため防御した",color:gray}]

function test:battle/ui/cleanup
function test:battle/action/defend
