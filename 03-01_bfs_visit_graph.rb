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

=begin
グラフでの幅優先探索 (paizaランク A 相当)
問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:
https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__bfs_visit_graph
問題文のURLをコピーする
 下記の問題をプログラミングしてみよう！
多重辺・自己ループのない無向グラフを構成する 1 〜 N の番号がつけられた頂点と
それらを結ぶ M 本の辺の情報と頂点番号 X が与えられます。
以下のルールにしたがって番号 X の頂点から幅優先探索をおこなったとき、訪問する頂点を順に出力してください。

・現在の頂点に隣接する全ての未訪問の頂点を、現在キューに入っている全ての頂点を探索下のち、
番号が一番小さい頂点から順に探索する。

▼　下記解答欄にコードを記入してみよう

入力される値
N M X
a_1 b_1
...
a_M b_M


・ 1 行目では、頂点の数 N と辺の本数 M, 頂点番号 X が半角スペース区切りで与えられます。
・ 続く M 行では、M 個の辺の両端の頂点の番号 a_i, b_i (1 ≦ i ≦ M) が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
頂点番号 X から問題文のルールにしたがって幅優先探索をおこなったとき、
訪問する頂点の番号を順に改行区切りで出力してください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・1 ≦ N ≦ 100,000
・1 ≦ M ≦ min(N*(N-1)/2, 100,000)
・1 ≦ X ≦ N
・1 ≦ a_i, b_i ≦ N (1 ≦ i ≦ M)
・a_i ≠ b_i (1 ≦ i ≦ M)

入力例1
7 7 1
1 2
1 3
2 3
2 4
3 5
3 6
4 7

出力例1
1
2
3
4
5
6
7
=end
