#> test:battle/enemy_ai/gimmick/curse
# @s = 手番の敵。@macro buff/stacks/chance/target: プレイヤーに付けるバフ・段数・確率(%)・
# 対象(one=一番近い1人 / all=全員)。プレイヤーにデバフをかける

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は呪いをかけた！",color:dark_purple}]

$data modify storage test: buff_work.pending set value [{id:"$(buff)",stacks:$(stacks),chance:$(chance)}]
scoreboard players operation #target_battle test.battle.id = @s test.battle.id
$function test:battle/enemy_ai/part/target_$(target) {fn:"curse_hit"}

function test:battle/turn_end
