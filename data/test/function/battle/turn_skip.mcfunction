#> test:battle/turn_skip
# @s = 戦闘マーカー(at @s)。手番のプレイヤーがいない(ログアウトした・アリーナから離れた)ので、手番を飛ばす。
# turn_endは@sがマーカーでも動く(マーカーはbuffedではなく、戦闘IDを持っている)。
# プレイヤーが1人もいなければ、check_endが@aだけを数えるので敗北で終わり、アリーナが空く

tellraw @a[distance=..64] [{text:"手番のプレイヤーがいないため、手番を飛ばした",color:gray}]

# その人が開いたままのトロッコと選択状態を片付ける(本人がいないので手元のアイテムは戻ってきたときにrejoinで消す)
execute as @e[tag=skill_minecart,distance=..64] run data remove entity @s Items
kill @e[tag=skill_minecart,distance=..64]
execute as @e[tag=item_minecart,distance=..64] run data remove entity @s Items
kill @e[tag=item_minecart,distance=..64]
scoreboard players set @s test.battle.awaiting_skill 0
scoreboard players set @s test.battle.awaiting_target 0
function test:battle/target/clear

function test:battle/turn_end
