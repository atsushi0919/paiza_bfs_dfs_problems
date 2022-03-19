# 二部グラフ判定 (paizaランク A 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__bipartite_graph

INPUT1 = <<~"EOS"
  7 6
  1 2
  2 3
  2 4
  3 5
  3 6
  4 7
EOS
OUTPUT1 = <<~"EOS"
  Yes
EOS

INPUT2 = <<~"EOS"
  3 3
  1 2
  2 3
  3 1
EOS
OUTPUT2 = <<~"EOS"
  No
EOS

def solve(input_str)
  # 入力
  input_lines = input_str.split("\n")
  n, m = input_lines.shift.split.map(&:to_i)
  paths = input_lines.map do |line|
    a, b = line.split.map(&:to_i)
    [a - 1, b - 1]
  end

  # 隣接リスト
  adjacency_list = Array.new(n) { [] }
  paths.each do |a, b|
    adjacency_list[a] << b
    adjacency_list[b] << a
  end

  # 探索開始位置
  start = nil
  adjacency_list.each do |path|
    if not path.empty?
      start = path[0]
      break
    end
  end

  # dfs
  # 色: nil, 1, -1
  colors = Array.new(n)
  # リストをスタックとして使う
  stack = [[start, 1]]
  # フラグ
  bipartite_graph = true
  while stack.size > 0 && bipartite_graph
    # 末尾の頂点を取り出す
    cv, color = stack.pop

    # 現在の頂点を探索済みにする
    colors[cv] = color

    # 隣接する頂点を調べる
    adjacency_list[cv].each do |nv|
      # 色が同じなら二部グラフでない
      if color == colors[nv]
        bipartite_graph = false
        break
      end
      # 探索済みならスキップ
      next if not colors[nv].nil?

      # 探索候補に追加
      stack << [nv, -color]
    end
  end
  # 二部グラフの判定結果を返す
  bipartite_graph ? "Yes" : "No"
end

puts solve(STDIN.read)
