#> test:battle/ui/skill_effect_resolve
# @s = 効果選択(トグル/決定)を行ったプレイヤー(チャット式)

scoreboard players operation #skill_effect test.battle.skill_effect = @s test.battle.skill_effect
scoreboard players set @s test.battle.skill_effect 0

# 99は詠唱ボタン
execute if score #skill_effect test.battle.skill_effect matches 99 run return run function test:battle/ui/skill_effect_cast

# それ以外はレジストリの並び順の番号なので、対応する効果の選択状態を循環させる
scoreboard players set #effect_index test.temporary 1
function test:magic/registry/queue_effects
function test:battle/ui/skill_effect_toggle_loop

# トリガーは一度使うと自動的に無効化されるため、次のクリックのために再度enableする
scoreboard players enable @s test.battle.skill_effect
function test:battle/ui/skill_effect_display
