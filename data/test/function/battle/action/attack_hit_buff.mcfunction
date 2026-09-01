#> test:battle/action/attack_hit_buff
# @s = ダメージを受けた対象。攻撃者は一時タグbattle_attackerで参照する
# 攻撃者が「命中時に付与するバフ」を持っていれば対象へ付与する
#
# 1件の形は魔法側と同じ {id:"poison",stacks:1,chance:50}(chanceは省略可=必ず付与)。
# 確率判定はtest:buff/apply_queue_entryが行うので、ここは一覧を渡すだけでよい

# 倒した相手に付けても意味がないので、生きている場合だけ
execute unless entity @s[scores={test.status.hp=1..}] run return 0

data modify storage test: buff_work.pending set value []

# 敵はエンティティのカスタムNBT(data.buff_on_hit)に持つ。
# 持っていなければコピーが失敗して空リストのままになる
execute if entity @e[tag=battle_attacker,limit=1,type=!player] run data modify storage test: buff_work.pending set from entity @e[tag=battle_attacker,limit=1,type=!player] data.buff_on_hit

# プレイヤーは武器のcustom_dataに持つが、アイテム式UIではメインハンドが行動アイテムに
# 入れ替わっているため直接は読めない。手番開始時に控えておいたものを使う(battle/turn_start_player)
execute if entity @e[tag=battle_attacker,limit=1,type=player] run data modify storage test: buff_work.pending set from storage test: battle.actor_weapon.buff_on_hit

execute if data storage test: buff_work.pending[0] run function test:buff/apply_list
