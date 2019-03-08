//
//  DWAnimationAbstraction.h
//  DWAnimation
//
//  Created by Wicky on 16/10/26.
//  Copyright © 2016年 Wicky. All rights reserved.
//


/**
 DWAnimationAbstraction
 
 DWAnimation抽象类，为DWAnimation及DWAniamtionGroup提供公共接口
 其中DWAnimation与DWAnimationGroup均对各属性方法进行重写
 
 version 1.0.0
 抽象出基础属性beginTime，duration
 抽象出基础方法，动画操作方法
 
 version 1.0.1
 抽象出completion、animationStart、status三个属性
 */

@class DWAnimationAbstraction;
typedef void(^DWAnimationCallback)(__kindof DWAnimationAbstraction * ani);

typedef NS_ENUM(NSInteger ,DWAnimationStatus) {
    DWAnimationStatusReadyToShow,///具备播放条件状态
    DWAnimationStatusPlaying,///播放状态
    DWAnimationStatusSuspended,///暂停状态
    DWAnimationStatusFinished,///播放完成状态
    DWAnimationStatusRemoved///移除状态
};

#import <UIKit/UIKit.h>

@interface DWAnimationAbstraction : NSObject
///动画时长
@property (nonatomic ,assign) CGFloat duration;

///动画延时时长
@property (nonatomic ,assign) CGFloat beginTime;

///动画完成回调
@property (nonatomic ,copy) DWAnimationCallback completion;

///动画开始回调
@property (nonatomic ,copy) DWAnimationCallback animationStart;

///动画状态
@property (nonatomic ,assign) DWAnimationStatus status;

#pragma mark ---动画控制方法---

/**
 开始播放动画
 */
-(void)start;


/**
 暂停动画
 */
-(void)suspend;


/**
 恢复动画
 */
-(void)resume;


/**
 移除动画
 
 注：
 若要移除，请确保初始化时animationKey正确
 移除仅移除调用移除方法的动画实例，将返回动画的上一状态
 */
-(void)remove;
@end
