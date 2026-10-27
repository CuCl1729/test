#> test:station/set_title
# @macro name/label: ステーション名と今のモード名。樽のGUIの題名を「name [label]」にする
# (開いている間は変わらない。開き直すと反映される)

$data modify block ~ ~ ~ CustomName set value {text:"$(name) [$(label)]"}
