public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // Please paste your code from HW1 CGLine.
    int xStart = (int) x1;
    int yStart = (int) y1;
    int xEnd = (int) x2;
    int yEnd = (int) y2;

    // 計算兩點之間的差異
    int b = Math.abs(xEnd - xStart);
    int a = Math.abs(yEnd - yStart);

    // 確定前進方向
    int sx = xStart < xEnd ? 1 : -1;
    int sy = yStart < yEnd ? 1 : -1;

    // 斜率小於 1 的情況 (x 為主導軸) (m = a/b)
    if (b >= a) {
        int d = 2 * a - b;
        int dE = 2 * a;
        int dNE = 2 * (a - b);

        while (xStart != xEnd) {
            drawPoint(xStart, yStart, color(255, 0, 0));
            if (d <= 0) {
                d += dE;
            } else {
                d += dNE;
                yStart += sy;
            }
            xStart += sx;
        }
    }
    // 斜率大於 1 的情況 (y 為主導軸)
    else {
        int d = 2 * b - a;
        int dE = 2 * b;
        int dNE = 2 * (b - a);

        while (yStart != yEnd) {
            drawPoint(xStart, yStart, color(255, 0, 0));
            if (d <= 0) {
                d += dE;
            } else {
                d += dNE;
                xStart += sx;
            }
            yStart += sy;
        }
    }
    // 最後繪製終點
    drawPoint(xEnd, yEnd, color(255, 0, 0));
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2 
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.

    int n = vertexes.length;
    boolean inside = false;

    for (int i = 0, j = n - 1; i < n; j = i++) {
        float xi = vertexes[i].x, yi = vertexes[i].y;
        float xj = vertexes[j].x, yj = vertexes[j].y;

        // 檢查點 (x, y) 與多邊形邊 (xi, yi) -> (xj, yj) 是否相交
        if ((yi > y) != (yj > y) && 
            (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) {
            // 如果相交，翻轉 inside 的值，計算射線穿過邊的次數，並利用奇偶法判斷點是否在多邊形內部
            inside = !inside;
        }
    }

    return inside;
}

public Vector3[] findBoundBox(Vector3[] v) {
    
    
    // TODO HW2 
    // You need to find the bounding box of the vertices v.
    // r1 -------
    //   |   /\  |
    //   |  /  \ |
    //   | /____\|
    //    ------- r2

    //Vector3 recordminV = new Vector3(0);
    //Vector3 recordmaxV = new Vector3(999);
    //Vector3[] result = { recordminV, recordmaxV };
    if (v == null || v.length == 0) {
        return new Vector3[] { new Vector3(0), new Vector3(0) };
    }

    // 初始化最小和最大點為第一個頂點
    Vector3 recordminV = new Vector3(v[0].x, v[0].y, v[0].z);
    Vector3 recordmaxV = new Vector3(v[0].x, v[0].y, v[0].z);

    // 遍歷頂點以找出最小和最大值
    for (int i = 1; i < v.length; i++) {
        Vector3 vertex = v[i];
        
        // 更新最小值
        if (vertex.x < recordminV.x) recordminV.x = vertex.x;
        if (vertex.y < recordminV.y) recordminV.y = vertex.y;
        if (vertex.z < recordminV.z) recordminV.z = vertex.z;

        // 更新最大值
        if (vertex.x > recordmaxV.x) recordmaxV.x = vertex.x;
        if (vertex.y > recordmaxV.y) recordmaxV.y = vertex.y;
        if (vertex.z > recordmaxV.z) recordmaxV.z = vertex.z;
    }

    // 返回包含邊界框的頂點數組
    Vector3[] result = { recordminV, recordmaxV };
    return result;

}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertices of the "boundary".
    // The output is the vertices of the polygon.
    // 對 boundary 的每一條邊進行裁剪
    for (int i = 0; i < boundary.length; i += 1) {
        Vector3 p1 = boundary[i];
        Vector3 p2 = boundary[(i + 1) % boundary.length]; // 使用模數確保形成閉合多邊形

        output = new ArrayList<Vector3>();

        // 對多邊形的每一條邊進行裁剪
        for (int j = 0; j < input.size(); j += 1) {
            Vector3 current = input.get(j);
            Vector3 prev = input.get((j + input.size() - 1) % input.size());

            boolean currentInside = isInside(current, p1, p2);
            boolean prevInside = isInside(prev, p1, p2);

            if (currentInside) {
                if (!prevInside) {
                    output.add(intersect(prev, current, p1, p2)); // 加入交點
                }
                output.add(current); // 加入當前點
            } else if (prevInside) {
                output.add(intersect(prev, current, p1, p2)); // 只加入交點
            }
        }

        // 更新 input 為新多邊形
        input = output;
    }

    // 將結果轉換為 Vector3[]
    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}
private boolean isInside(Vector3 point, Vector3 edgeStart, Vector3 edgeEnd) {
    // 使用向量叉積來判斷是否在內側
    return (edgeEnd.x - edgeStart.x) * (point.y - edgeStart.y) 
         < (edgeEnd.y - edgeStart.y) * (point.x - edgeStart.x);
}
private Vector3 intersect(Vector3 start, Vector3 end, Vector3 edgeStart, Vector3 edgeEnd) {
    float dx1 = end.x - start.x;
    float dy1 = end.y - start.y;
    float dx2 = edgeEnd.x - edgeStart.x;
    float dy2 = edgeEnd.y - edgeStart.y;

    float denominator = dx1 * dy2 - dy1 * dx2;
    if (denominator == 0) {
        // 平行情況下，沒有交點
        return null;
    }

    float t = ((edgeStart.x - start.x) * dy2 - (edgeStart.y - start.y) * dx2) / denominator;
    return new Vector3(start.x + t * dx1, start.y + t * dy1, 0); // 假設 Z = 0
}
