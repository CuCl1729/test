#> test:item/weapon/lore/proc_magic
# 自動発動の枠(lore_work.proc_queue[0])に入った魔法の名前と消費MPを、作りかけの行(lore_work.line)に足す。
# 名前(name)は魔法アイテムのcustom_nameを写したリストなので、空の部品のextraに入れて1部品にする

data modify storage test: lore_work.line append value {text:"",color:"white",extra:[""]}
execute if data storage test: lore_work.proc_queue[0].name[0] run data modify storage test: lore_work.line[-1].extra set from storage test: lore_work.proc_queue[0].name

data modify storage test: lore_work.line append value {text:"  消費MP ",color:"gray"}
data modify storage test: lore_work.n set from storage test: lore_work.proc_queue[0].magic.cost
function test:item/weapon/lore/num
