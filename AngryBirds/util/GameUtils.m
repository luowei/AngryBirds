//
//  GameUtils.m
//  AngryBirds
//
//  Created by luowei on 14-7-4.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "GameUtils.h"

@implementation GameUtils

+ (NSString *) getLevelFilePath {
    // 得到存放成功通关的文件
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SuccessLevel"];
    // 存在沙盒 Documents/SuccessLevel;
}
+ (int) readLevelFromFile {
    NSString *file = [[self class] getLevelFilePath];
    // 取得存放数据文件；
    // 读取文件
    NSString *s = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    if (s) {
        return [s intValue];
    }
    return 2; // 2缺省的通关管卡
}
+ (void) writeLevelToFile:(int)level {
    NSString *s = [NSString stringWithFormat:
                   @"%d", level];
    // 把level转化成一个字符串
    NSString *file = [[self class] getLevelFilePath];
    // 取得要存放的文件
    [s writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
