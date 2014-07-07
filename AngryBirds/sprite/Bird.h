//
//  Bird.h
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"

#import "SpriteBase.h"

@interface Bird : SpriteBase
{
    BOOL _isFly;
    BOOL _isReady;
}
@property (nonatomic, assign) BOOL isFly;
@property (nonatomic, assign) BOOL isReady;

-(void)setSpeedX:(float)x andY:(int)y andWorld:(b2World*)world;
-(void)hitAnimationX:(float)x andY:(float)y;


@end