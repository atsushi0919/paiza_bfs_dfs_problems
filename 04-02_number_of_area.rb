# 領域の個数 (paizaランク A 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__number_of_area

INPUT1 = <<~"EOS"
  5 5
  ###..
  ..#.#
  #####
  ...##
  .###.
EOS
OUTPUT1 = <<~"EOS"
  4
EOS

INPUT2 = <<~"EOS"
  3 3
  .#.
  #..
  ...
EOS
OUTPUT2 = <<~"EOS"
  2
EOS

def solve(input_str)
  # 方向設定
  vy = [0, 1, 0, -1]
  vx = [-1, 0, 1, 0]

  # 入力
  input_lines = input_str.split("\n")
  h, w = input_lines.shift.split.map(&:to_i)
  grid_map = input_lines.map(&:chars)

  # 領域の数
  num_of_area = 0

  # スタート地点を全探索する
  0.upto(h - 1) do |y|
    0.upto(w - 1) do |x|
      # "." 以外ならスキップ
      next if grid_map[y][x] != "."

      # 領域をカウントアップ
      num_of_area += 1

      # dfs
      # リストをスタックとして使う
      stack = [[y, x]]
      while not stack.empty?
        # 探索候補末尾の要素を取り出す
        cy, cx = stack.pop

        # 探索済みの印を "*" とする
        grid_map[cy][cx] = "*"

        # 隣接マスを調べる
        vy.zip(vx).each do |dy, dx|
          # 隣接マスの座標
          ny = cy + dy
          nx = cx + dx

          # 範囲外ならスキップ
          next if ny < 0 || ny > h - 1
          next if nx < 0 || nx > w - 1
          # "." 以外なら追加しない
          next if grid_map[ny][nx] != "."

          # 探索候補に追加する
          stack << [ny, nx]
        end
      end
    end
  end
  # 領域の数を返す
  num_of_area
end

puts solve(STDIN.read)
