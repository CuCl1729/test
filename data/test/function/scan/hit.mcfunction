
tag @s add hit

# ダメージ自体はスコアボード減算のみでバニラの被弾演出(赤フラッシュ等)が起きないため、
# 命中したことが分かるように演出を出す
execute at @s run particle sweep_attack ~ ~1 ~ 0.3 0.3 0.3 0 3 force @a
execute at @s run playsound minecraft:entity.player.attack.sweep master @a ~ ~ ~ 1 1
