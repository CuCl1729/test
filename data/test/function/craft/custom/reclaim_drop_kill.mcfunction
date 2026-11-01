#> test:craft/custom/reclaim_drop_kill
# @s = 取り返す落ちているアイテム(数が #cc_left 以下)。まるごと消す

scoreboard players operation #cc_left test.temporary -= #cc_cn test.temporary
kill @s
