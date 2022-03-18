# グラフでの幅優先探索 (paizaランク A 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__bfs_visit_graph

INPUT1 = <<~"EOS"
  7 7 1
  1 2
  1 3
  2 3
  2 4
  3 5
  3 6
  4 7
EOS

OUTPUT1 = <<~"EOS"
  1
  2
  3
  4
  5
  6
  7
EOS

def solve(input_str)
  # 入力
  input_lines = input_str.split("\n")
  n, m, x = input_lines.shift.split.map(&:to_i)
  paths = input_lines.map { |l| l.split.map(&:to_i) }

  # 隣接リスト
  adjacency_list = Hash.new { [] }
  paths.each do |a, b|
    adjacency_list[a] <<= b
    adjacency_list[b] <<= a
  end

  # bfs
  # 探索済みの頂点
  searched_list = Array.new(n, false)
  # キュー
  queue = [x]
  # 経路
  visit_list = []
  while queue.size > 0
    # 最小番号の頂点を取り出す
    vertex = queue.shift

    # 探索済みならスキップ
    next if searched_list[vertex - 1]

    # 現在の頂点を探索済みにする
    searched_list[vertex - 1] = true

    # 現在の頂点を訪問済みリストに追加する
    visit_list << vertex

    # 全頂点を訪問したら終了
    break if searched_list.all?

    # 隣接する頂点を調べる
    # ソート用に一時保管
    tmp = []
    adjacency_list[vertex].each do |next_vertex|
      # 探索済みならスキップ
      next if searched_list[next_vertex - 1]
      # 訪問リストに追加済みならスキップ
      next if queue.include?(next_vertex)

      # 探索候補に追加
      tmp << next_vertex
    end
    # 同じ層でソートしてから探索候補に追加
    queue += tmp.sort if not tmp.empty?
  end
  # 訪問リストを返す
  visit_list.join("\n")
end

puts solve(STDIN.read)
