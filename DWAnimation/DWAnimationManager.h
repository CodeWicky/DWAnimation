//
//  DWAnimationManager.h
//  DWHUD
//
//  Created by Wicky on 16/8/21.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/*
 DWAnimationManager
 
 简介：一句话自动按顺序执行动画
 
 version 1.0.0
 提供按数组顺序播放动画api
 
 version 1.0.1
 完善以数组播放api，两种播放模式
 
 version 1.0.2
 配合DWAnimation中改造beginTime,修改为enumerate
 */

#import <UIKit/UIKit.h>
@class DWAnimationAbstraction;

typedef NS_ENUM(NSInteger , DWAnimationPlayMode) {
    DWAnimationPlayModeMulti,///不同view分线处理
    DWAnimationPlayModeSingle///不区分view，按数组顺序播放
};

@interface DWAnimationManager : NSObject

/**
 按顺序执行一组动画

 @param animations 动画数组
 @param playMode 播放模式
 
 注：
 1.DWAnimationPlayModeSingle模式下所有animation按数组顺序串行播放
 2.DWAnimationPlayModeMulti模式下所有相同layer的动画按数组顺序穿行播放，不同layer动画间并行播放，所有animationGroup并行播放
 */
+(void)startAnimations:(__kindof NSArray<__kindof DWAnimationAbstraction *> *)animations playMode:(DWAnimationPlayMode)playMode;
@end
