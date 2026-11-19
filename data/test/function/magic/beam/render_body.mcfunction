#> test:magic/beam/render_body
# @s = 持続ビームの実際の親(プレイヤー本人、または自動ビームの実体)。実行位置・向き = ビームの根元と向き。
# 描く前に、抱えている beam_link があれば今回の render 1回ぶんの積荷(link_work/beam_events)を用意し、
# 描き終えたら積荷の状態を書き戻してから(繋がっていれば)子を流す。
# 経過 tick は、押し続けなら #beam_owed(0以下は0扱い)、自動なら常に1
scoreboard players set #beam_link_delta test.temporary 1
execute if entity @s[type=player] run scoreboard players operation #beam_link_delta test.temporary = #beam_owed test.temporary
execute if entity @s[type=player] if score #beam_link_delta test.temporary matches ..0 run scoreboard players set #beam_link_delta test.temporary 0

execute if data storage test: magic.player.beam_link run function test:magic/beam/link/frame

execute if entity @s[type=player] run function test:magic/beam/fan
execute unless entity @s[type=player] run scoreboard players set #beam_index test.temporary 0
execute unless entity @s[type=player] run function test:magic/beam/ray

execute if data storage test: magic.player.beam_link run data modify storage test: magic.player.beam_link.states set from storage test: link_work.states

# ここまでの線のダメージ/強化で OhMyDat のポインタが動いていることがあるので、書き戻す直前に当て直す
execute if entity @s[type=player] if data storage test: magic.player.beam_link run function #oh_my_dat:please
execute if entity @s[type=player] if data storage test: magic.player.beam_link run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.beam set from storage test: magic.player
execute unless entity @s[type=player] if data storage test: magic.player.beam_link run data modify entity @s data.beam set from storage test: magic.player

# 子(着弾/一定間隔の先)を始める前に、この render で付いた印は外しておく
execute if data storage test: magic.player.beam_link run tag @a remove damage_attacker
execute if data storage test: magic.player.beam_link run tag @e remove beam_hit

execute if data storage test: magic.player.beam_link run function test:magic/beam/link/drain
