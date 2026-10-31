#> test:research/scan/none
# @s = プレイヤー。視線の先も左手も、観測の一覧に無い

data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.scan_target set value ""
title @s actionbar {text:"調べられない",color:"gray"}
