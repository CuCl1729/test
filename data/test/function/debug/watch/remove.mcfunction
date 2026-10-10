#> test:debug/watch/remove
# @macro name/objective: 監視をやめるスコア。サイドバーの行も消す

$data remove storage test: debug.watch[{name:"$(name)",objective:"$(objective)"}]
$scoreboard players reset $(objective)/$(name) test.debug.display

$function test:debug/menu/done {msg:"$(name) $(objective) を監視から外しました"}
