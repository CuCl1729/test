#> test:debug/inspect/show
# @s = 表示する対象。表示先はdebug_viewerタグの付いたプレイヤー(test:debug/inspect/self・nearestが付ける)

tellraw @a[tag=debug_viewer] [{text:"===== ",color:gold},{selector:"@s"},{text:" =====",color:gold}]
tellraw @a[tag=debug_viewer] [{text:"HP ",color:gray},{score:{name:"@s",objective:"test.status.hp"},color:white},{text:"/",color:gray},{score:{name:"@s",objective:"test.status.hp_max"},color:white},{text:"  MP ",color:gray},{score:{name:"@s",objective:"test.status.mp"},color:white},{text:"/",color:gray},{score:{name:"@s",objective:"test.status.mp_max"},color:white}]
tellraw @a[tag=debug_viewer] [{text:"ATK ",color:gray},{score:{name:"@s",objective:"test.status.atk"},color:white},{text:"  DEF ",color:gray},{score:{name:"@s",objective:"test.status.def"},color:white},{text:"  会心率 ",color:gray},{score:{name:"@s",objective:"test.status.crit_rate"},color:white},{text:"/10000  会心ダメージ ",color:gray},{score:{name:"@s",objective:"test.status.crit_damage"},color:white}]
tellraw @a[tag=debug_viewer] [{text:"def.pene ",color:gray},{score:{name:"@s",objective:"test.def.pene"},color:white},{text:"  def.debuff ",color:gray},{score:{name:"@s",objective:"test.def.debuff"},color:white},{text:"  def.coefficient ",color:gray},{score:{name:"@s",objective:"test.def.coefficient"},color:white}]

tellraw @a[tag=debug_viewer] {text:"属性(ダメージ / 耐性 / 貫通 / デバフ / 増加率)",color:gray}
function test:debug/inspect/element {type:"physics",label:"物理"}
function test:debug/inspect/element {type:"fire",label:"火"}
function test:debug/inspect/element {type:"water",label:"水"}
function test:debug/inspect/element {type:"wood",label:"木"}
function test:debug/inspect/element {type:"metal",label:"金"}
function test:debug/inspect/element {type:"earth",label:"土"}

# プレイヤー以外は召喚時の基礎値(バフ前)とdataも出す
execute unless entity @s[type=player] run tellraw @a[tag=debug_viewer] [{text:"基礎値: ATK ",color:gray},{score:{name:"@s",objective:"test.status.base.atk"},color:white},{text:"  DEF ",color:gray},{score:{name:"@s",objective:"test.status.base.def"},color:white},{text:"  HP最大 ",color:gray},{score:{name:"@s",objective:"test.status.base.hp_max"},color:white},{text:"  会心率 ",color:gray},{score:{name:"@s",objective:"test.status.base.crit_rate"},color:white},{text:"  会心ダメージ ",color:gray},{score:{name:"@s",objective:"test.status.base.crit_damage"},color:white}]
execute unless entity @s[type=player] run tellraw @a[tag=debug_viewer] [{text:"data: ",color:gray},{nbt:"data",entity:"@s",color:white}]

# バフはOhMyDatの個別ストレージ(test.buff)にある
function #oh_my_dat:please
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff[0] run tellraw @a[tag=debug_viewer] [{text:"バフ: ",color:gray},{nbt:"_[-4][-4][-4][-4][-4][-4][-4][-4].test.buff",storage:"oh_my_dat:",color:white}]
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff[0] run tellraw @a[tag=debug_viewer] {text:"バフ: なし",color:gray}
