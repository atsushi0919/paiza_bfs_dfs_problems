# 木における幅優先探索での探索
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__n_length

INPUT1 = <<~"EOS"
  5 3 2
  1 2
  2 3
  3 4
  4 5
EOS
OUTPUT1 = <<~"EOS"
  1
  5
EOS

INPUT2 = <<~"EOS"
  7 5 2
  7 5
  5 6
  1 5
  1 4
  1 2
  1 3
EOS
OUTPUT2 = <<~"EOS"
  2
  3
  4
EOS

def solve(input_str)
  # 入力
  input_lines = input_str.split("\n")
  n, x, l = input_lines.shift.split.map(&:to_i)
  paths = input_lines.map { |l| l.split.map(&:to_i) }

  # 隣接リスト
  adjacency_list = Hash.new { [] }
  paths.each do |a, b|
    adjacency_list[a] <<= b
    adjacency_list[b] <<= a
  end

  # bfs
  # 探索済みリスト
  searched_list = Array.new(n)

  # 最初の頂点: x, 距離: 0
  queue = [[x, 0]]
  # 処理結果を格納するリスト
  results = []
  while not queue.empty?
    # dequeue
    vertex, dist = queue.shift

    # 距離 l 未満の探索が終わったら終了
    break if dist >= l

    # 現在の頂点を探索済みにする
    searched_list[vertex - 1] = true

    # 隣接する頂点を調べる
    adjacency_list[vertex].each do |next_vertex|
      # 探索済みならスキップ
      next if searched_list[next_vertex - 1]

      # 探索候補に追加
      queue << [next_vertex, dist + 1]

      # 距離 l なら処理結果に追加
      results <<= next_vertex if dist + 1 == l
    end
  end
  # 処理結果を昇順ソートして返す
  results.sort.join("\n")
end

puts solve(STDIN.read)
