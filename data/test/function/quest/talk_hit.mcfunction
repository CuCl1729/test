#> test:quest/talk_hit
# @s = NPC に話しかけたプレイヤー(oh_my_dat は @s を指している)。@macro id/stage/need: 別の NPC と話す段階(会話の前に進む)

$function test:quest/hit {id:"$(id)",stage:$(stage),need:$(need),add:1}
