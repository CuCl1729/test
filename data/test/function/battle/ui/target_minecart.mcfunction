#> test:battle/ui/target_minecart
# @s = 対象を選ぶプレイヤー(トロッコ式)。既存の効果選択トロッコがあれば使い回し、なければ新規召喚する
# (通常攻撃からの場合は既存トロッコが無いので新規召喚になる。敵が2体以上いる場合のみ呼ばれる想定)
#
# 変換するのは「効果選択トロッコ」だけに絞る。以前は近くのskill_minecartをまとめてtarget_minecart扱いに
# していたため、無関係なカート(タイプ選択用など)まで対象選択タグを持ってしまい、
# skill_hover_hideの掃除対象からも外れて中身が食い違ったまま残り続ける不具合になっていた

execute if entity @e[tag=skill_effect_minecart,distance=..3] run tag @e[tag=skill_effect_minecart,distance=..3] add target_minecart
execute if entity @e[tag=skill_effect_minecart,distance=..3] run tag @e[tag=skill_effect_minecart,distance=..3] remove skill_effect_minecart

execute unless entity @e[tag=target_minecart,distance=..3] anchored eyes positioned ^ ^-0.35 ^ run summon chest_minecart ~ ~ ~ {Tags:[skill_minecart,target_minecart],NoGravity:1b,Invulnerable:1b}

# 効果選択から続けて来た場合、awaiting_skillがそのまま残っていると敵ターン等が止まり続けるため
# ここで確実にクリアする(通常攻撃から来た場合はそもそも0のまま無害)
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_target 2

tag @e remove battle_target

function test:battle/ui/target_minecart_populate

tellraw @s [{text:"トロッコを開いて、攻撃対象を選び「決定する」を取ってください",color:light_purple}]
