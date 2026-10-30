
# hit タグは範囲に入った全部に付ける(乱入用のマーカー battle_entrance を叩いて途中参加する処理なども使うため)
tag @s add hit

# ダメージ自体はスコアボード減算のみでバニラの被弾演出(赤フラッシュ等)が起きないため、
# 命中したことが分かるように演出を出す。演出は、HPを持つものと乱入用のマーカーだけ
# (見えない鉱脈のアマスタやHP表示の文字などで、何もない場所に演出が出ないように)
execute unless entity @s[scores={test.status.hp=1..}] unless entity @s[tag=battle_entrance] run return 0
execute at @s run particle sweep_attack ~ ~1 ~ 0.3 0.3 0.3 0 3 force @a
execute at @s run playsound minecraft:entity.player.attack.sweep master @a ~ ~ ~ 1 1
