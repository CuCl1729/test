#> test:init/asset/magic/effects
# 魔法効果のレジストリ。効果選択UI(チャット式/トロッコ式)はこの一覧を走査して描画するため、
# 効果を増やすときはここに1行足し、asset/magic/effect|status/<id>.mcfunction を作れば済む
#
# id:            効果識別子(素材のcustom_data・関数名・ストレージのキーに使う)
# label:         UIに出す表示名
# color:         UIに出す色
# item:          トロッコ式UIのアイコンに使うアイテム
# max:           選択状態を循環させる段階数(2なら0↔1のON/OFF、4なら0〜3の重ねがけ)
# category:      効果の系統。選択中のタイプのeffect_categoriesに含まれるものだけUIに出す
# requires_type: 指定したタイプが選ばれているときだけUIに出す(省略可)
# folder:        アセット関数の置き場所(test:asset/magic/<folder>/<id>)

data remove storage test: asset.magic.effects

data modify storage test: asset.magic.effects append value {id:"fire",label:"火炎",color:"red",item:"fire_charge",max:2,category:"attack",folder:"effect"}
data modify storage test: asset.magic.effects append value {id:"atk",label:"威力上昇",color:"gold",item:"redstone",max:4,category:"attack",folder:"status"}
data modify storage test: asset.magic.effects append value {id:"gravity",label:"重力",color:"gray",item:"feather",max:2,category:"attack",requires_type:"projectile",folder:"effect"}
data modify storage test: asset.magic.effects append value {id:"heal",label:"回復",color:"white",item:"ghast_tear",max:2,category:"support",folder:"effect"}
data modify storage test: asset.magic.effects append value {id:"range",label:"範囲拡大",color:"light_purple",item:"ender_pearl",max:4,category:"modifier",folder:"status"}
