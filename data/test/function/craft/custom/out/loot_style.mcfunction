#> test:craft/custom/out/loot_style
# loot.item に、test:loot/give が配るときに足すのと同じ tooltip_display を足す(デバッグで配ったものと重なるように)

data modify storage test: loot.item.components."minecraft:tooltip_display".hidden_components append value "attribute_modifiers"
data modify storage test: loot.item.components."minecraft:tooltip_display".hidden_components append value "weapon"
data modify storage test: loot.item.components."minecraft:tooltip_display".hidden_components append value "dyed_color"
