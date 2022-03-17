# 木の 1 頂点の移動 (paizaランク C 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__next_vertex

INPUT1 = <<~"EOS"
  5 3
  1 2
  2 3
  3 4
  4 5
EOS

OUTPUT1 = <<~"EOS"
  2
  4
EOS

def solve(input_str)
  # 入力
  input_lines = input_str.split("\n")
  n, x = input_lines.shift.split.map(&:to_i)
  paths = input_lines.map { |l| l.split.map(&:to_i) }

  # 隣接リスト
  adjacency_list = Hash.new { [] }
  paths.each do |a, b|
    adjacency_list[a] <<= b
    adjacency_list[b] <<= a
  end

  # x に隣接する頂点を昇順で返す
  adjacency_list[x].sort.join("\n")
end

puts solve(STDIN.read)
