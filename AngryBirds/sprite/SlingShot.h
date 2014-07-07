//
//  SlingShot.h
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "CCSprite.h"

@interface SlingShot : CCSprite {
    CGPoint _startPoint1;
    CGPoint _startPoint2;
    
    CGPoint _endPoint;
}
@property (nonatomic, assign) CGPoint startPoint1;
@property (nonatomic, assign) CGPoint startPoint2;
@property (nonatomic, assign) CGPoint endPoint;


@end
