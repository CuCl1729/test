#> test:init/asset/enemy/
# 敵のレジストリ。asset.enemy.<id> = {name?, stats:{hp,mp,atk,def,coef,crit_rate,crit_damage,exp}, resist:{physics,fire,…}, data}
#   stats は内部の値(×100済み。exp と resist はそのまま)
#   data は召喚した敵の data タグにそのまま写る(loot_table / buff_on_hit / equip_drops / ai_field_enabled / ai)
# 出すのは test:asset/enemy/spawn {id}(test:asset/enemy/load が #enemy と storage test: enemy を作り、asset/enemy/summon が召喚する)

data modify storage test: asset.enemy set value {}
data modify storage test: asset.enemy_ids set value []

# 各敵の宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1。生成先はgenerated/)
function test:init/asset/enemy/generated/enemies
