#> test:damage/apply_type
#
# 指定した属性(type)について、抵抗力・ダメージ増加率・防御係数を適用し、
# 対象のHPを減算する。damage/ から属性ごとに呼び出される。
# @macro type: fire | water | wood | metal | earth | physics

$scoreboard players operation #victim test.$(type)_resist = @s test.$(type)_resist
$scoreboard players operation #victim test.$(type)_damage_inc.bonus = @s test.$(type)_damage_inc.bonus

# 耐性の倍率(%) = 100 − 耐性 + 攻撃側の耐性貫通 + 防御側の耐性デバフ。耐性が100以上で貫通が無ければ0(その属性は効かない)。
# 負のまま掛けるとダメージが負になり、下のオーバーフロー対策でカンストして一撃で倒れてしまうので0で止める
$scoreboard players operation #victim test.$(type)_resist -= #100 test.constant
$scoreboard players operation #victim test.$(type)_resist *= #-1 test.constant
$scoreboard players operation #victim test.$(type)_resist += #damage test.$(type)_resist.pene
$scoreboard players operation #victim test.$(type)_resist += @s test.$(type)_resist.debuff
$execute if score #victim test.$(type)_resist matches ..-1 run scoreboard players set #victim test.$(type)_resist 0
$scoreboard players operation #victim test.$(type)_damage *= #victim test.$(type)_resist
$scoreboard players operation #victim test.$(type)_damage /= #100 test.constant

# 被ダメージ増加率(%)も、負なら0として扱う
$execute if score #victim test.$(type)_damage_inc.bonus matches ..-1 run scoreboard players set #victim test.$(type)_damage_inc.bonus 0
$scoreboard players operation #victim test.$(type)_damage *= #victim test.$(type)_damage_inc.bonus
$scoreboard players operation #victim test.$(type)_damage /= #100 test.constant

$scoreboard players operation #victim test.$(type)_damage *= #victim test.status.def
$scoreboard players operation #victim test.$(type)_damage /= #100 test.constant

# どの倍率も0以上なので、ここで負になっているのは2^31を超えて値が回ったときだけ。その場合は上限として扱う
$execute if score #victim test.$(type)_damage matches ..-1 run scoreboard players set #victim test.$(type)_damage 2147483647

# HPを引く。ダメージが今のHP以上なら0にする(HPが既に負のときに大きな値を引くと、値が回って正に戻り生き返るため)
$execute if score #victim test.$(type)_damage >= @s test.status.hp run return run scoreboard players set @s test.status.hp 0
$scoreboard players operation @s test.status.hp -= #victim test.$(type)_damage
