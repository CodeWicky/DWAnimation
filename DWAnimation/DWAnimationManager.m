//
//  DWAnimationManager.m
//  DWHUD
//
//  Created by Wicky on 16/8/21.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWAnimationManager.h"
#import "DWAnimation.h"

@implementation DWAnimationManager

///按顺序执行一组动画
+(void)startSingleAnimations:(__kindof NSArray<__kindof DWAnimation *> *)animations
{
    if (!animations.count) {
        return;
    }
    __block float startTime = 0;
    
    [animations enumerateObjectsUsingBlock:^(DWAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.beginTime += startTime;
        startTime += [[obj valueForKey:@"actualDuration"] floatValue];
        [obj start];
    }];
}

///并发执行不同view的动画
+(void)startMultiAnimations:(__kindof NSArray<DWAnimation *> *)animations
{
    NSMutableArray * arr = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [animations enumerateObjectsUsingBlock:^(DWAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer * layer = obj.layer;
        if (![arr containsObject:layer]) {
            [arr addObject:layer];
        }
        NSString * key = [NSString stringWithFormat:@"%lu",(unsigned long)[arr indexOfObject:layer]];
        NSMutableArray * array = dic[key];
        if (!array) {
            array = [NSMutableArray array];
            [dic setValue:array forKey:key];
        }
        [array addObject:obj];
    }];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [[DWAnimation createAnimationWithAnimations:obj animationKey:nil] start];
    }];
    
}

///根据不同的模式播放动画
+(void)startAnimations:(__kindof NSArray<DWAnimation *> *)animations playMode:(DWAnimationPlayMode)playMode
{
    switch (playMode) {
        case DWAnimationPlayModeSingle:
            [DWAnimationManager startSingleAnimations:animations];
            return;
            break;
        case DWAnimationPlayModeMulti:
            [DWAnimationManager startMultiAnimations:animations];
            return;
            break;
        default:
            [DWAnimationManager startSingleAnimations:animations];
            break;
    }
}
@end
