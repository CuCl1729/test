#> test:magic/battle_allowed_type_entry
# @macro id: battle:0bが付いたタイプid。magic.player.type_flagsにあるか、旧形式のmagic.player.magic_type
# がこのidと一致していれば#battle_magic_ok test.temporaryを0にする(既に0なら上書きしない)

$execute if data storage test: magic.player.type_flags{$(id):1b} run scoreboard players set #battle_magic_ok test.temporary 0
$execute if data storage test: magic.player{magic_type:"$(id)"} run scoreboard players set #battle_magic_ok test.temporary 0
