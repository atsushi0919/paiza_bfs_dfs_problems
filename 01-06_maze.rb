# 迷路 (paizaランク A 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__maze

INPUT1 = <<~"EOS"
  2 2
  0 0
  1 1
  .#
  #.
EOS
OUTPUT1 = <<~"EOS"
  No
EOS

INPUT2 = <<~"EOS"
  3 3
  0 0
  2 0
  ...
  ##.
  ...
EOS
OUTPUT2 = <<~"EOS"
  6
EOS

def solve(input_str)
  # vx, vy: 方向
  vy = [1, 0, -1, 0]
  vx = [0, 1, 0, -1]

  input_lines = input_str.split("\n")

  # 入力
  h, w = input_lines.shift.split.map(&:to_i)
  sy, sx = input_lines.shift.split.map(&:to_i)
  gy, gx = input_lines.shift.split.map(&:to_i)
  grid = input_lines.map(&:chars)

  # bfs
  step = 0
  goal = false
  queue = [[sy, sx, step]]
  while not queue.empty?
    # cy: 現在のy, cx: 現在のx, cs: 現在の歩数
    cy, cx, cs = queue.shift
    grid[cy][cx] = "*"

    # ゴール判定
    if [cy, cx] == [gy, gx]
      goal = true
      step = cs
      break
    end

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
      queue << [ny, nx, cs + 1]
    end
  end
  # ゴール可能: step(移動数), ゴール不可: No
  goal ? step : "No"
end

puts solve(STDIN.read)
