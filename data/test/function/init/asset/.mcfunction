# 定数(手番の制限時間・アクセサリーの数など)はスプレッドシートから生成している(tools/datasheet/generate.ps1)
function test:init/asset/generated/config

# 武器の宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1)
function test:init/asset/generated/weapons

# 魔法の要素の一覧は手書き、コストと威力などの数値はスプレッドシートから生成して上書きする
function test:init/asset/magic/types
function test:init/asset/magic/effects
function test:init/asset/magic/generated/values

# バフの一覧は手書き、時間・段数・効果量はスプレッドシートから生成して上書きする
function test:init/asset/buff/buffs
function test:init/asset/buff/generated/values

function test:init/asset/job/

function test:init/asset/equip/

function test:init/asset/rune/

function test:init/asset/consumable/

function test:init/asset/material/

function test:init/asset/enemy/

# 採掘(原石・鉱山・ツルハシ)
function test:init/asset/ore/
function test:init/asset/mine/
function test:init/asset/pickaxe/

# 機械(原石を加工するマルチブロック)。形は手書き
function test:init/asset/machine
function test:init/asset/refine/

# 採取(採取ポイント・採取の道具)
function test:init/asset/gather/
function test:init/asset/fish/

# 農耕(普通の作物のドロップ・魔法作物)
function test:init/asset/crop/
function test:init/asset/research/

function test:init/asset/station

function test:init/asset/debug/rng
