#> test:mine/tick_second
# 1秒に1回(test:tick)。全部の鉱山について、test:action と test:turn のそれぞれで中に人がいるかを調べ、
# 誰もいなかった鉱山に人が入ったら元に戻す(test:mine/check_area)。ターン制のアリーナ(test:arena)は調べない

execute store result score #mine_now test.temporary run time query gametime
data modify storage test: mine_work.mine_queue set from storage test: asset.mine_ids
function test:mine/tick_loop
