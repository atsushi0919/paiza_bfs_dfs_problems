# 木の 2 頂点間の距離 (paizaランク B 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__length_between_two_vertex

INPUT1 = <<~"EOS"
  5 3 2
  1 2
  2 3
  3 4
  4 5
EOS
OUTPUT1 = <<~"EOS"
  1
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
EOS

class PriorityQueue
  def initialize(elements: [], key: 0)
    @data = []
    @key = key
    elements.each { |element| insert(element) }
  end

  def insert(element)
    @data << element
    up_heap
  end

  def extract
    target_element = @data.shift
    if size > 0
      @data.unshift(@data.pop)
      down_heap
    end
    target_element
  end

  def size
    @data.length
  end

  private

  def swap(a, b)
    @data[a], @data[b] = @data[b], @data[a]
  end

  def parent_idx(idx)
    idx / 2 + idx % 2 - 1
  end

  def left_child_idx(idx)
    (idx * 2) + 1
  end

  def right_child_idx(idx)
    (idx * 2) + 2
  end

  def has_child?(idx)
    ((idx * 2) + 1) < size
  end

  def up_heap
    idx = size - 1
    return if idx == 0
    parent_idx = parent_idx(idx)
    while @data[parent_idx][@key] > @data[idx][@key]
      swap(parent_idx, idx)
      return if parent_idx == 0
      idx = parent_idx
      parent_idx = parent_idx(idx)
    end
  end

  def down_heap
    idx = 0
    while (has_child?(idx))
      l_idx = left_child_idx(idx)
      r_idx = right_child_idx(idx)
      if @data[r_idx].nil?
        target_idx = l_idx
      else
        target_idx = @data[l_idx][@key] <= @data[r_idx][@key] ? l_idx : r_idx
      end
      if @data[idx][@key] > @data[target_idx][@key]
        swap(idx, target_idx)
        idx = target_idx
      else
        return
      end
    end
  end
end

def solve(input_str)
  # 入力
  input_lines = input_str.split("\n")
  n, x, y = input_lines.shift.split.map(&:to_i)
  paths = input_lines.map { |l| l.split.map(&:to_i) }

  # 隣接リスト
  adjacency_list = Hash.new { [] }
  paths.each do |a, b|
    adjacency_list[a] <<= b
    adjacency_list[b] <<= a
  end

  # bfs(dijkstra)
  # 探索済みリスト
  searched_list = Array.new(n)

  # 最初の頂点: x, 距離: 0
  pq = PriorityQueue.new(elements: [[x, 0]], key: 1)
  # x-y の最短距離
  shortest_dist = -1
  while pq.size > 0
    # 最短の頂点を取り出す
    vertex, dist = pq.extract

    # 探索済みならスキップ
    next if searched_list[vertex - 1]

    # 現在の頂点を探索済みにする
    searched_list[vertex - 1] = true

    # 最短の頂点が y なら終了
    if vertex == y
      shortest_dist = dist
      break
    end

    # 隣接する頂点を調べる
    adjacency_list[vertex].each do |next_vertex|
      # 探索済みならスキップ
      next if searched_list[next_vertex - 1]

      # 探索候補に追加
      pq.insert([next_vertex, dist + 1])
    end
  end
  # x-y の最短距離を返す
  shortest_dist
end

puts solve(STDIN.read)
