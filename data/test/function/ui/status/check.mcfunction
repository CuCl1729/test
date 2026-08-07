#> test:ui/status/check
# @s = ステータスを確認したいプレイヤー

tellraw @s [{text:"==== ステータス ====",color:gold}]
tellraw @s ["",{text:"Lv.",color:gray},{score:{name:"@s",objective:"test.status.level"},color:aqua},{text:"  EXP:",color:gray},{score:{name:"@s",objective:"test.status.exp"},color:aqua},{text:"  SP:",color:gray},{score:{name:"@s",objective:"test.status.skill_point"},color:aqua}]
tellraw @s ["",{text:"HP: ",color:red},{score:{name:"@s",objective:"test.status.hp"},color:white},{text:"/",color:gray},{score:{name:"@s",objective:"test.status.hp_max"},color:white}]
tellraw @s ["",{text:"MP: ",color:aqua},{score:{name:"@s",objective:"test.status.mp"},color:white},{text:"/",color:gray},{score:{name:"@s",objective:"test.status.mp_max"},color:white}]
tellraw @s ["",{text:"ATK: ",color:gold},{score:{name:"@s",objective:"test.status.atk"},color:white},{text:"  DEF: ",color:gold},{score:{name:"@s",objective:"test.status.def"},color:white}]
tellraw @s ["",{text:"会心率: ",color:light_purple},{score:{name:"@s",objective:"test.status.crit_rate"},color:white},{text:"  会心Dmg: ",color:light_purple},{score:{name:"@s",objective:"test.status.crit_damage"},color:white}]
