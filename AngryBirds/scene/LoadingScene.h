//
//  LoadingScene.h
//  AngryBirds
//
//  Created by luowei on 14-7-3.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "StartScene.h"

@interface LoadingScene : CCLayer{
    // 定义一个展示字符串的一个对象
    CCLabelBMFont *loadingTitle;
    
}

// 提供给外部一个 scene
+ (id) scene;

@end
