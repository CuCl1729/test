#> test:status/recalc
# @s = 対象。@macro status: 対象のステータス名 / op: add|remove / amount: 今回動いたバフぶんの量
# バフの蓄積値(test.buff.<名前>)を反映した実効値を test.status.<名前> に入れ直す
# (test:buff/stat/add・test:buff/stat/remove から呼ぶ)

# プレイヤーは装備から組み立て直す status/update がバフぶんも足してくれる。ただしターン制の
# アイテム式UIではメインハンドが行動アイテムに入れ替わっているため、ここで組み立て直すと
# 武器の補正が失われる(damage/pre_magic と同じ事情)。その場合だけは組み立て直さず、
# 今回動いたぶんを実効値へ直接反映する(次の手番の battle/ui/item で正しく組み直される)
scoreboard players set #recalc_rebuild test.buff.work 0
execute if entity @s[type=player] run scoreboard players set #recalc_rebuild test.buff.work 1
execute if entity @s[type=player] if score @s test.battle.id matches 1.. if score @s test.settings.battle_ui matches 2 run scoreboard players set #recalc_rebuild test.buff.work 0

$execute if score #recalc_rebuild test.buff.work matches 1 run function test:status/update {status:"$(status)"}
$execute if entity @s[type=player] if score #recalc_rebuild test.buff.work matches 0 run scoreboard players $(op) @s test.status.$(status) $(amount)

# 敵は status/update を通らない(召喚時に一度設定されるだけ)ため、
# 召喚時に控えておいた基礎値(asset/enemy/summon 参照)へバフぶんを足す
$execute unless entity @s[type=player] run scoreboard players operation @s test.status.$(status) = @s test.status.base.$(status)
$execute unless entity @s[type=player] run scoreboard players operation @s test.status.$(status) += @s test.buff.$(status)
