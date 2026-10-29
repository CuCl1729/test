# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/enemy/generated/enemies
# 敵の宣言(スプレッドシートの「敵」「敵のギミック」タブ)。asset.enemy.<id> = {name?, stats, resist, data}。
# stats は内部の値(×100済み)。出すのは test:asset/enemy/spawn {id}(test:asset/enemy/load が #enemy と storage test: enemy を作る)

data modify storage test: asset.enemy.dummy set value {stats:{hp:100000,mp:0,atk:100,def:1000,coef:1000,crit_rate:0,crit_damage:0,exp:0},resist:{physics:20,fire:20,water:20,wood:20,metal:20,earth:20},data:{loot_table:"test:enemy/dummy",attack_element:"physics",buff_on_hit:[{id:"poison",stacks:1,chance:50}]}}
data modify storage test: asset.enemy_ids append value "dummy"
data modify storage test: asset.enemy.goblin set value {name:{text:"ゴブリン",color:"dark_green"},stats:{hp:10000,mp:0,atk:100,def:1000,coef:1000,crit_rate:0,crit_damage:0,exp:0},resist:{physics:20,fire:20,water:20,wood:20,metal:20,earth:20},data:{loot_table:"test:enemy/goblin",attack_element:"physics",buff_on_hit:[{id:"poison",stacks:1,chance:50}],equip_drops:[{id:"goblin_helmet",chance:5},{id:"goblin_chestplate",chance:5},{id:"goblin_leggings",chance:5},{id:"goblin_boots",chance:5}],ai_field_enabled:1b,ai:{gimmicks:[{id:"enrage",weight:40,hp_below:30,cooldown:2,params:{buff:"atk_up",stacks:2}},{id:"heal",weight:20,hp_below:40,cooldown:3,params:{percent:20}}]}}}
data modify storage test: asset.enemy_ids append value "goblin"
