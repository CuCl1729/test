#> test:debug/machine_status_line
# @s = 機械のマーカー。名前・状態・燃料(data.machine.label。毎秒の確認で更新)・筐体の種類・進み(×100)・処理中のものを出す

scoreboard players add @s test.machine.progress 0
tellraw @a[tag=debug_machine_viewer] [{text:" "},{entity:"@s",nbt:"data.machine.label",interpret:true,color:"gold"},{text:" 筐体:",color:"gray"},{entity:"@s",nbt:"data.machine.casing",interpret:true,color:"aqua"},{text:" 進み:",color:"gray"},{score:{name:"@s",objective:"test.machine.progress"},color:"aqua"},{text:"(100で1秒分)",color:"gray"}]
execute if data entity @s data.machine.processing run tellraw @a[tag=debug_machine_viewer] [{text:"  処理中: ",color:"gray"},{entity:"@s",nbt:"data.machine.processing.components.\"minecraft:custom_name\"",interpret:true}]
