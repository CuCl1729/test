#> test:init/asset/research/
# 研究のレジストリ(スプレッドシートの「観測」「研究」タブから生成)。asset.scan.<id>・asset.scan_ids・asset.scan_{entity,block,item}、
# asset.research.<id>・asset.research_ids、asset.knowledge_types

data modify storage test: asset.scan set value {}
data modify storage test: asset.scan_ids set value []
data modify storage test: asset.research set value {}
data modify storage test: asset.research_ids set value []
function test:init/asset/research/generated/research
