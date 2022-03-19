# 連結成分の個数 (paizaランク A 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__number_of_connected_components

INPUT1 = <<~"EOS"
  5 3
  1 2
  2 3
  4 5
EOS
OUTPUT1 = <<~"EOS"
  2
EOS

INPUT2 = <<~"EOS"
  3 1
  1 2
EOS
OUTPUT2 = <<~"EOS"
  2
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

  # 連結成分数
  num_of_group = 0
  # 探索済みリストを全探索
  searched_list = Array.new(n, false)
  0.upto(n - 1) do |idx|
    # 探索済みならスキップ
    next if searched_list[idx]

    # 連結成分数をカウントアップ
    num_of_group += 1
    # dfs 探索開始
    stack = [idx]
    while not stack.empty?
      # 末尾の頂点を取り出す
      cv = stack.pop

      # 現在の頂点を探索済みにする
      searched_list[cv] = true

      # 隣接する頂点を調べる
      adjacency_list[cv].each do |nv|
        # 探索済みならスキップ
        next if searched_list[nv]

        # 探索候補に追加
        stack << nv
      end
    end
  end
  # 連結成分数を返す
  num_of_group
end

puts solve(STDIN.read)
