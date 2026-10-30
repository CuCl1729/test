#> test:debug/machine_status_line
# @s = 機械のマーカー。名前と状態(data.machine.label。毎秒の確認で更新)・燃料の残り・進み具合・処理中のものを出す

scoreboard players add @s test.machine.fuel 0
scoreboard players add @s test.machine.progress 0
tellraw @a[tag=debug_machine_viewer] [{text:" "},{entity:"@s",nbt:"data.machine.label",color:"gold"},{text:" 燃料:",color:"gray"},{score:{name:"@s",objective:"test.machine.fuel"},color:"aqua"},{text:"回 進み:",color:"gray"},{score:{name:"@s",objective:"test.machine.progress"},color:"aqua"},{text:"秒",color:"gray"}]
execute if data entity @s data.machine.processing run tellraw @a[tag=debug_machine_viewer] [{text:"  処理中: ",color:"gray"},{entity:"@s",nbt:"data.machine.processing.components.\"minecraft:custom_name\"",interpret:true}]
