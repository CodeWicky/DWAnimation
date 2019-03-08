//
//  CALayer+DWAnimation.h
//  DWAnimation
//
//  Created by Wicky on 16/10/8.
//  Copyright © 2016年 Wicky. All rights reserved.
//
/*
 CALayer (DWAnimation)
 
 简介：基于DWAnimation和DWAnimationManager的CALayer扩展
 
 version 1.0.0 提供CALayer扩展动画方法
 */
#import <QuartzCore/QuartzCore.h>
#import "DWAnimationMaker.h"
#import "DWAnimationManager.h"
#import "DWAnimation.h"
@interface CALayer (DWAnimation)

/**
 以block形式为自身创建动画(移动，缩放，旋转，透明度，圆角，边框宽度，边框颜色，阴影颜色，阴影偏移量，阴影透明度，阴影路径，阴影圆角，背景图，背景色)

 @param animationKey 动画的标识，可为nil
 @param animationCreater 创建动画的回调Block
 @return 返回动画实例
 */
-(DWAnimation *)dw_CreateAnimationWithKey:(NSString *)animationKey
                         animationCreater:(void(^)(DWAnimationMaker * maker))animationCreater;


/**
 以数组形式为自身创建动画

 @param animationKey 动画时长
 @param beginTime 动画延迟时间
 @param duration 动画的标识，可为nil
 @param animations 动画数组，由CAAnimation及其派生类组成
 @return 返回动画实例
 */
-(DWAnimation *)dw_CreateAnimationWithAnimationKey:(NSString *)animationKey
                                         beginTime:(CGFloat)beginTime
                                          duration:(CGFloat)duration
                                        animations:(__kindof NSArray<CAAnimation *> *)animations;


/**
 以多个状态及时间间隔为自身创建连续动画

 @param animationType 创建的动画类型
 @param animationKey 动画的标识
 @param beginTime 动画延迟时间
 @param values 动画的状态值数组
 @param timeIntervals 动画每两个相邻状态间的时间间隔数组
 @param transition 各个动画状态节点间是否平滑过渡
 @return 返回动画实例
 
 注：
 animationType的默认属性为DWAnimationTypeMove
 values中第一个数据为动画的初始状态，之后的数据为状
 态节点。timeIntervals是当前状态节点距上一节点的时
 间间隔。如：timeIntervals的第一个数据为第一个状态
 节点距初始状态的时间间隔。故timeIntervals数组元素
 个数应该比values元素个数少1。若参数不正确，则返回nil。
 */
-(DWAnimation *)dw_CreateAnimationWithAnimationType:(DWAnimationType)animationType
                                       animationKey:(NSString *)animationKey
                                          beginTime:(CGFloat)beginTime
                                             values:(NSArray *)values
                                      timeIntervals:(NSArray *)timeIntervals
                                         transition:(BOOL)transition;


/**
 以贝塞尔曲线为自身创建移动动画

 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @param bezierPath 运动轨迹，不可为nil
 @param autoRotate 跟随路径自动旋转
 @return 返回动画实例
 */
-(DWAnimation *)dw_CreateAnimationWithAnimationKey:(NSString *)animationKey
                                         beginTime:(CGFloat)beginTime
                                          duration:(CGFloat)duration
                                        bezierPath:(UIBezierPath *)bezierPath
                                        autoRotate:(BOOL)autoRotate;


/**
 为自身创建弧线动画

 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @param center 弧线圆心
 @param radius 弧线半径
 @param startAngle 弧线的起始角度
 @param endAngle 弧线的终止角度
 @param clockwise 是否为顺时针
 @param autoRotate 是否跟随弧线自动旋转
 @return 返回动画实例
 */
-(DWAnimation *)dw_CreateAnimationWithAnimationKey:(NSString *)animationKey
                                         beginTime:(CGFloat)beginTime
                                          duration:(CGFloat)duration
                                         arcCenter:(CGPoint)center
                                            radius:(CGFloat)radius
                                        startAngle:(CGFloat)startAngle
                                          endAngle:(CGFloat)endAngle
                                         clockwise:(BOOL)clockwise
                                        autoRotate:(BOOL)autoRotate;


/**
 为自身创建震荡动画

 @param animationKey 动画的标识，可为nil
 @param springingType 动画类型
 @param beginTime 动画延时时长
 @param fromValue 起始值：可为nil或MAXFLOAT或CGPointNull的对象形态，若为nil或MAXFLOAT或CGPointNull的对象形态，则以当前状态作为初始状态
 @param toValue 终止值：不可为nil
 @param mass 惯性系数：影响震荡幅度，需大于0。想实现默认效果请传1。
 @param stiffness 刚性系数：影响震荡速度，需大于0。想实现默认效果请传100。
 @param damping 阻尼系数：影响震荡停止速度，需大于0。想实现默认效果请传10。
 @param initialVelocity 初始速度：可正可负，负则先做反向运动，随后正向。想实现默认效果请传0。
 @return 返回动画实例
 
 注：fromValue与toValue，除DWAnimationSpringTypeMove应为NSValue类型外，其他均应为NSNumber类型数据
 */
-(DWAnimation *)dw_CreateAnimationWithAnimationKey:(NSString *)animationKey
                                     springingType:(DWAnimationSpringType)springingType
                                         beginTime:(CGFloat)beginTime
                                         fromValue:(id)fromValue
                                           toValue:(id)toValue
                                              mass:(CGFloat)mass
                                         stiffness:(CGFloat)stiffness
                                           damping:(CGFloat)damping
                                   initialVelocity:(CGFloat)initialVelocity;


/**
 创建特殊属性动画，即为指定属性（包括CALayer及其子类所有支持动画的属性）添加动画

 @param keyPath 将要添加动画的属性名
 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @param fromValue 起始值：可以为动画类型所对应的空类型。若为空，则默认当前状态为初始状态
 @param toValue 终止值：不可为nil
 @param timingFunctionName 动画节奏模式，可选值：@"linear", @"easeIn", @"easeOut" ,
 @"easeInEaseOut" 和 @"default"。也可使用其对应的常量形式，如kCAMediaTimingFunctionLinear
 @return 返回动画实例
 
 注：
 1.fromValue与toValue，均为UIKit中对象类型，如NSValue/NSNumber/UIColor/UIBezierPath/UIImage等等对应的对象类型。
 2.本方法创建的非CALayer属性动画不可用恢复动画自动恢复，请自行恢复
 */
-(DWAnimation *)dw_CreateAnimationWithKeyPath:(NSString *)keyPath
                                 animationKey:(NSString *)animationKey
                                    beginTime:(CGFloat)beginTime
                                     duration:(CGFloat)duration
                                    fromValue:(id)fromValue
                                      toValue:(id)toValue
                           timingFunctionName:(NSString *)timingFunctionName;


/**
 创建景深旋转动画，即具有透视效果的换轴旋转动画

 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @param startAngle 旋转起始角度
 @param endAngle 旋转终止角度
 @param rotateAxis 旋转轴
 @param deep 景深系数
 @return 返回动画实例
 
 注：
 1.旋转角度为角度制
 2.旋转轴为Z轴时无景深效果
 3.deep为景深系数，数值越小，透视效果越明显，反之效果更平缓，推荐值300
 */
-(DWAnimation *)dw_CreateAnimationWithAnimationKey:(NSString *)animationKey
                                         beginTime:(CGFloat)beginTime
                                          duration:(CGFloat)duration
                                  rotateStartAngle:(CGFloat)startAngle
                                    rotateEndAngle:(CGFloat)endAngle
                                        rotateAxis:(Axis)rotateAxis
                                              deep:(CGFloat)deep;


/**
 创建拟合锚点改变动画，以曲线旋转动画拟合改变锚点后的旋转动画

 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @param startAngle 旋转起始角度
 @param endAngle 旋转终止角度
 @param anchor 拟合的改变后锚点
 @return 返回动画实例
 
 注：
 1.旋转角度为角度制
 2.实际锚点不发生改变，为拟合路径
 */
-(DWAnimation *)dw_CreateAnimationWithAnimationKey:(NSString *)animationKey
                                         beginTime:(CGFloat)beginTime
                                          duration:(CGFloat)duration
                                  rotateStartAngle:(CGFloat)startAngle
                                    rotateEndAngle:(CGFloat)endAngle
                              simulateChangeAnchor:(CGPoint)anchor;


/**
 恢复动画

 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延迟时间
 @param duration 动画时长
 @return 返回动画实例
 
 注：特殊属性动画不在恢复动画范围内，请自行恢复。
 */
-(DWAnimation *)dw_CreateResetAnimationWithAnimationKey:(NSString *)animationKey
                                              beginTime:(CGFloat)beginTime
                                               duration:(CGFloat)duration;


/**
 按顺序执行一组动画

 @param animations 以DWAnimation对象组成的数组
 @param playMode 播放模式
 */
+(void)dw_StartAnimations:(__kindof NSArray<__kindof DWAnimationAbstraction *> *)animations playMode:(DWAnimationPlayMode)playMode;

@end
