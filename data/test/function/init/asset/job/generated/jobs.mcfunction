# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/job/generated/jobs
# 職業の宣言(スプレッドシートの「職業」「職業スキル」タブ)。asset.job.jobs に1職業ずつ足す。
# スキルの効果は job/skill/handler/<kind> が params を受け取る

data modify storage test: asset.job.jobs append value {id:"warrior",label:"戦士",color:"red",requires:[],exp_coefficient:50,growth:[{stat:"atk",per_level:200},{stat:"def",per_level:5}],skills:[{id:"cleave",label:"回し斬り",requires_level:3,requires_nodes:[],cost:1,kind:"damage_cone",params:{angle:60,multiplier:150,mp_cost:10,reach:5}},{id:"iron_wall",label:"鉄壁の構え",requires_level:6,requires_nodes:["cleave"],cost:2,kind:"self_buff",params:{buff_id:"guard",stacks:1}}]}
data modify storage test: asset.job.jobs append value {id:"paladin",label:"聖騎士",color:"gold",requires:[{job:"warrior",level:5}],exp_coefficient:60,growth:[{stat:"def",per_level:8},{stat:"hp_max",per_level:5}],skills:[{id:"smite",label:"聖なる一撃",requires_level:3,requires_nodes:[],cost:1,kind:"damage_cone",params:{angle:40,multiplier:180,mp_cost:15,reach:4}},{id:"blessing",label:"祝福",requires_level:5,requires_nodes:["smite"],cost:2,kind:"self_buff",params:{buff_id:"atk_up",stacks:1}}]}
