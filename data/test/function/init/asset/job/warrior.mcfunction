#> test:init/asset/job/warrior
# 職業「戦士」。前提職業なし(誰でも解放できる初期職業)。
# growthの数値スケールはステータスごとに違う(atkは内部100倍値、defは生値)ので、
# per_levelはそのステータスの実スコアに直接足す値として書くこと(test.buff.<stat>と同じ責務)。
# 以下はシステム実演用の仮の数値で、バランスは今後の調整対象

data modify storage test: asset.job.jobs append value {id:"warrior",label:"戦士",color:"red",requires:[],exp_coefficient:50,growth:[{stat:"atk",per_level:200},{stat:"def",per_level:5}],skills:[{id:"cleave",label:"回し斬り",requires_level:3,requires_nodes:[],cost:1,kind:"damage_cone",params:{angle:60,multiplier:150,mp_cost:10,reach:5}},{id:"iron_wall",label:"鉄壁の構え",requires_level:6,requires_nodes:["cleave"],cost:2,kind:"self_buff",params:{buff_id:"guard",stacks:1}}]}
