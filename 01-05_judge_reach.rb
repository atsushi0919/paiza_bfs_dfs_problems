# ゴール判定 (paizaランク A 相当)
# https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__judge_reach

INPUT1 = <<~"EOS"
  2 2
  0 0
  1 1
  .#
  #.
EOS

OUTPUT1 = <<~"EOS"
  No
EOS

INPUT2 = <<~"EOS"
  3 3
  0 0
  2 0
  ...
  ##.
  ...
EOS

OUTPUT2 = <<~"EOS"
  Yes
EOS

def solve(input_str)
  # vx, vy: 方向
  vy = [1, 0, -1, 0]
  vx = [0, 1, 0, -1]

  input_lines = input_str.split("\n")

  # 入力
  h, w = input_lines.shift.split.map(&:to_i)
  sy, sx = input_lines.shift.split.map(&:to_i)
  gy, gx = input_lines.shift.split.map(&:to_i)
  grid = input_lines.map(&:chars)

  # bfs
  goal = false
  queue = [[sy, sx]]
  while not queue.empty?
    # cy: 現在のy, cx: 現在のx, cs: 現在の歩数
    cy, cx = queue.shift
    grid[cy][cx] = "*"

    # ゴール判定
    if [cy, cx] == [gy, gx]
      goal = true
      break
    end

    #️ 現在地の隣接4マスを調べる
    vy.zip(vx).each do |dy, dx|
      # ny: 次のy, nx: 次のx
      ny = cy + dy
      nx = cx + dx

      # 有効範囲外なら追加しない
      next if ny < 0 || ny > h - 1
      next if nx < 0 || nx > w - 1
      # 移動先が障害物なら追加しない
      next if grid[ny][nx] == "#"
      # 調査済みなら追加しない
      next if grid[ny][nx] == "*"

      # 移動可能なら次の地点を追加
      queue << [ny, nx]
    end
  end
  # ゴール可能: Yes, ゴール不可: No
  goal ? "Yes" : "No"
end

puts solve(STDIN.read)

=begin
ゴール判定 (paizaランク A 相当)
問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:
https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__judge_reach
問題文のURLをコピーする
 下記の問題をプログラミングしてみよう！
グリッドとスタート地点のマス (sy,sx), ゴール地点のマス (gy,gx) が与えられるので、スタート地点から次の操作を繰り返し、ゴール地点に到達することができるかを判定してください。

・現在いるマスを (y,x) としたとき、(y+1,x), (y-1,x), (y,x+1), (y,x-1) のいずれかのマスに移動する。

ただし、グリッドの外へは移動することができず、また、グリッド上の '#' のマスは壁であり、移動できないことに注意してください。
なお、グリッドの左上・右上・左下・右下のマスをそれぞれ (0,0), (0,W-1), (H-1,0), (H-1,W-1) とします。

▼　下記解答欄にコードを記入してみよう

入力される値
H W
sy sx
gy gx
S_1
...
S_H


・1 行目では、グリッドの行数 H , 列数 W が半角スペース区切りで与えられます。
・2 行目では、スタート地点のマスの座標を表す sy, sx が半角スペース区切りで与えられます。
・3 行目では、ゴール地点のマスの座標を表す gy, gx が半角スペース区切りで与えられます。
・続く H 行のうち i 行目 (1 ≦ i < H) には、グリッドの i-1 行目の文字をまとめた文字列 S_i が与えられ、S_i の j 文字目は、グリッドの i 行目の j-1 列目に書かれている文字を表します。(1 ≦ j < W)

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
・(sy,sx) から移動をして (gy,gx) に到達することができる場合は "Yes" を、到達できない場合は "No" を出力してください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・1 ≦ H, W ≦ 100
・0 ≦ sy < H
・0 ≦ sx < W
・0 ≦ gy < H
・0 ≦ gx < W
・マス(sy,sx), (gy,gx) は '.' である
・ S_i は W 文字の文字列(1 ≦ i ≦ H)
・ S_i の各文字は '.' または '#'(1 ≦ i ≦ H)

入力例1
2 2
0 0
1 1
.#
#.

出力例1
No

入力例2
3 3
0 0
2 0
...
##.
...

出力例2
Yes
=end
