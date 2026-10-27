#> test:init/asset/station
# ステーション(樽のGUI)のレジストリ。設置・飾り・モード切り替え・ボタンの検知は test:station/ が共通で行い、
# 各モードの中身(作る・強化する・魔法を組み立てる…)だけを各機能のフォルダに置く。
#
# asset.station.<id> = {name, color, icon, breakable?:1b, modes:[{id, label, icon, craft?, main?, enter?}]}
#   name/color/icon: 頭上の名前・色・目印のアイテム(GUIの題名は「name [モードのlabel]」)
#   breakable:       樽を壊すとスポーンエッグで返す(無ければ壊しても置き直す)
#   modes:           2つ以上あれば、スロット20のボタンで順に切り替える
#     label/icon:    モード名と、切り替えボタンに出すアイコン
#     craft:         ボタン型。スロット26の緑ガラスを取るとこの関数を呼ぶ
#     main:          独自の画面。毎tickこの関数を呼ぶ
#     enter:         モードに入ったときに画面を作る関数(任意)
# 関数はすべて test: を省いたパスで書く

data modify storage test: asset.station set value {}

data modify storage test: asset.station.smithy set value {name:"工房",color:"gold",icon:"anvil",modes:[\
  {id:"weapon",label:"武器",icon:"iron_sword",craft:"craft/weapon/forge/craft"},\
  {id:"armor",label:"防具",icon:"iron_chestplate",craft:"craft/equip/craft"}\
]}

data modify storage test: asset.station.enhance set value {name:"強化台",color:"red",icon:"blast_furnace",modes:[\
  {id:"upgrade",label:"強化",icon:"experience_bottle",craft:"craft/weapon/upgrade/craft"},\
  {id:"imbue",label:"付与",icon:"enchanting_table",craft:"craft/equip_magic/craft"}\
]}

data modify storage test: asset.station.magic set value {name:"魔法台",color:"light_purple",icon:"enchanted_book",breakable:1b,modes:[\
  {id:"craft",label:"作成",icon:"nether_star",main:"magic/crafter/main",enter:"magic/crafter/enter"},\
  {id:"research",label:"研究",icon:"knowledge_book",main:"craft/magic/research/main",enter:"craft/magic/research/enter"}\
]}

data modify storage test: asset.station.job set value {name:"Jobステーション",color:"green",icon:"iron_helmet",modes:[\
  {id:"skills",label:"職業",icon:"iron_helmet",main:"job/station/main",enter:"job/station/enter"}\
]}

# デバッグメニューの「ステーション」欄に並べる順
data modify storage test: asset.station_ids set value ["smithy","enhance","magic","job"]
