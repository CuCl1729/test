#> test:magic/beam/wall_end
# 実行位置 = 線が入った壁のブロック(まだ一歩戻っていない)。align xyz で整数のブロック座標に揃えた
# 捨てマーカーを出し、link_work.wall にその座標を控えてから、いつも通り一歩戻った所で ray_end を呼ぶ
execute align xyz summon marker run function test:magic/beam/link/wall_pos
execute positioned ^ ^ ^-0.5 run function test:magic/beam/ray_end
