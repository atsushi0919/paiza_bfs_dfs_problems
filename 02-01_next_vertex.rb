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

=begin
木の 1 頂点の移動 (paizaランク C 相当)
問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:
https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__next_vertex
問題文のURLをコピーする
 下記の問題をプログラミングしてみよう！
木を構成する 1 〜 N の番号がつけられた頂点とそれらを結ぶ辺の情報と、
頂点番号 X が与えられるので、頂点 X に隣接する頂点の番号を、番号が昇順となるように全て出力してください。

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
・頂点 X に隣接する頂点の番号を、番号が昇順となるように改行区切りで全て出力してください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・1 ≦ N ≦ 100,000
・1 ≦ X ≦ N
・1 ≦ a_i, b_i ≦ N (1 ≦ i ≦ N-1)
・a_i ≠ b_i (1 ≦ i ≦ N-1)

入力例1
5 3
1 2
2 3
3 4
4 5

出力例1
2
4
=end
