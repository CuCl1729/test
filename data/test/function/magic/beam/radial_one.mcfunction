#> test:magic/beam/radial_one
# @macro yaw: このビームの水平の向き(ほかのキーも渡ってくるが使わない)。水平(pitch 0)に出す
$execute rotated $(yaw) 0 run function test:magic/beam/spawn
