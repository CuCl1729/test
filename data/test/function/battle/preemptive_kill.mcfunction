#> test:battle/preemptive_kill
# @s = 先制攻撃で敵を撃破したプレイヤー。アリーナのセットアップを行わず、その場で勝利扱いにする
# (報酬は、ほかの戦闘外の撃破と同じく test:reward/field_kill が近くのプレイヤー全員へ渡す)

tellraw @a[distance=..32] ["",{text:"先制攻撃で撃破した！",color:green}]
