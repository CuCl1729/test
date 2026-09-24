#> test:job/skill/bundle_resolve
# @macro kind/owner_uuid(+job/node): 取り出された印アイテムのcustom_data.test
# (job_work.consume_entryとして展開済み)。埋め込まれたUUIDでオーナーを特定し、その場で実行させる

$execute as @a[nbt={UUID:$(owner_uuid)}] at @s run function test:job/skill/bundle_resolve_as_owner with storage test: job_work.consume_entry
