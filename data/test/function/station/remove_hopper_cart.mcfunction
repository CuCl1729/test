#> test:station/remove_hopper_cart
# @s = ステーションの樽の真下にいるホッパー付きトロッコ。真上の樽から中身を吸い出せないよう、トロッコのアイテムを落として消す
# (kill すると、中身はその場に落ちる)

summon item ~ ~ ~ {Item:{id:"minecraft:hopper_minecart",count:1}}
kill @s
