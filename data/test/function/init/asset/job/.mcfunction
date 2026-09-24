#> test:init/asset/job/
# 職業(job)レジストリを組み立て直す(test:init/asset/から呼ばれる)。
# 1職業1ファイル(init/asset/job/<id>.mcfunction、各自asset.job.jobsへappendする)構成。
# 職業データ(成長テーブル+スキルツリー)は剣の各ティア相当に大きくなるため、
# 魔法タイプ/効果のような1ファイル完結ではなくこちらの構成にしてある。
# ファイル間の読み込み順は問わない(前提条件はプレイヤー側のoh_my_datを見て判定するため)

data remove storage test: asset.job.jobs

function test:init/asset/job/warrior
function test:init/asset/job/paladin
