#> test:debug/watch/tick_entry
# @macro name/objective: 監視中の1件。行の名前はobjectiveから始める(nameが@から始まるセレクターでも
# 行の名前がセレクターとして読まれないように)。値が未設定なら行を消しておく

$execute unless score $(name) $(objective) = $(name) $(objective) run return run scoreboard players reset $(objective)/$(name) test.debug.display
$scoreboard players operation $(objective)/$(name) test.debug.display = $(name) $(objective)
