#> test:item/weapon/lore/proc_name
# @macro color: 名前の色。自動発動の枠(lore_work.proc_cur)に入ったものの名前を、作りかけの行に1部品として足す。
# 名前(name)は付与台が置いたアイテムのcustom_nameを写したリストなので、空の部品のextraに入れる

$data modify storage test: lore_work.line append value {text:"",color:"$(color)",extra:[""]}
execute if data storage test: lore_work.proc_cur.name[0] run data modify storage test: lore_work.line[-1].extra set from storage test: lore_work.proc_cur.name
