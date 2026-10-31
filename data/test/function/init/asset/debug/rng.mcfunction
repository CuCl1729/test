#> test:init/asset/debug/rng
# test:rng/rollを通る抽選の一覧(デバッグメニューの乱数欄はこれを1行ずつ表示する)。
# 新しく乱数を使うときは、ここにキーを宣言してからtest:rng/roll {key:"<key>",...}で引く
# - range: メニューに出す範囲の説明(実際の範囲は呼び出し側が渡す)
# - fixable: 0bなら結果の固定を出さない(固定すると終わらなくなる引き直しループがある抽選)

data modify storage test: asset.debug.rng set value []
data modify storage test: asset.debug.rng append value {key:"crit",label:"会心判定",range:"1..10000 (値≦会心率で発生)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"enemy_action",label:"敵の行動抽選",range:"1..合計重み (攻撃→防御→ギミックの順)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"buff_chance",label:"バフの確率付与",range:"1..100 (値≦確率で付与)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"wander_yaw",label:"巡回の向き",range:"-180..180",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"wander_interval",label:"巡回の向き替え間隔",range:"40..100 (tick)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"substatus_count",label:"サブステータスの数",range:"レア度3:1..2 / 4:2..3 / 5:3..4",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"substatus_type",label:"サブステータスの種類",range:"武器0..9 / 防具・アクセサリー0..15 (重複は引き直し)",fixable:0b}
data modify storage test: asset.debug.rng append value {key:"substatus_grow",label:"レベルアップで伸びるサブステータス",range:"-4..-1 (末尾から数えた位置)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"aoe_multiplier",label:"範囲攻撃の倍率",range:"50..150 (%)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"equip_drop",label:"装備が落ちるか",range:"1..100 (値≦確率で落ちる)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"material_drop",label:"素材のドロップの個数",range:"敵の定義の最小..最大",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"ore_rarity",label:"原石のレア度",range:"1..鉱脈の重みの合計 (重みを順に足して当たったレア度)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"equip_drop_rare",label:"落ちた装備のレア度",range:"3..4",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"equip_effect",label:"セット効果の発動",range:"1..100 (値≦確率で発動)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"equip_proc_event",label:"自動発動の枠のイベント",range:"0..イベント数-1 (asset.equip.proc_eventsの何番目か)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"refine_main",label:"精錬の主産物",range:"1..重みの合計 (重みを順に足して当たった行)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"refine_by",label:"精錬の副産物",range:"1..100 (値≦確率で出る。行ごと)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"pre_by",label:"前処理の副産物",range:"1..100 (値≦確率で出る。行ごと)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"gather_drop",label:"採取の当たり",range:"1..100 (値≦確率で出る。行ごと)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"gather_count",label:"採取の個数",range:"最小..最大",fixable:1b}

data modify storage test: asset.debug.rng append value {key:"fish_pick",label:"釣れる素材",range:"1..重みの合計 (重みを順に足して当たった行)",fixable:1b}
data modify storage test: asset.debug.rng append value {key:"fish_count",label:"釣れる個数",range:"最小..最大",fixable:1b}