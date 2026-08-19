#> test:attack/hit_display_pop
# @s = ダメージを受けた対象。頭上に短命のtext_displayを生成し、ダメージ量を一定時間だけポップアップ表示する
# (HP表示と同じ理由で、共有スコアを直接scoreコンポーネントで参照せず、生成したtext_display自身の
# 専用スコアへ値をコピーしてから@s参照する)

# textは召喚と同じtick内で設定するとクライアントに反映されないことがあるため、値だけここで確定させ、
# 実際のtext設定は次のtick(test:tick)でdamage_pop_text_pendingタグを見て行う。
# 毎tick少しずつtpして浮き上がらせる案は、tpのたびにtextの描画が崩れる(検証済み)ため採用しない。
# 敵本体・HPバー(頭上1.5ブロック)と被らないよう、少し高い位置から静止した状態で出す
execute at @s run summon text_display ~ ~2.5 ~ {Tags:[damage_pop,damage_pop_new,damage_pop_text_pending],billboard:"center",text:{text:""}}

scoreboard players operation @n[tag=damage_pop_new,distance=..3] test.damage_pop.value = #total_damage test.temporary
scoreboard players set @n[tag=damage_pop_new,distance=..3] test.damage_pop.life 20

tag @n[tag=damage_pop_new,distance=..3] remove damage_pop_new
