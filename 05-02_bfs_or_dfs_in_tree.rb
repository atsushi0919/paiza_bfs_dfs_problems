# 1 頂点の移動 (paizaランク B 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__bfs_or_dfs_in_tree

INPUT1 = <<~"EOS"
  6 1 5
  1 2
  1 3
  1 4
  2 5
  3 6
EOS
OUTPUT1 = <<~"EOS"
  dfs
EOS

def get_shortest_path(adjacency_list, x, y, method)
  # 探索済み、未探索リスト
  n = adjacency_list.length
  searched_list = Array.new(n, false)
  unvisited_list = [x]
  search_count = 0
  while unvisited_list.length > 0
    # 最小番号の頂点を取り出す
    cv = if method == "dfs"
        unvisited_list.pop
      else
        unvisited_list.shift
      end

    # 訪問した回数
    search_count += 1

    # 探索済みならスキップ
    next if searched_list[cv - 1]

    # 現在の頂点を探索済みにする
    searched_list[cv - 1] = true

    # 現在の頂点がゴールなら終了
    return search_count if cv == y

    # 隣接する頂点を調べる
    # ソート用に一時保管
    tmp = []
    adjacency_list[cv].each do |nv|
      # 探索済みならスキップ
      next if searched_list[nv - 1]
      # 訪問リストに追加済みならスキップ
      next if unvisited_list.include?(nv)

      # 探索候補に追加
      tmp << nv
    end
    # 同じ層でソートして探索候補に追加
    unvisited_list += if method == "dfs"
        tmp.sort.reverse
      else
        tmp.sort
      end
  end
end

def solve(input_str)
  # 入力
  input_lines = input_str.split("\n")
  n, x, y = input_lines.shift.split.map(&:to_i)
  paths = input_lines.map { |line| line.split.map(&:to_i) }

  # 隣接リスト
  adjacency_list = Hash.new { [] }
  paths.each do |a, b|
    adjacency_list[a] <<= b
    adjacency_list[b] <<= a
  end

  # 訪問回数をカウント
  dfs_count = get_shortest_path(adjacency_list, x, y, "dfs")
  bfs_count = get_shortest_path(adjacency_list, x, y, "bfs")

  # 結果を出力
  if dfs_count < bfs_count
    "dfs"
  elsif dfs_count > bfs_count
    "bfs"
  else
    "same"
  end
end

puts solve(STDIN.read)
