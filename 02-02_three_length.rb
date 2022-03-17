# 木の距離 3 の頂点 (paizaランク B 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__three_length

INPUT1 = <<~"EOS"
  5 1
  1 2
  2 3
  3 4
  4 5
EOS
OUTPUT1 = <<~"EOS"
  4
EOS

INPUT2 = <<~"EOS"
  7 7
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
  # 目標距離
  target = 3

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

    # 目標距離未満の探索が終わったら終了
    break if dist >= target

    # 現在の頂点を探索済みにする
    searched_list[vertex - 1] = true

    # 隣接する頂点を調べる
    adjacency_list[vertex].each do |next_vertex|
      # 探索済みならスキップ
      next if searched_list[next_vertex - 1]

      # 探索候補に追加
      queue << [next_vertex, dist + 1]

      # 目標距離なら処理結果に追加
      results <<= next_vertex if dist + 1 == target
    end
  end
  # 処理結果を昇順ソートして返す
  results.sort.join("\n")
end

puts solve(STDIN.read)

=begin
木の距離 3 の頂点 (paizaランク B 相当)
問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:
https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__three_length
問題文のURLをコピーする
 下記の問題をプログラミングしてみよう！
木を構成する 1 〜 N の番号がつけられた頂点とそれらを結ぶ辺の情報と頂点番号 X が与えられるので、
頂点 X からの距離が 3 である頂点の番号を全て出力してください。
なお、木の 2 頂点 X, Y 間の距離とは、頂点 X から頂点 Y までを最短経路で移動したときに通る辺の数のことを指します。

--- ヒント ---
頂点 X から実際に 3 回移動するシミュレーションをしても良いですが、このような問題についても幅優先探索が利用できます。
グリッドにおける幅優先探索において、「3 マス移動することで新たに行けるようになるマス」を
「2 マス移動することで新たに到達できるようになったマス」から
新たな移動を行うことで求めた手法を木でも同様に用いてみましょう。

具体的には「頂点 X からの距離が 3 である頂点」を「『頂点 X からの距離が 2 である頂点』に隣接している頂点のうち、
未訪問の頂点」であると考えてみましょう。

▼　下記解答欄にコードを記入してみよう

入力される値
N X
a_1 b_1
...
a_{N-1} b_{N-1}


・ 1 行目では、頂点の数 N と、頂点番号 X が半角スペース区切りで与えられます。
・ 続く N-1 行では、N-1 個の辺の両端の頂点の番号 a_i, b_i (1 ≦ i ≦ N-1) が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
・頂点 X からの距離が 3 である頂点の番号を、番号が昇順となるように改行区切りで全て出力してください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・1 ≦ N ≦ 100,000
・1 ≦ X ≦ N
・1 ≦ a_i, b_i ≦ N (1 ≦ i ≦ N-1)
・a_i ≠ b_i (1 ≦ i ≦ N-1)

入力例1
5 1
1 2
2 3
3 4
4 5

出力例1
4

入力例2
7 7
7 5
5 6
1 5
1 4
1 2
1 3

出力例2
2
3
4
=end
