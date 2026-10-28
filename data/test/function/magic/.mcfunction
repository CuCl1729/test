function #oh_my_dat:please

# 消費MPを払う(足りなければ唱えない)。ターン制でも同じ処理を使う
execute unless function test:magic/pay run return fail

function test:magic/prepare_damage

# 防具のセット効果(magic_cast)。ダメージが決まった後、届け方へ渡す前に詠唱者の属性ダメージをいじれる
function test:equip/event {event:"magic_cast"}

# タイプを増やしてもここを触らずに済むよう、magic/<id>/cast へマクロで委譲する
function test:magic/dispatch with storage test: magic.player
