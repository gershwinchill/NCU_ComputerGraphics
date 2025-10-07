# CGLine - Midpoint Line Algorithm

## 流程
1. 計算水平與垂直距離 $dx, dy$，判斷斜率是否大於 1，如是則交換 x、y。
2. 設置決策變數 $d = 2 \cdot dy - dx$。
3. 從起點沿主要方向迭代：

   * 若 $d > 0$，y 增加一格，並更新 $d = d + 2 \cdot (dy - dx)$。
   * 否則 y 不變，更新 $d = d + 2 \cdot dy$。
4. 繼續直到到達終點。

---

# CGCircle - Midpoint Circle Algorithm

## 流程
1. 計算圓心 \$(xc, yc)\$ 與半徑 \$r\$，初始化起點 \$x = 0\$，\$y = r\$，決策變數 \$d = 1 - r\$。

2. 循環直到 \$x > y\$：

   * 利用圓的八分對稱性，同時畫出 \$(x, y)\$ 對應的 8 個象限點。
   * 若 \$d < 0\$，下一個像素沿 x 增加，更新 \$d = d + 2 \cdot x + 3\$。
   * 否則，沿 x 增加，y 減少，更新 \$d = d + 2 \cdot (x - y) + 5\$。

3. 重複迴圈直到完成整個圓。

---

# CGEllipse - Midpoint Ellipse Algorithm

## 流程
1. 設定橢圓中心 \$(xc, yc)\$ 和半軸長 \$rx, ry\$，初始化起點 \$x=0\$，\$y=ry\$，決策變數 \$d\_1 = ry^2 - rx^2 ry + 0.25 rx^2\$。
2. **Region 1（斜率 < 1）**：

   * 每步 x 增加 1，依據 \$d\_1\$ 判斷 y 是否減少 1，更新決策變數。
   * 畫出橢圓四個象限對稱點。
3. **Region 2（斜率 ≥ 1）**：

   * 每步 y 減少 1，依據 \$d\_2\$ 判斷 x 是否增加 1，更新決策變數。
   * 畫出橢圓四個象限對稱點。
4. 重複迴圈直到 y < 0，完成整個橢圓。

---

# CGCurve - Cubic Bézier Curve

## 流程
1. 設定四個控制點 $P_1, P_2, P_3, P_4$。
2. 對參數 $t \in [0,1]$：

   * 計算曲線點座標

     $$
     B(t) = (1-t)^3 P_1 + 3t(1-t)^2 P_2 + 3t^2(1-t) P_3 + t^3 P_4
     $$
   * 使用 `drawPoint` 將計算出的點畫在螢幕上。
3. 遞增 t 直到 1，生成整條平滑曲線。

---

# CGEraser - Eraser Tool

## 流程
1. 使用兩個控制點 $P_1, P_2$ 定義矩形區域。
2. 計算矩形邊界：

   * $x_{\text{start}} = \min(P_1.x, P_2.x)$
   * $x_{\text{end}} = \max(P_1.x, P_2.x)$
   * $y_{\text{start}} = \min(P_1.y, P_2.y)$
   * $y_{\text{end}} = \max(P_1.y, P_2.y)$
3. 對矩形內每個像素，呼叫 `drawPoint(x, y, bgColor)` 將其填充為背景色。
4. 可搭配滑鼠滾輪調整擦除範圍或改造成圓形橡皮擦。

reference:chatgpt
