# 2部グラフならTrue, そうでなければFalse
def is_bipartite(input_str):
    # 入力
    input_lines = input_str.split("\n")
    n, m = map(int, input_lines[0].split())
    paths = []
    for line in input_lines[1:]:
        a, b = map(int, line.split())
        paths.append([a - 1, b - 1])

    es = [[] for _ in range(n)]
    for a, b in paths:
        es[a].append(b)
        es[b].append(a)

    # n個の頂点の色を初期化。0:未着色、1:黒、-1:白
    colors = [0 for i in range(n)]

    # (頂点、色)のタプルをスタックする。最初は(頂点0, 黒(1))
    stack = [(441, 1)]
    while stack:
        # スタックから最後に追加された(頂点, 色)をpop
        v, color = stack.pop()
        # 今いる点を着色
        colors[v] = color
        # 今の頂点から行けるところをチェック
        for to in es[v]:
            print([color, colors[to]])
            # 同じ色が隣接してしまったらFalse
            if colors[to] == color:
                return False
            # 未着色の頂点があったら反転した色と共にスタックに積む
            if colors[to] == 0:
                stack.append((to, -color))
    # 調べ終わったら矛盾がないのでTrue
    return True


print(is_bipartite(open(0).read()))
