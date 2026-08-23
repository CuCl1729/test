execute unless data storage test: magic.loot.name[{text:"Nova"}] run data modify storage test: magic.loot.name append value {italic:0b,color:light_purple,text:"Nova"}

data modify storage test: magic.loot.status.aoe merge value {radius:5}

# 組み合わせ検証で「どのタイプが使われたか」を引けるようにフラグを立てる
data modify storage test: magic.loot.status.type_flags.aoe set value 1b

# 投射体へタグとしてまとめてコピーできるよう、id のリストにも積んでおく(magic/projectile/cast参照)
data modify storage test: magic.loot.status.types append value "aoe"

# 修飾子タイプなのでmagic_typeは未設定のときだけ自分をセットする(デリバリと組んだ場合は
# デリバリ側が勝ち、単体で使われた場合はこれ自身が届け方になる)
execute unless data storage test: magic.loot.status.magic_type run data modify storage test: magic.loot.status.magic_type set value "aoe"

scoreboard players add #cost test.temporary 80
