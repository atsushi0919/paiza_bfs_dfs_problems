# 壁のあるグリッドでの n マスの移動 (paizaランク A 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__move_obstacle

INPUT1 = <<~"EOS"
  7 10 9
  5 2
  #...#.....
  .###...#.#
  #..#....##
  .#.###..##
  ##.....###
  ##.##....#
  #..#.##..#
EOS
OUTPUT1 = <<~"EOS"
    #...#.*...
    .###.**#.#
    #**#****##
    .#*###**##
    ##*****###
    ##*##****#
  #**#.##**#
EOS

INPUT2 = <<~"EOS"
  9 6 8
  5 0
  ....##
  .#.##.
  #...##
  #.####
  #.##.#
  .###.#
  ..####
  #...##
  #.###.
EOS
OUTPUT2 = <<~"EOS"
  ....##
  .#.##.
  #...##
  #.####
  #.##.#
  *###.#
  **####
  #***##
  #*###.
EOS

def solve(input_str)
  # vx, vy: 方向
  vy = [1, 0, -1, 0]
  vx = [0, 1, 0, -1]

  input_lines = input_str.split("\n")

  # 入力
  h, w, n = input_lines.shift.split.map(&:to_i)
  y, x = input_lines.shift.split.map(&:to_i)
  grid = input_lines.map(&:chars)

  # bfs
  queue = [[y, x, n]]
  while not queue.empty?
    # cy: 現在のy, cx: 現在のx, cs: 現在の歩数
    cy, cx, cs = queue.shift
    grid[cy][cx] = "*"
    next if cs == 0

    #️ 現在地の隣接4マスを調べる
    vy.zip(vx).each do |dy, dx|
      # ny: 次のy, nx: 次のx
      ny = cy + dy
      nx = cx + dx

      # 有効範囲外なら追加しない
      next if ny < 0 || ny > h - 1
      next if nx < 0 || nx > w - 1
      # 移動先が障害物なら追加しない
      next if grid[ny][nx] == "#"
      # 調査済みなら追加しない
      next if grid[ny][nx] == "*"

      # 移動可能なら次の地点を追加
      queue << [ny, nx, cs - 1]
    end
  end
  # グリッドを返す
  grid.map { |l| l.join }.join("\n")
end

puts solve(STDIN.read)
