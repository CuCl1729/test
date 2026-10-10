#> test:debug/watch/add
# @macro name/objective: 監視するスコア(名前は#付きの偽プレイヤー・プレイヤー名・セレクターのどれでもよい)。
# サイドバー(test.debug.display)に「<objective>/<name>」の行で毎tick写す(test:debug/watch/tick)

$data remove storage test: debug.watch[{name:"$(name)",objective:"$(objective)"}]
$data modify storage test: debug.watch append value {name:"$(name)",objective:"$(objective)"}

function test:debug/on
$function test:debug/menu/done {msg:"$(name) $(objective) を監視に追加しました"}
