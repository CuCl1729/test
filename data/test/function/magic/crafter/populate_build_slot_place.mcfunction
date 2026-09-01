#> test:magic/crafter/populate_build_slot_place
# @macro label/color/item/slot: 表示情報と詰め先スロット番号。クリックで取ると1件だけ削除できる
# (中段のアイコンには目印として "×" を先頭に付け、消去用だとひと目で分かるようにする)

$data modify block ~ ~ ~ Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"× $(label)",italic:false,color:"$(color)"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
