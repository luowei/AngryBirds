//
//  ParticleManager.m
//  AngryBirds
//
//  Created by luowei on 14-7-4.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "ParticleManager.h"

static ParticleManager *s;

@implementation ParticleManager
+ (id) sharedParticleManager {
    if (s == nil) {
        s = [[ParticleManager alloc] init];
    }
    return s;
}
- (CCParticleSystem *) particleWithType:(ParticleTypes)type {
    CCParticleSystem *system = nil;
    switch (type) {
        case ParticleTypeSnow:
        {
            system = [CCParticleSnow node];
            // 取得雪花的粒子对象
            CCTexture2D *t = [[CCTextureCache sharedTextureCache] addImage:@"snow.png"];
            // 30x30
            // 把snow.png图片转化为纹理
            [system setTexture:t];
        }
            break;
        case ParticleTypeBirdExplosion:
        {
            system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"bird-explosion.plist"];
            // 使用bird-explosion.plist作为粒子效果的文件
            [system setPositionType:kCCPositionTypeFree];
            // 设置粒子效果位置独立
            [system setAutoRemoveOnFinish:YES];
            // 粒子效果完成后自动删除
        }
            break;
        default:
            break;
    }
    return system;
}
@end
