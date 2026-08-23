#> test:init/asset/magic/types
# 魔法タイプのレジストリ。UI表示・バリデーション・ディスパッチはすべてこの一覧を走査して行うため、
# タイプを増やすときはここに1行足し、asset/magic/type/<id>.mcfunction と
# (roleがdeliveryなら)magic/<id>/cast.mcfunction・battle/action/skill_cast/<id>.mcfunction を作れば済む
#
# id:               タイプ識別子(素材のcustom_data・関数名・ストレージのキーに使う)
# label:            UIに出す表示名
# color:            UIに出す色
# item:             トロッコ式UIのアイコンに使うアイテム
# role:             delivery=届け方(排他。2つ以上選ぶと不正) / modifier=修飾子(deliveryに重ねられる)
# conflicts:        同時に選べないタイプidの一覧(相互に書いておく)
# effect_categories: このタイプと組み合わせられる効果のcategory一覧(効果選択UIの出し分けに使う)

data remove storage test: asset.magic.types

data modify storage test: asset.magic.types append value {id:"self",label:"自己",color:"aqua",item:"glass_bottle",role:"delivery",conflicts:["aoe"],effect_categories:["support"]}
data modify storage test: asset.magic.types append value {id:"projectile",label:"投射",color:"gold",item:"snowball",role:"delivery",conflicts:[],effect_categories:["attack"]}
data modify storage test: asset.magic.types append value {id:"aoe",label:"範囲",color:"light_purple",item:"tnt",role:"modifier",conflicts:["self"],effect_categories:["attack","support","modifier"]}
