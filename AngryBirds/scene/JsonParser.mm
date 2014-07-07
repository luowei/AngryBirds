//
//  JsonParser.m
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "JsonParser.h"

#import "SBJson.h"

@implementation SpriteModel

@synthesize tag, x, y, angle;

@end

@implementation JsonParser

+ (id) getAllSprite:(NSString *)file {
    // 读取文件file里面的所有内容
    NSString *levelContent = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    // json解析，SpriteModel精灵的数据模型对象
    NSArray *spriteArray = [[[levelContent JSONValue] objectForKey:@"sprites"] objectForKey:@"sprite"];
    // 从数据文件中读取的所有的精灵对象
    NSMutableArray *a = [NSMutableArray array];
    for (NSDictionary *dict in spriteArray) {
        
        SpriteModel *sm = [[SpriteModel alloc] init];
        
        sm.tag = [[dict objectForKey:@"tag"] intValue];
        sm.x = [[dict objectForKey:@"x"] floatValue];
        sm.y = [[dict objectForKey:@"y"] floatValue];
        sm.angle = [[dict objectForKey:@"angle"] floatValue];
        
        [a addObject:sm];
        [sm release];
    }
    
    return a;
}
@end
