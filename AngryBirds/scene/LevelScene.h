//
//  LevelScene.h
//  AngryBirds
//
//  Created by luowei on 14-7-4.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LevelScene : CCLayer{
    int successLevel; // 当前成功的通关数 1-16
}

+ (id) scene ;

@end
