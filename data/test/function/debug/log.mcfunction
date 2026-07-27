#> test:debug/log
# $(msg) = 表示したい文字列

$execute if score #debug test.debug.enabled matches 1 run tellraw @a [{text:"[DEBUG] ",color:gray},{text:"$(msg)"}]