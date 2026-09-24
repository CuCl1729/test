#> test:init/asset/job/paladin
# 職業「聖騎士」。前提職業: 戦士レベル5以上。成長は防御寄り+HP。
# 以下はシステム実演用の仮の数値で、バランスは今後の調整対象

data modify storage test: asset.job.jobs append value {id:"paladin",label:"聖騎士",color:"gold",requires:[{job:"warrior",level:5}],exp_coefficient:60,growth:[{stat:"def",per_level:8},{stat:"hp_max",per_level:5}],skills:[{id:"smite",label:"聖なる一撃",requires_level:3,requires_nodes:[],cost:1,kind:"damage_cone",params:{angle:40,multiplier:180,mp_cost:15,reach:4}},{id:"blessing",label:"祝福",requires_level:5,requires_nodes:["smite"],cost:2,kind:"self_buff",params:{buff_id:"atk_up",stacks:1}}]}
