#> test:magic/battle_allowed_effect_entry
# @macro id: battle:0bが付いた効果id。直接効果(magic.player.effect)か付与バフ(magic.player.buff)の
# どちらかで使われていれば#battle_magic_ok test.temporaryを0にする(既に0なら上書きしない)

$execute if data storage test: magic.player{effect:["$(id)"]} run scoreboard players set #battle_magic_ok test.temporary 0
$execute if data storage test: magic.player.buff[{id:"$(id)"}] run scoreboard players set #battle_magic_ok test.temporary 0
