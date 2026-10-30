# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/pickaxe/generated/pickaxes
# ツルハシ(スプレッドシートの「ツルハシ」タブ)。asset.pickaxe.<id> = {item, name, rank, speed, blocks}。
# blocks は必要ランクがこのランク以下の鉱脈の鉱石ブロック(生成時に計算)。作るのは test:item/pickaxe/build {id}

data modify storage test: asset.pickaxe.novice_pickaxe set value {item:"wooden_pickaxe",name:"見習いのツルハシ",rank:1,speed:6f,blocks:["minecraft:deepslate_copper_ore"]}
data modify storage test: asset.pickaxe_ids append value "novice_pickaxe"
data modify storage test: asset.pickaxe.miner_pickaxe set value {item:"stone_pickaxe",name:"鉱夫のツルハシ",rank:2,speed:8f,blocks:["minecraft:deepslate_copper_ore","minecraft:deepslate_iron_ore"]}
data modify storage test: asset.pickaxe_ids append value "miner_pickaxe"
