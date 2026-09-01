#> test:attack/hit_buff
# @s = ダメージを受けた対象(リアルタイム)。武器が「命中時に付与するバフ」を持っていれば付与する
#
# 武器のcustom_dataはtest:attack/prepareが storage test: attack.player へ載せてあるので、
# ここでメインハンドを読み直す必要はない(1振りで複数体に当たる範囲攻撃でも同じ値を使える)
#
# attack.player は custom_data を丸ごと写したものなので、武器のフラグ類は test.* の下にある
# (custom_data.weapon[] のような直下の値と混同しないこと)

execute unless entity @s[scores={test.status.hp=1..}] run return 0

data modify storage test: buff_work.pending set value []
execute if data storage test: attack.player.test.buff_on_hit[0] run data modify storage test: buff_work.pending set from storage test: attack.player.test.buff_on_hit

execute if data storage test: buff_work.pending[0] run function test:buff/apply_list
