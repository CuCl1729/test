#> test:magic/dispatch
# @macro magic_type: 発動する魔法のデリバリタイプid
# タイプを増やしてもここを触らずに済むよう、magic/<id>/cast へマクロで委譲する

$function test:magic/$(magic_type)/cast
