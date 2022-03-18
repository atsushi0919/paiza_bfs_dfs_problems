# グリッドの深さ優先探索（3 マス） (paizaランク A 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__grid_dfs_three_times

INPUT1 = <<~"EOS"
  7 7 3 3
EOS

OUTPUT1 = <<~"EOS"
  0 3
  1 4
  2 3
  1 2
  1 4
  2 5
  3 4
  2 3
  2 3
  3 4
  4 3
  3 2
  1 2
  2 3
  3 2
  2 1
  1 4
  2 5
  3 4
  2 3
  2 5
  3 6
  4 5
  3 4
  3 4
  4 5
  5 4
  4 3
  2 3
  3 4
  4 3
  3 2
  2 3
  3 4
  4 3
  3 2
  3 4
  4 5
  5 4
  4 3
  4 3
  5 4
  6 3
  5 2
  3 2
  4 3
  5 2
  4 1
  1 2
  2 3
  3 2
  2 1
  2 3
  3 4
  4 3
  3 2
  3 2
  4 3
  5 2
  4 1
  2 1
  3 2
  4 1
  3 0
EOS

INPUT2 = <<~"EOS"
  2 2 0 0
EOS

OUTPUT2 = <<~"EOS"
  0 1
  1 0
  0 1
  1 0
  0 1
  1 0
  0 1
  1 0
EOS

def solve(input_str)
  # 方向設定（上、右、下、左）
  vy = [0, 1, 0, -1]
  vx = [-1, 0, 1, 0]
  # 何マス移動できるか
  step = 3

  # 入力
  h, w, y, x = input_str.split.map(&:to_i)

  # リストをスタックとして使う
  stack = [[y, x, 0]]
  # 処理結果を格納
  results = []
  while not stack.empty?
    # 探索候補末尾の要素を取り出す
    cy, cx, cs = stack.pop

    # step 進んだら現在地を処理結果に追加
    results <<= [cy, cx] if cs == step

    # 隣接マスを調べる
    vy.zip(vx).each do |dy, dx|
      # 隣接マスの座標
      ny = cy + dy
      nx = cx + dx

      # 範囲外ならスキップ
      next if ny < 0 || ny > h - 1
      next if nx < 0 || nx > w - 1
      # step を超えたら追加しない
      next if cs > step

      # 探索候補に追加する
      stack << [ny, nx, cs + 1]
    end
  end
  # 処理結果を指定の表示に整えて返す
  results.map { |yx| yx.join(" ") }.join("\n") << "\n"
end

puts solve(STDIN.read)
