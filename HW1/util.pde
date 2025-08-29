public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).

    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */
      boolean steep = Math.abs(y2 - y1) > Math.abs(x2 - x1);

      // 如果斜率大於1，交換 x 與 y
      if (steep) {
          float tmp;
          tmp = x1; x1 = y1; y1 = tmp;
          tmp = x2; x2 = y2; y2 = tmp;
      }
      // 方向
      float sx = (x1 < x2) ? 1 : -1;
      float sy = (y1 < y2) ? 1 : -1;
      float dx = Math.abs(x2 - x1);
      float dy = Math.abs(y2 - y1);
      float d = 2 * dy - dx; // 初始判斷值
      float y = y1;
      int c = color(0,0,0);  //black
      // 從起點走到終點
      for (float x = x1; sx > 0 ? x <= x2 : x >= x2; x += sx) {
          // 畫點，四捨五入到整數座標
          if (steep) {
              drawPoint(Math.round(y), Math.round(x),c);
          } else {
              drawPoint(Math.round(x), Math.round(y),c);
          }
          if (d > 0) {
              y += sy;
              d -= 2 * dx;
          }
          d += 2 * dy;
      }
}

public void CGCircle(float xc, float yc, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    int x = 0;
    int y = Math.round(r);
    int d = 1 - Math.round(r); // 初始判斷值
    int c = color(0,0,0); //black
    while (x <= y) {
        // 利用圓的八分對稱性畫點
        drawPoint(Math.round(xc + x), Math.round(yc + y),c);
        drawPoint(Math.round(xc - x), Math.round(yc + y),c);
        drawPoint(Math.round(xc + x), Math.round(yc - y),c);
        drawPoint(Math.round(xc - x), Math.round(yc - y),c);
        drawPoint(Math.round(xc + y), Math.round(yc + x),c);
        drawPoint(Math.round(xc - y), Math.round(yc + x),c);
        drawPoint(Math.round(xc + y), Math.round(yc - x),c);
        drawPoint(Math.round(xc - y), Math.round(yc - x),c);

        if (d < 0) {
            d += 2 * x + 3;
        } else {
            d += 2 * (x - y) + 5;
            y--;
        }
        x++;
    }
    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
}

public void CGEllipse(float xc, float yc, float rx, float ry) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */
   
      float x = 0;
      float y = ry;

      // 初始決策參數
      float rx2 = rx * rx;
      float ry2 = ry * ry;
      float twoRx2 = 2 * rx2;
      float twoRy2 = 2 * ry2;

      float px = 0;
      float py = twoRx2 * y;

      // Region 1: slope < 1
      float d1 = ry2 - rx2 * ry + 0.25f * rx2;
      while (px < py) {
          plotEllipsePoints(xc, yc, x, y);

          x++;
          px += twoRy2;
          if (d1 < 0) {
              d1 += ry2 + px;
          } else {
              y--;
              py -= twoRx2;
              d1 += ry2 + px - py;
          }
      }

      // Region 2: slope >= 1
      float d2 = ry2 * (x + 0.5f) * (x + 0.5f) + rx2 * (y - 1) * (y - 1) - rx2 * ry2;
      while (y >= 0) {
          plotEllipsePoints(xc, yc, x, y);

          y--;
          py -= twoRx2;
          if (d2 > 0) {
              d2 += rx2 - py;
          } else {
              x++;
              px += twoRy2;
              d2 += rx2 - py + px;
          }
      }
    }

    // 利用橢圓對稱性畫四個象限
    private void plotEllipsePoints(float xc, float yc, float x, float y) {
        int c = color(0,0,0); 
        drawPoint(Math.round(xc + x), Math.round(yc + y),c);
        drawPoint(Math.round(xc - x), Math.round(yc + y),c);
        drawPoint(Math.round(xc + x), Math.round(yc - y),c);
        drawPoint(Math.round(xc - x), Math.round(yc - y),c);
    }



public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
    float step = 0.001f; // 控制平滑度
    for (float t = 0; t <= 1.0f; t += step) {
        float oneMinusT = 1 - t;

        float x = (float)(Math.pow(oneMinusT, 3) * p1.x
                        + 3 * t * Math.pow(oneMinusT, 2) * p2.x
                        + 3 * Math.pow(t, 2) * oneMinusT * p3.x
                        + Math.pow(t, 3) * p4.x);

        float y = (float)(Math.pow(oneMinusT, 3) * p1.y
                        + 3 * t * Math.pow(oneMinusT, 2) * p2.y
                        + 3 * Math.pow(t, 2) * oneMinusT * p3.y
                        + Math.pow(t, 3) * p4.y);

        drawPoint(Math.round(x), Math.round(y), color(0,0,0));
    }
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    int xStart = Math.round(Math.min(p1.x, p2.x));
    int xEnd   = Math.round(Math.max(p1.x, p2.x));
    int yStart = Math.round(Math.min(p1.y, p2.y));
    int yEnd   = Math.round(Math.max(p1.y, p2.y));

    for (int y = yStart; y <= yEnd; y++) {
        for (int x = xStart; x <= xEnd; x++) {
            drawPoint(x, y,  color(250));
        }
    }

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
