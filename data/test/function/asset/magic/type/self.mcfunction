execute unless data storage test: magic.loot.name[{text:"Self"}] run data modify storage test: magic.loot.name append value {italic:0b,color:white,text:"Self"}

# デリバリタイプはmagic_typeを無条件に上書きする(修飾子タイプは未設定のときだけ書き込むため、
# 素材を置くスロットの順番に関係なくデリバリ側が勝つ)
data modify storage test: magic.loot.status.magic_type set value "self"

# 組み合わせ検証で「どのタイプが使われたか」を引けるようにフラグを立てる
data modify storage test: magic.loot.status.type_flags.self set value 1b

# 投射体へタグとしてまとめてコピーできるよう、id のリストにも積んでおく(magic/projectile/cast参照)
data modify storage test: magic.loot.status.types append value "self"

scoreboard players add #delivery_count test.temporary 1
scoreboard players add #cost test.temporary 20
