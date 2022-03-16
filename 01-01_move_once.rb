# 1 マスの移動 (paizaランク C 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__move_once

INPUT1 = <<~"EOS"
  3 3
  1 1
EOS

OUTPUT1 = <<~"EOS"
  .*.
  ***
  .*.
EOS

INPUT2 = <<~"EOS"
  1 1
  0 0
EOS

OUTPUT2 = <<~"EOS"
  *
EOS

def solve(input_str)
  # vx, vy: 方向, step: 歩数
  vy = [1, 0, -1, 0]
  vx = [0, 1, 0, -1]
  step = 1

  # 入力
  h, w, y, x = input_str.split.map(&:to_i)

  # グリッド設定
  grid = Array.new(h) { Array.new(w, ".") }

  # bfs
  queue = [[y, x, step]]
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

      # 移動可能なら次の地点を追加
      queue << [ny, nx, cs - 1]
    end
  end
  # グリッドを返す
  grid.map { |l| l.join }.join("\n")
end

puts solve(STDIN.read)
