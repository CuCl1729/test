#> test:buff/refresh_icons_loop
# buff_work.icon_queue を末尾から取り出して、レジストリのアイコンを buff_work.icons へ並べる

execute unless data storage test: buff_work.icon_queue[-1] run return 0

data modify storage test: buff_work.icon_entry set from storage test: buff_work.icon_queue[-1]
data remove storage test: buff_work.icon_queue[-1]

function test:buff/refresh_icons_entry with storage test: buff_work.icon_entry

function test:buff/refresh_icons_loop
