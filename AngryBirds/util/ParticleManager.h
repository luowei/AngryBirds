//
//  ParticleManager.h
//  AngryBirds
//
//  Created by luowei on 14-7-4.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// 定义2种粒子效果
typedef enum {
    ParticleTypeSnow,  // 雪花的粒子效果
    ParticleTypeBirdExplosion, // 爆破的粒子效果
    ParticleTypeMax
} ParticleTypes;

@interface ParticleManager : NSObject
+ (id) sharedParticleManager;
// 取得单例对象
- (CCParticleSystem *) particleWithType:(ParticleTypes)type;
// 取得指定type的粒子对象

@end
