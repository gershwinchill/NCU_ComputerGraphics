# CG Assignments - Lab 1

## 我的任務清單
- [O] Translation Matrix
- [O] Rotation Matrix (Z-axis)
- [O] Scaling Matrix
- [O] pnpoly
- [O] findBoundBox
- [O] Sutherland_Hodgman_algorithm
- [X] bonus

## 作業說明
- Task1-Translation Matrix
<br>給定4x4矩陣，把單位矩陣右邊的值換掉變成位移矩陣。
<br>![alt text](image.png)

- Task2-Rotation Matrix (Z-axis)
<br>給定4x4矩陣，做出對z軸旋轉的旋轉矩陣。
<br>![alt text](image-1.png)

- Task-Scaling Matrix
<br>>給定4x4矩陣，做出拉伸矩陣。
<br>![alt text](image-2.png)

- Task-pnpoly
<br>用ChatGPT做出，丟入題目和敘述做出。用射線法判斷當在點(x,y)向右發射射線，如果有奇數次相交，代表inside；偶數次相交，則代表 not inside。
<br>![alt text](image-3.png)

- Task-findBoundBox
<br>用ChatGPT做出，丟入題目和敘述做出。用for掃過所有點，更新紀錄最大和最小的頂點值。
<br>![alt text](image-4.png)

- Task-Sutherland_Hodgman_algorithm
<br>用ChatGPT做出，丟入題目和敘述，之後修改inside的判定方向做出。用Sutherland_Hodgman演算法，對每個邊界做檢查，如果發現多邊形跟邊界有交點則放入交點和邊界以內的點，並裁減邊界外的點，迭代完全部邊界結束。
<br>![alt text](image-5.png)

