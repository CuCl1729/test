#> test:buff/fire_entry
# @s = バフ保持者。@macro = {event,id,stacks,reason,at}
# レジストリの events に宣言されているイベントだけ test:buff/on/<event>/<id> へ振り分ける
# (projectile/event_type と同じ流儀。宣言していなければ関数が無くても呼ばれない)
#
# イベント関数へは以下で情報を渡す:
#   #buff_stacks test.buff.work … そのバフの現在のスタック数
#   #buff_at     test.buff.work … timer/interval で「何秒経過時点か」
#   storage test: buff_work.ev.reason … expire の理由(expire/refresh/clear/死亡時の理由文字列など)
# 入れ子でイベントが発火するとこれらは上書きされるので、イベント関数は必要な値を「最初に」読むこと

$scoreboard players set #buff_stacks test.buff.work $(stacks)
$scoreboard players set #buff_at test.buff.work $(at)

# 寿命が尽きて自然に消えた場合だけ終了を通知する(掛け直し・強制解除では出さない)
$execute if data storage test: buff_work.ev{event:"expire",reason:"expire"} run data modify storage test: buff_work.notify set from storage test: asset.buff.types[{id:"$(id)"}]
execute if data storage test: buff_work.ev{event:"expire",reason:"expire"} run function test:buff/notify_expire with storage test: buff_work.notify

$execute unless data storage test: asset.buff.types[{id:"$(id)"}].events.$(event) run return 0
$function test:buff/on/$(event)/$(id)
