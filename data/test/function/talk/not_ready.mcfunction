#> test:talk/not_ready
# @s = プレイヤー。全員のノードに進もうとしたが、パーティがそろっていない。会話を止める

tellraw @s {text:"全員がそろってから",color:"gray"}
function test:talk/end
