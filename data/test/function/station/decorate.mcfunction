#> test:station/decorate
# @s = ステーション本体(バレルの位置)。@macro name/color/icon: ステーション名・頭上の名前の色・目印のアイテムID
# 見分けがつくよう、GUIのタイトル(バレルのCustomName)・頭上の名前(text_display)・目印(item_display)を付ける。
# 飾りは本体に乗せるので、本体がkillタグで消えるとtick.mcfunctionの道連れ処理で一緒に消える

# 既に置いてあるバレルの中身を消さないようsetblockではなくdata modifyで付ける。
# GUIの背景は明るい灰色で色付き文字が読みにくいため、タイトルは色を付けない
$data modify block ~ ~ ~ CustomName set value {text:"$(name)"}

# 本体をバレルの中心に合わせる(スポーンエッグで置く魔法クラフターや、中心からずれて置かれた既存のステーション向け)。
# 実行位置は元のままだが、同じブロックの中なのでバレルの参照はずれない
execute align xyz run teleport @s ~0.5 ~0.5 ~0.5

# placeがやり直されたときに二重にならないよう、前の飾りを消してから付け直す
execute on passengers run kill @s

# 高さはバレルの中心からの距離(バレルの上面は+0.5)。名前は上から覗き込んでも寝ないようverticalにする
$summon text_display ~ ~ ~ {Tags:[station_label,station_label_new],billboard:"vertical",transformation:{translation:[0.0f,1.9f,0.0f],scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},text:{text:"$(name)",color:"$(color)"}}
$summon item_display ~ ~ ~ {Tags:[station_label,station_label_new],billboard:"vertical",item:{id:"$(icon)",count:1},transformation:{translation:[0.0f,1.1f,0.0f],scale:[0.5f,0.5f,0.5f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}

tag @s add station_decorating
execute as @e[tag=station_label_new] run ride @s mount @n[tag=station_decorating]
tag @e[tag=station_label_new] remove station_label_new
tag @s remove station_decorating

tag @s add station_decorated
