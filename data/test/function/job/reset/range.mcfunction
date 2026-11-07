#> test:job/reset/range
# @s = 確認待ちのプレイヤー(test:tick の1秒クロックから)。ステーションから6ブロックより離れたら確認待ちを消す

function #oh_my_dat:please
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset run return run function test:job/reset/clear
function test:job/reset/range_check with storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset
