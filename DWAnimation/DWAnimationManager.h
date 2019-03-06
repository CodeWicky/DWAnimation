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
 配合DWAnimation中改造beginTime
 */

#import <UIKit/UIKit.h>
@class DWAnimation;

typedef NS_ENUM(NSInteger , DWAnimationPlayMode) {
    DWAnimationPlayModeMulti,///不同view分线处理
    DWAnimationPlayModeSingle///不区分view，按数组顺序播放
};

@interface DWAnimationManager : NSObject

///按顺序执行一组动画
/*
 animations     以DWAnimation对象组成的数组
 */
+(void)startAnimations:(__kindof NSArray<__kindof DWAnimation *> *)animations playMode:(DWAnimationPlayMode)playMode;
@end
