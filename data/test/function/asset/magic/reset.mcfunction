data remove storage test: magic.loot
data modify storage test: magic.loot.name set value [""]

scoreboard players set #cost test.temporary 0
scoreboard players set #atk_stack test.temporary 0

# タイプの組み合わせ検証と、順序非依存に合算する数値の集計用
scoreboard players set #delivery_count test.temporary 0
scoreboard players set #range_stack test.temporary 0
scoreboard players set #radius_bonus test.temporary 0
