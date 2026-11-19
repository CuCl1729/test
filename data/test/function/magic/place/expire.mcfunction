#> test:magic/place/expire
# @s = 残る時間が切れた設置物。乗っている持続物(自動ビーム・場)も道連れにするため、
# その場で kill せずに kill タグを付ける(test:tick の最後が passengers ごとまとめて消す)
tag @a remove device_owner
tag @a remove magic_owner
tag @s add kill
