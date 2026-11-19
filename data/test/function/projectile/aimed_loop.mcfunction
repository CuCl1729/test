#> test:projectile/aimed_loop
# 本数ぶん、同じ位置・同じ向きで1本ずつ出す
function test:projectile/summon with storage test:
scoreboard players add #aimed_index test.temporary 1
execute if score #aimed_index test.temporary < #aimed_count test.temporary run function test:projectile/aimed_loop
