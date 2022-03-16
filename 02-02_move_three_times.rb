INPUT1 = <<~"EOS"
  6 2
  2 0
EOS

OUTPUT1 = <<~"EOS"
  **
  **
  **
  **
  **
  *.
EOS

INPUT2 = <<~"EOS"
  1 1
  0 0
EOS

OUTPUT2 = <<~"EOS"
  *
EOS

=begin
3 マスの移動 (paizaランク B 相当)
問題にチャレンジして、ユーザー同士で解答を教え合ったり、コードを公開してみよう！

シェア用URL:
https://paiza.jp/works/mondai/bfs_dfs_problems/bfs_dfs_problems__move_three_times
問題文のURLをコピーする
 下記の問題をプログラミングしてみよう！
ここから先は幅優先探索の問題を扱います。
幅優先探索とは、「現在いるマスから 1 回移動した先の頂点を訪問する」操作を未訪問の頂点が無くなる、もしくは移動できなくなるまで繰り返す探索のことです。
グリッドの行数 H と列数 W が与えられるので、マス (y,x) から次の操作を 1 回としたとき、 3 回以内に到達することができるマスを '*' , それ以外のマスを '.' にしたグリッドを出力してください。

・現在いるマスを (y,x) としたとき、(y+1,x), (y-1,x), (y,x+1), (y,x-1) のいずれかのマスに移動する。

ただし、グリッドの外へは移動することができません。
なお、グリッドの左上・右上・左下・右下のマスをそれぞれ (0,0), (0,W-1), (H-1,0), (H-1,W-1) とします。
到達できるマスに (y,x) が含まれることに気をつけてください。

例として、次の図のような入力について幅優先探索の流れを紹介します。
赤いマスがスタート地点とします。
一度の移動で到達できるマスは図 1 の通りになります。





そのマスからさらにもう一度移動することで到達することができるマスは図 2 の通りになり、最終的に図 3 の青と赤のマスを *, それ以外のマスを '.' にしたグリッドが答えになります。






--- ヒント ---
「2 マス移動することで新たに行けるようになるマス」は、「1 マス移動することで新たに到達できるようになったマス」から 1 マス移動して行けるマスなので、
「1 マス移動することで新たに到達できるようになったマス」を配列などで覚えておき、そのマスから新たな移動を行いましょう。
この操作を 2 度行い、3 マス移動して到達することができるマスを求めましょう。
▼　下記解答欄にコードを記入してみよう

入力される値
H W
y x


・ 1 行目では、グリッドの行数 H , 列数 W が半角スペース区切りで与えられます。
・ 2 行目では、移動を開始するマスの座標を表す y, x が半角スペース区切りで与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
H 行の出力

・マス (y,x) から前後左右に 3 マス移動して到達することができるマスを '*' , それ以外のマスを '.' にしたグリッドを出力してください。
・各行の要素を繋げて文字列としたものを改行区切りで出力してください。
・詳しくは入力例を参考にしてください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・1 ≦ H, W ≦ 10
・0 ≦ y < H
・0 ≦ x < W

入力例1
6 2
2 0

出力例1
**
**
**
**
**
*.

入力例2
1 1
0 0

出力例2
*
=end