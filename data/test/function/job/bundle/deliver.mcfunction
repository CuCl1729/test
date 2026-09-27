#> test:job/bundle/deliver
# @s = 対象プレイヤー。0 -64 0(オーバーワールド)で組み立て済みのスキルバンドルを渡す。
# スロットへ直接差し替えると中身の表示が崩れるため、古いバンドルを消してから
# アイテムとしてスポーンさせ、プレイヤーの位置へ転送して拾わせる(test:loot/giveと同じ方式)

clear @s *[custom_data~{test:{skill_bundle:1b}}]

tag @s add skill_bundle_receiver
execute in minecraft:overworld run loot spawn 0 -64 1 mine 0 -64 0 debug_stick
execute in minecraft:overworld positioned 0 -64 1 as @e[type=item,distance=..2,nbt={Item:{components:{"minecraft:custom_data":{test:{skill_bundle:1b}}}}}] run function test:job/bundle/deliver_item
tag @s remove skill_bundle_receiver
