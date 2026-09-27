#> test:job/bundle/deliver_item
# @s = 0 -64 1にスポーンしたスキルバンドルのアイテムエンティティ。受け取るプレイヤー
# (tag=skill_bundle_receiver)の位置へ転送し、すぐ拾えるようにする

tp @s @a[tag=skill_bundle_receiver,limit=1]
data modify entity @s PickupDelay set value 0
