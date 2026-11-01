#> test:npc/look_at
# @s = NPC の見た目(実行位置も @s)。6ブロック以内の一番近いプレイヤーの方に顔を向ける

tag @s add npc_looking
rotate @s facing entity @p[distance=..6] eyes
