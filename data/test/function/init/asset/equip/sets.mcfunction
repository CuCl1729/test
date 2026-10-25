#> test:init/asset/equip/sets
# 防具のシリーズ(セット効果)。test:equip/recalcが着ている部位数を数え、
#   2部位以上: bonus2 のステータス({type,value})を足す
#   4部位:     bonus4 の特殊効果を有効にする
#
# bonus4 の1件は {event, kind, params, desc}:
#   event:  いつ動くか(magic_cast / attack_hit / damaged。発火場所と文脈はtest:equip/event参照)
#   kind:   何をするか。test:equip/effect/<kind> がparamsをマクロ引数として受け取る
#           (apply_buff {id,stacks,chance} / magic_damage_up {type,percent} / self_buff {buff_id,stacks,chance})
#   desc:   説明文(test:item/weapon/lore/)に出す文
# 新しい効果を作るときは equip/effect/<kind>.mcfunction を1つ書き、ここに1件足せばよい

data modify storage test: asset.equip.sets append value {id:"goblin",label:"ゴブリン",bonus2:[{type:"def_m",value:5.0}],bonus4:[{event:"attack_hit",kind:"apply_buff",params:{id:"poison",stacks:1,chance:20},desc:"攻撃が当たると 20% で 毒 x1 を付与"}]}
data modify storage test: asset.equip.sets append value {id:"mage",label:"見習い魔導士",bonus2:[{type:"magic_efficiency_add",value:5.0}],bonus4:[{event:"magic_cast",kind:"magic_damage_up",params:{type:"projectile",percent:20},desc:"投射タイプの魔法のダメージ +20%"}]}
