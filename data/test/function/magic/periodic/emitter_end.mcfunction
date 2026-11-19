#> test:magic/periodic/emitter_end
# @s = 持ち主が使えない状態になった発生源。消える
# (乗っている持続物も test:tick の最後が passengers ごと道連れにする)
tag @a remove magic_owner
tag @s add kill
