#> test:magic/beam/stop
# @s = プレイヤー。出しているビームを全部止める(離したとき・MPが尽きたとき・唱えられない状態になったとき)。
# 本数ぶん別々に止める意味は無いので、まとめて消す。
# 維持MPの端数(test.magic.mp_frac)はここで捨てない: 捨てると押してすぐ離すのを繰り返して
# 実質無料で撃ててしまうため、次に出したときに持ち越す
scoreboard players set @s test.magic.beam 0
# 請求済みの回数を押していた回数に合わせる。次に出したときに、止めた前後のぶんを
# まとめて請求してしまわないようにするため(端数 mp_frac とは別)
scoreboard players operation @s test.magic.billed = @s test.magic.held
function test:magic/beam/root/stop
