#> test:buff/refresh_icons_entry
# @macro = バフインスタンス1件。レジストリのiconはそのまま連結できるテキストコンポーネントなので、
# 組み立てずにコピーするだけで済む(iconを書いていないバフは表示しない)
# 2スタック以上のときだけ、アイコンの後ろに段数を出す

$execute if data storage test: asset.buff.types[{id:"$(id)"}].icon run data modify storage test: buff_work.icons append from storage test: asset.buff.types[{id:"$(id)"}].icon
$execute if data storage test: asset.buff.types[{id:"$(id)"}].icon unless data storage test: buff_work.icon_entry{stacks:1} run data modify storage test: buff_work.icons append value {text:"$(stacks)",color:"white"}
