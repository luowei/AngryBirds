//
//  SlingShot.m
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//


#import "SlingShot.h"

@implementation SlingShot
@synthesize startPoint1 = _startPoint1;
@synthesize startPoint2 = _startPoint2;
@synthesize endPoint = _endPoint;

// draw函数 所有ccnode里面虚函数
- (void) draw {
    // 要实现真正的画线
    glLineWidth(2.0f); // 设置线宽
    glColor4f(1.0f, 0.0f, 0.0f, 1.0f); // 设置颜色
    glEnable(GL_LINE_SMOOTH); //把线段反锯齿
    
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
    GLfloat ver[4] = {_startPoint1.x, _startPoint1.y,
        _endPoint.x, _endPoint.y};
    glVertexPointer(2, GL_FLOAT, 0, ver);
    glDrawArrays(GL_LINES, 0, 2);
    
    GLfloat ver2[5] = {_startPoint2.x, _startPoint2.y,
        _endPoint.x, _endPoint.y};
    glVertexPointer(2, GL_FLOAT, 0, ver2);
    glDrawArrays(GL_LINES, 0, 2);
    
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    
    glDisable(GL_LINE_SMOOTH);
}

@end
