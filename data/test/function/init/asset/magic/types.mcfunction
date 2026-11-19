#> test:init/asset/magic/types
# 魔法タイプのレジストリ。UI表示・バリデーション・ディスパッチはすべてこの一覧を走査して行うため、
# コストと数値(params)はスプレッドシートの「魔法の数値」タブから生成して上書きする(init/asset/magic/generated/values)。
# タイプを増やすときはここに1行足し、asset/magic/type/<id>.mcfunction と
# (roleがdeliveryなら)magic/<id>/cast.mcfunction・battle/action/skill_cast/<id>.mcfunction を作れば済む
#
# 「どの組み合わせが成立し、何になるか」はこの一覧ではなく、スプレッドシートの「組み合わせ」タブが持つ
# (init/asset/magic/generated/combos → test:magic/combo/match)。ここに残すのは、組み合わせ表より
# 手前で効く構造の決まり(role の排他・link の after)だけ
#
# id:               タイプ識別子(素材のcustom_data・関数名・ストレージのキーに使う)
# label:            UIに出す表示名
# color:            UIに出す色
# item:             トロッコ式UIのアイコンに使うアイテム
# role:             delivery=届け方(排他。2つ以上選ぶと不正) / modifier=修飾子(deliveryに重ねられる)
# conflicts:        同時に選べないタイプidの一覧(相互に書いておく)
# effect_categories: このタイプと組み合わせられる効果のcategory一覧(効果選択UIの出し分けに使う)
# after:            (role:"link" のみ)つなぎの前に置ける形態の一覧。どれでもなければ段の決まりに反する
# battle:           0b ならターン制の戦闘のタイプ選択に出さない
# projectile_events: 投射体が起こすイベントのうち、このタイプが独自に処理するもの(省略可)
#                    宣言したイベントは test:projectile/on/<event>/<id> が呼ばれる。
#                    イベントは hit_entity(対象に触れた) / hit_block(壁・地面に阻まれた) / expire(射程切れ)
# name:             アイテム名に使う雰囲気名フラグメント(省略可。test:magic/build_nameがそのまま
#                   storage test: magic.loot.name へ丸ごとコピーする形なので、既に整形済みのcompoundにしておく)
# folder:           アセット関数の置き場所(test:asset/magic/<folder>/<id>)。タイプは常に"type"だが、
#                   効果のレジストリと同じ形にしておくことで、要素id→呼び出す関数の解決を
#                   タイプ/効果どちらでも同じ経路(test:magic/crafter/build_effect_entry)で行える

data remove storage test: asset.magic.types

data modify storage test: asset.magic.types append value {id:"self",label:"自己",color:"aqua",item:"glass_bottle",role:"delivery",conflicts:["aoe"],effect_categories:["support"],name:{italic:0b,color:"white",text:"Self"},folder:"type"}
data modify storage test: asset.magic.types append value {id:"projectile",label:"投射",color:"gold",item:"snowball",role:"delivery",conflicts:[],effect_categories:["attack"],name:{italic:0b,text:"Ball"},folder:"type"}
data modify storage test: asset.magic.types append value {id:"aoe",label:"範囲",color:"light_purple",item:"tnt",role:"modifier",conflicts:["self"],effect_categories:["attack","support","modifier"],projectile_events:{hit_entity:1b,hit_block:1b,expire:1b},name:{italic:0b,color:"light_purple",text:"Nova"},folder:"type"}
# 設置と「つなぎ」(role:"link")。battle:0b はターン制の戦闘のタイプ選択に出さない(戦闘の中では置けず、つなげない)。
# つなぎはそれ自体は効果を持たず、前後の段の関係(after = 前の段の形態、何が起きたら次の段を始めるか)を決める。
# 魔法台は組み立て列をつなぎで「段」に区切る(test:magic/crafter/rebuild)
data modify storage test: asset.magic.types append value {id:"place",label:"設置",color:"yellow",item:"lodestone",role:"delivery",conflicts:[],effect_categories:[],battle:0b,name:{italic:0b,color:"yellow",text:"Trap"},folder:"type"}
data modify storage test: asset.magic.types append value {id:"on_land",label:"着弾で",color:"gray",item:"arrow",role:"link",after:["projectile"],conflicts:[],effect_categories:[],battle:0b,projectile_events:{hit_entity:1b,hit_block:1b,expire:1b},folder:"type"}
data modify storage test: asset.magic.types append value {id:"on_recast",label:"再使用で",color:"gray",item:"lever",role:"link",after:["place"],conflicts:[],effect_categories:[],battle:0b,folder:"type"}
data modify storage test: asset.magic.types append value {id:"on_touch",label:"接触で",color:"gray",item:"tripwire_hook",role:"link",after:["place"],conflicts:[],effect_categories:[],battle:0b,folder:"type"}
data modify storage test: asset.magic.types append value {id:"on_timer",label:"時間で",color:"gray",item:"clock",role:"link",after:["place"],conflicts:[],effect_categories:[],battle:0b,folder:"type"}

# 時間をかけて効く要素。初回のリリースはリアルタイム専用なので、3つとも battle:0b でターン制には出さない
# (ターン制に「押し続ける」「毎秒」「次の段を繰り返す」に相当する手番の概念が無いため)
#   継続: 届け方に重ねる修飾子。範囲と組めば場、投射と組めばビーム、自己と組めば自己持続になる
#   追尾: 投射体が敵を狙う修飾子
#   一定間隔: つなぎ。前の段(設置物・飛んでいる弾・自分)が次の段を繰り返し始める
data modify storage test: asset.magic.types append value {id:"continuous",label:"継続",color:"blue",item:"soul_lantern",role:"modifier",conflicts:[],effect_categories:["attack","support","modifier"],battle:0b,name:{italic:0b,color:"blue",text:"Stream"},folder:"type"}
data modify storage test: asset.magic.types append value {id:"homing",label:"追尾",color:"dark_aqua",item:"ender_eye",role:"modifier",conflicts:[],effect_categories:["attack","modifier"],battle:0b,name:{italic:0b,color:"dark_aqua",text:"Seeker"},folder:"type"}
data modify storage test: asset.magic.types append value {id:"periodic",label:"一定間隔",color:"gray",item:"repeater",role:"link",after:["place","projectile","self"],conflicts:[],effect_categories:[],battle:0b,folder:"type"}
