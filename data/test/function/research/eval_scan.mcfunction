#> test:research/eval_scan
# @macro id: 観測のid。名前を出すため、その観測の定義(id/name)で eval_scan_line を呼ぶ

$function test:research/eval_scan_line with storage test: asset.scan.$(id)
