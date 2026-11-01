#> test:talk/party_ready
# 実行位置 = NPC。パーティ(オンラインの全員)が、NPC の16ブロック以内にそろっていれば1を返す(全員のノード)

execute store result score #pa test.temporary if entity @a
execute store result score #pn test.temporary if entity @a[distance=..16]
execute if score #pa test.temporary = #pn test.temporary run return 1
return 0
