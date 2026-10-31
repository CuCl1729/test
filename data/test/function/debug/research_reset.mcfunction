#> test:debug/research_reset
# @s = プレイヤー。自分の研究・知識・調べ済み(test.research)と、研究で解放したもの(test.unlock)を消す(試し直し用)。
# 魔法要素の習得(test.magic.known)は消さない(研究のGUIを開くと、それを解放する研究はまた済になる)

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.unlock
tellraw @s {text:"研究・知識・調べ済みを消した",color:"gray"}
