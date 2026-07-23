say pre impulse x

scoreboard players operation #motion test.temporary = #motion test.X1

scoreboard players set #-1 test.X0 0
scoreboard players set #1 test.X0 0
scoreboard players set #2 test.X0 0
scoreboard players set #4 test.X0 0
scoreboard players set #8 test.X0 0
scoreboard players set #16 test.X0 0
scoreboard players set #32 test.X0 0
scoreboard players set #64 test.X0 0
scoreboard players set #128 test.X0 0
scoreboard players set #256 test.X0 0
scoreboard players set #512 test.X0 0
scoreboard players set #1024 test.X0 0
scoreboard players set #2048 test.X0 0
scoreboard players set #4096 test.X0 0
scoreboard players set #8192 test.X0 0
scoreboard players set #16384 test.X0 0
scoreboard players set #32768 test.X0 0
scoreboard players set #65536 test.X0 0

execute if score #motion test.temporary matches ..-1 run scoreboard players set #-1 test.X0 1
execute if score #motion test.temporary matches ..-1 run scoreboard players operation #motion test.temporary *= #-1 test.constant

execute if score #motion test.temporary matches 65536.. run scoreboard players set #65536 test.X0 1
execute if score #motion test.temporary matches 65536.. run scoreboard players operation #motion test.temporary -= #65536 test.constant

execute if score #motion test.temporary matches 32768.. run scoreboard players set #32768 test.X0 1
execute if score #motion test.temporary matches 32768.. run scoreboard players operation #motion test.temporary -= #32768 test.constant

execute if score #motion test.temporary matches 16384.. run scoreboard players set #16384 test.X0 1
execute if score #motion test.temporary matches 16384.. run scoreboard players operation #motion test.temporary -= #16384 test.constant

execute if score #motion test.temporary matches 8192.. run scoreboard players set #8192 test.X0 1
execute if score #motion test.temporary matches 8192.. run scoreboard players operation #motion test.temporary -= #8192 test.constant

execute if score #motion test.temporary matches 4096.. run scoreboard players set #4096 test.X0 1
execute if score #motion test.temporary matches 4096.. run scoreboard players operation #motion test.temporary -= #4096 test.constant

execute if score #motion test.temporary matches 2048.. run scoreboard players set #2048 test.X0 1
execute if score #motion test.temporary matches 2048.. run scoreboard players operation #motion test.temporary -= #2048 test.constant

execute if score #motion test.temporary matches 1024.. run scoreboard players set #1024 test.X0 1
execute if score #motion test.temporary matches 1024.. run scoreboard players operation #motion test.temporary -= #1024 test.constant

execute if score #motion test.temporary matches 512.. run scoreboard players set #512 test.X0 1
execute if score #motion test.temporary matches 512.. run scoreboard players operation #motion test.temporary -= #512 test.constant

execute if score #motion test.temporary matches 256.. run scoreboard players set #256 test.X0 1
execute if score #motion test.temporary matches 256.. run scoreboard players operation #motion test.temporary -= #256 test.constant

execute if score #motion test.temporary matches 128.. run scoreboard players set #128 test.X0 1
execute if score #motion test.temporary matches 128.. run scoreboard players operation #motion test.temporary -= #128 test.constant

execute if score #motion test.temporary matches 64.. run scoreboard players set #64 test.X0 1
execute if score #motion test.temporary matches 64.. run scoreboard players operation #motion test.temporary -= #64 test.constant

execute if score #motion test.temporary matches 32.. run scoreboard players set #32 test.X0 1
execute if score #motion test.temporary matches 32.. run scoreboard players operation #motion test.temporary -= #32 test.constant

execute if score #motion test.temporary matches 16.. run scoreboard players set #16 test.X0 1
execute if score #motion test.temporary matches 16.. run scoreboard players operation #motion test.temporary -= #16 test.constant

execute if score #motion test.temporary matches 8.. run scoreboard players set #8 test.X0 1
execute if score #motion test.temporary matches 8.. run scoreboard players operation #motion test.temporary -= #8 test.constant

execute if score #motion test.temporary matches 4.. run scoreboard players set #4 test.X0 1
execute if score #motion test.temporary matches 4.. run scoreboard players operation #motion test.temporary -= #4 test.constant

execute if score #motion test.temporary matches 2.. run scoreboard players set #2 test.X0 1
execute if score #motion test.temporary matches 2.. run scoreboard players operation #motion test.temporary -= #2 test.constant

execute if score #motion test.temporary matches 1.. run scoreboard players set #1 test.X0 1
execute if score #motion test.temporary matches 1.. run scoreboard players operation #motion test.temporary -= #1 test.constant

