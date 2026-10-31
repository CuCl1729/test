# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/research/generated/research
# 研究(スプレッドシートの「観測」「研究」タブ)。asset.scan.<id> / asset.scan_ids / asset.scan_{entity,block,item}(調べるときの照合用)、
# asset.research.<id> / asset.research_ids、asset.knowledge_types(知識の6属性)。調べるのは test:research/scan/、研究は craft/magic/research/

data modify storage test: asset.knowledge_types set value [{id:"physics",label:"物理"},{id:"fire",label:"火"},{id:"water",label:"水"},{id:"wood",label:"木"},{id:"metal",label:"金"},{id:"earth",label:"土"}]
data modify storage test: asset.scan.goblin set value {id:"goblin",name:"ゴブリン",kind:"enemy",target:"goblin",knowledge:[{el:"earth",label:"土",n:2},{el:"physics",label:"物理",n:2}],gain:"土+2 物理+2"}
data modify storage test: asset.scan_ids append value "goblin"
data modify storage test: asset.scan.cow set value {id:"cow",name:"牛",kind:"entity",target:"cow",knowledge:[{el:"wood",label:"木",n:2}],gain:"木+2"}
data modify storage test: asset.scan_ids append value "cow"
data modify storage test: asset.scan.iron_ore set value {id:"iron_ore",name:"鉄鉱石",kind:"block",target:"iron_ore",knowledge:[{el:"metal",label:"金",n:3}],gain:"金+3"}
data modify storage test: asset.scan_ids append value "iron_ore"
data modify storage test: asset.scan.herb set value {id:"herb",name:"薬草の茂み",kind:"gather",target:"herb",knowledge:[{el:"wood",label:"木",n:3},{el:"water",label:"水",n:1}],gain:"木+3 水+1"}
data modify storage test: asset.scan_ids append value "herb"
data modify storage test: asset.scan.bone set value {id:"bone",name:"骨の欠片",kind:"item",target:"bone",knowledge:[{el:"physics",label:"物理",n:1},{el:"earth",label:"土",n:1}],gain:"物理+1 土+1"}
data modify storage test: asset.scan_ids append value "bone"
data modify storage test: asset.scan_entity set value [{id:"goblin",sel:"tag=goblin"},{id:"herb",sel:"type=minecraft:interaction,tag=gather_point,nbt={data:{gather:{type:\"herb\"}}}"},{id:"cow",sel:"type=minecraft:cow"}]
data modify storage test: asset.scan_block set value [{id:"iron_ore",block:"minecraft:iron_ore"}]
data modify storage test: asset.scan_item set value [{id:"bone",pred:"*[minecraft:custom_data~{test:{material:{kind:\"bone\"}}}]"}]
data modify storage test: asset.research.magic_self set value {id:"magic_self",name:"自己",icon:"glass_bottle",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"self",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_self"
data modify storage test: asset.research.magic_projectile set value {id:"magic_projectile",name:"投射",icon:"snowball",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"projectile",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_projectile"
data modify storage test: asset.research.magic_aoe set value {id:"magic_aoe",name:"範囲",icon:"tnt",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"aoe",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_aoe"
data modify storage test: asset.research.magic_fire set value {id:"magic_fire",name:"火炎",icon:"fire_charge",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"fire",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_fire"
data modify storage test: asset.research.magic_atk set value {id:"magic_atk",name:"威力上昇",icon:"redstone",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"atk",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_atk"
data modify storage test: asset.research.magic_gravity set value {id:"magic_gravity",name:"重力",icon:"feather",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"gravity",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_gravity"
data modify storage test: asset.research.magic_heal set value {id:"magic_heal",name:"回復",icon:"ghast_tear",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"heal",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_heal"
data modify storage test: asset.research.magic_revive set value {id:"magic_revive",name:"蘇生",icon:"totem_of_undying",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"revive",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_revive"
data modify storage test: asset.research.magic_range set value {id:"magic_range",name:"範囲拡大",icon:"ender_pearl",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"range",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_range"
data modify storage test: asset.research.magic_atk_up set value {id:"magic_atk_up",name:"攻撃力上昇",icon:"blaze_rod",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"atk_up",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_atk_up"
data modify storage test: asset.research.magic_poison set value {id:"magic_poison",name:"毒",icon:"spider_eye",cost:1,pre:[],scans:[],knowledge:[],unlock:[{kind:"magic",id:"poison",path:"magic.known"}]}
data modify storage test: asset.research_ids append value "magic_poison"
data modify storage test: asset.research.earth_crop set value {id:"earth_crop",name:"土の作物",icon:"melon_seeds",cost:1,pre:[],scans:["herb"],knowledge:[{el:"wood",label:"木",n:3}],unlock:[{kind:"crop",id:"earth_crop",path:"unlock.crop"}]}
data modify storage test: asset.research_ids append value "earth_crop"
data modify storage test: asset.research.water_crop set value {id:"water_crop",name:"水の作物",icon:"pumpkin_seeds",cost:1,pre:["earth_crop"],scans:[],knowledge:[{el:"water",label:"水",n:1},{el:"wood",label:"木",n:3}],unlock:[{kind:"crop",id:"water_crop",path:"unlock.crop"}]}
data modify storage test: asset.research_ids append value "water_crop"
data modify storage test: asset.research.crusher set value {id:"crusher",name:"粉砕機",icon:"lodestone",cost:1,pre:[],scans:["goblin","iron_ore"],knowledge:[{el:"metal",label:"金",n:3}],unlock:[{kind:"machine",id:"crusher",path:"unlock.machine"}]}
data modify storage test: asset.research_ids append value "crusher"
data modify storage test: asset.research.smelter set value {id:"smelter",name:"精錬炉",icon:"waxed_chiseled_copper",cost:2,pre:["crusher"],scans:["bone"],knowledge:[{el:"metal",label:"金",n:3},{el:"physics",label:"物理",n:3}],unlock:[{kind:"machine",id:"smelter",path:"unlock.machine"}]}
data modify storage test: asset.research_ids append value "smelter"
