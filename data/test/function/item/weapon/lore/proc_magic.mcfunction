#> test:item/weapon/lore/proc_magic
# 自動発動の枠(lore_work.proc_cur)に入った魔法の名前と消費MPを、作りかけの行(lore_work.line)に足す。
# 名前(name)は魔法アイテムのcustom_nameを写したリストなので、空の部品のextraに入れて1部品にする

function test:item/weapon/lore/proc_name {color:"white"}

data modify storage test: lore_work.line append value {text:" MP",color:"gray"}
data modify storage test: lore_work.n set value 0
data modify storage test: lore_work.n set from storage test: lore_work.proc_cur.magic.cost
function test:item/weapon/lore/num
