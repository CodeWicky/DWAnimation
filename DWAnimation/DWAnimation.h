//
//  DWAnimation.h
//  DWHUD
//
//  Created by Wicky on 16/8/20.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/*
 DWAnimation
 
 简介：一句话生成CALayer动画，支持动画间任意拼接、组合
 （仅限针对同一CALayer进行操作，若layer不同，请使用DWAnimationGroup）
 
 version 1.0.0
 提供两种生成动画的构造方法
 提供动画展示方法
 提供动画组合方法
 完成平移动画的相关api
 完成平移动画组合api
 
 version 1.0.1
 修改平移动画api，按照锚点移动
 修改动画创建逻辑，一个对象可创建多段动画
 移除组合动画api
 
 version 1.0.2
 新增动画拼接api
 新增按顺序拼接数组中全部动画api
 完成旋转动画相关api
 完成缩放动画相关api
 完成恢复动画api
 
 version 1.0.3
 添加创建连续动画api
 添加以贝塞尔曲线创建动画api
 添加为贝塞尔曲线动画定制子路径时长api
 添加创建弧线动画api
 添加组合动画api
 
 version 1.0.4
 完善弧线api，添加是否自动旋转接口
 
 version 1.0.5
 添加震荡动画api
 
 version 1.0.6
 添加动画开始、结束通知
 添加动画重复api
 
 version 1.0.7
 补充连续动画的圆角动画api
 添加暂停、恢复、移除动画api
 
 version 1.0.8
 完善block创建动画种类，补全边框相关、阴影相关、背景图动画api
 震荡动画、连续动画api补全
 
 version 1.0.9
 震荡动画、连续动画新增api的bug修复
 
 version 1.0.10
 优化动画重复逻辑，完善动画拼接、组合的动画重复效果
 
 version 1.0.11
 优化以数组创建动画api，为其添加beginTime参数
 
 version 1.0.12
 修复shadowPath动画播放结束后点击崩溃问题
 
 version 1.0.13
 贝塞尔曲线动画添加是否自动旋转接口
 优化弧线动画自动旋转逻辑
 
 version 1.0.14
 修复贝塞尔曲线动画使用拼接的贝塞尔曲线中间停顿bug
 
 version 1.0.15
 添加所有动画节奏均为线性模式
 
 version 1.0.16
 添加多状态动画及震荡动画对背景色动画的支持
 
 version 1.0.17
 优化恢复动画阴影路径逻辑及恢复代码整合
 
 version 1.1.0
 更改所有api中参数将UIView对象改为更加广泛适合的CALayer对象
 添加特殊属性动画api，支持为CALayer及其子类中所有支持动画的属性生成动画。
 
 version 1.1.1
 由于动画组animationGroup中需按beginTime顺序传入animations数组，故修改所有相关代码，其中包括以数组形式生成动画、以block形式生成动画、组合一组动画。
 添加动画节奏设置选项，支持修改动画节奏。
 
 version 1.1.2
 规范化方法名
 为组合动画、拼接动画、恢复动画添加animationKey接口
 
 version 1.1.3
 改变继承关系，继承自抽象类DWAnimationAbstraction
 
 version 1.1.4
 添加动画开始回调、结束回调
 
 version 1.1.5
 block形式动画支持缩放动画换轴
 
 version 1.1.6
 支持景深旋转动画
 
 version 1.1.7
 支持拟合锚点旋转动画
 
 version 1.1.8
 支持更换Layer开始动画
 
 version 1.1.9
 构造api改变，可传入CALayer、UIView、nil三种可选类型
 属性动画逻辑优化
 
 version 1.2.0
 更改beginTime含义，与CAAnimation保持一致。并重构所有API
 */

#import "DWAnimationAbstraction.h"
#import "DWAnimationConstant.h"
#import "DWAnimationMaker.h"
@class DWAnimationMaker;
@interface DWAnimation : DWAnimationAbstraction

///动画对象
@property (nonatomic ,strong) __kindof CAAnimation * animation;

///动画标识
@property (nonatomic ,copy) NSString * animationKey;

///展示动画的layer
@property (nonatomic ,strong) CALayer * layer;

///动画节奏类型名
@property (nonatomic ,copy) NSString * timingFunctionName;

///动画播放次数
/**
 repeatCount        数值设为MAXFLOAT，为无限播放
 repeatCount        数值设为0，不播放
 repeatCount        数值设为正数，播放次数
 */
@property (nonatomic ,assign) CGFloat repeatCount;

#pragma mark ---动画构造方法---

/**
 以block形式为自身创建动画(移动，缩放，旋转，透明度，圆角，边框宽度，边框颜色，阴影颜色，阴影偏移量，阴影透明度，阴影路径，阴影圆角，背景图，背景色)
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
 @param animationKey 动画的标识，可为nil
 @param animationCreater 创建动画的回调Block
 @return 返回动画实例
 
 注：
 当content为nil时，开始动画需配合startAnimationWithContent:使用。
 
 eg.:
 
 self.a = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"redAni" animationCreater:^(DWAnimationMaker *maker) {
 maker.moveTo(self.view.center).duration(0.4).install();
 maker.backgroundColorTo([UIColor greenColor]).beginTime(0.4).duration(0.4).install();
 }];
 */
-(instancetype)initAnimationWithContent:(id)content
                           animationKey:(NSString *)animationKey
                       animationCreater:(void(^)(DWAnimationMaker * maker))animationCreater;


/**
 以数组形式为自身创建动画
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
 @param animationKey 动画时长
 @param beginTime 动画延迟时间
 @param duration 动画的标识，可为nil
 @param animations 动画数组，由CAAnimation及其派生类组成
 @return 返回动画实例
 
 注：
 当content为nil时，开始动画需配合startAnimationWithContent:使用。
 
 eg.:
 
 CABasicAnimation * aniP = [CABasicAnimation animationWithKeyPath:@"position"];
 aniP.toValue = [NSValue valueWithCGPoint:self.view.center];
 aniP.fromValue = [NSValue valueWithCGPoint:self.redView.center];
 aniP.duration = 0.4;
 aniP.beginTime = 1;
 self.a = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"arrAni" beginTime:1 duration:1.4 animations:@[aniP]];
 
 */
-(instancetype)initAnimationWithContent:(id)content
                           animationKey:(NSString *)animationKey
                              beginTime:(CGFloat)beginTime
                               duration:(CGFloat)duration
                             animations:(__kindof NSArray<CAAnimation *> *)animations;


/**
 以关键帧为自身创建连续动画
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
 @param animationType 创建的动画类型
 @param animationKey 动画的标识
 @param beginTime 动画延迟时间
 @param values 动画的状态值数组
 @param timeIntervals 动画每两个相邻状态间的时间间隔数组
 @param transition 各个动画状态节点间是否平滑过渡
 @return 返回动画实例
 
 注：
 1.由于Api中会对Layer的一些属性按需做预处理，如果content传入nil，
 请自行处理borderWidth/shadowOpacity默认值以保证动画正常展示。
 2.animationType的默认属性为DWAnimationTypeMove
 values中第一个数据为动画的初始状态，之后的数据为状
 态节点。timeIntervals是当前状态节点距上一节点的时
 间间隔。如：timeIntervals的第一个数据为第一个状态
 节点距初始状态的时间间隔。故timeIntervals数组元素
 个数应该比values元素个数少1。若参数不正确，则返回nil。
 3.当content为nil时，开始动画需配合startAnimationWithContent:使用。
 
 eg.:
 
 self.a = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationType:(DWAnimationTypeMove) animationKey:@"timeIntervalAnimation" beginTime:1 values:@[[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(200, 100)],[NSValue valueWithCGPoint:CGPointMake(200, 200)],[NSValue valueWithCGPoint:CGPointMake(100, 200)],[NSValue valueWithCGPoint:CGPointMake(100, 100)]] timeIntervals:@[@1,@2,@3,@1] transition:NO];
 
 */
-(instancetype)initAnimationWithContent:(id)content
                          animationType:(DWAnimationType)animationType
                           animationKey:(NSString *)animationKey
                              beginTime:(CGFloat)beginTime
                                 values:(NSArray *)values
                          timeIntervals:(NSArray *)timeIntervals
                             transition:(BOOL)transition;


/**
 以贝塞尔曲线为自身创建移动动画
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @param bezierPath 运动轨迹，不可为nil
 @param autoRotate 跟随路径自动旋转
 @return 返回动画实例
 
 注：
 当content为nil时，开始动画需配合startAnimationWithContent:使用。
 
 eg.:
 
 UIBezierPath * bp = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.center.x - 100, self.view.center.y - 100, 200, 200)];
 self.a = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"bezierAnimation" beginTime:2 duration:5 bezierPath:bp autoRotate:YES];
 
 */
-(instancetype)initAnimationWithContent:(id)content
                           animationKey:(NSString *)animationKey
                              beginTime:(CGFloat)beginTime
                               duration:(CGFloat)duration
                             bezierPath:(UIBezierPath *)bezierPath
                             autoRotate:(BOOL)autoRotate;


/**
 为自身创建弧线动画
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
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
 
 注：
 1.度数为角度制
 2.0度为水平向右方向，顺时针方向为正方向。
 3.当content为nil时，开始动画需配合startAnimationWithContent:使用。
 
 eg.:
 self.a = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"arcAnimation" beginTime:2 duration:1 arcCenter:CGPointMake(self.view.center.x, self.view.center.y - 100) radius:200 startAngle:120 endAngle:60 clockwise:NO autoRotate:YES];
 
 */
-(instancetype)initAnimationWithContent:(id)content
                           animationKey:(NSString *)animationKey
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
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
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
 
 注：
 1.由于Api中会对Layer的一些属性按需做预处理，如果content传入nil，
 请自行处理borderWidth/shadowOpacity默认值以保证动画正常展示。
 2.当content为nil时，开始动画需配合startAnimationWithContent:使用。
 3.fromValue与toValue，均为UIKit中对象类型，如NSValue/NSNumber/UIColor/UIBezierPath/UIImage。
 
 eg.:
 self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"springAnimation" springingType:(DWAnimationSpringTypeScale) beginTime:2 fromValue:@0 toValue:@1 mass:1 stiffness:100 damping:10 initialVelocity:0];
 
 */
-(instancetype)initAnimationWithContent:(id)content
                           animationKey:(NSString *)animationKey
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
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
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
 1.当content为nil时，开始动画需配合startAnimationWithContent:使用。
 2.fromValue与toValue，均为UIKit中对象类型，如NSValue/NSNumber/UIColor/UIBezierPath/UIImage等等对应的对象类型。
 3.本方法创建的非CALayer属性动画不可用恢复动画自动恢复，请自行恢复
 
 eg.:
 self.ani = [[DWAnimation alloc] initAnimationWithContent:self.shape keyPath:@"path" animationKey:@"keyPathAnimation" beginTime:2 duration:2 fromValue:(__bridge id)self.fP.CGPath toValue:(__bridge id)self.tP.CGPath timingFunctionName:nil];
 
 */
-(instancetype)initAnimationWithContent:(id)content
                                keyPath:(NSString *)keyPath
                           animationKey:(NSString *)animationKey
                              beginTime:(CGFloat)beginTime
                               duration:(CGFloat)duration
                              fromValue:(id)fromValue
                                toValue:(id)toValue
                     timingFunctionName:(NSString *)timingFunctionName;


/**
 创建景深旋转动画，即具有透视效果的换轴旋转动画
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @param startAngle 旋转起始角度
 @param endAngle 旋转终止角度
 @param rotateAxis 旋转轴
 @param deep 景深系数
 @return 返回动画实例
 
 注：
 1.当content为nil时，开始动画需配合startAnimationWithContent:使用。
 2.旋转角度为角度制
 3.旋转轴为Z轴时无景深效果
 4.deep为景深系数，数值越小，透视效果越明显，反之效果更平缓，推荐值300
 
 eg.:
 self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"axisAnimation" beginTime:0 duration:2 rotateStartAngle:0 rotateEndAngle:-180 rotateAxis:X deep:300];
 
 */
-(instancetype)initAnimationWithContent:(id)content
                           animationKey:(NSString *)animationKey
                              beginTime:(CGFloat)beginTime
                               duration:(CGFloat)duration
                       rotateStartAngle:(CGFloat)startAngle
                         rotateEndAngle:(CGFloat)endAngle
                             rotateAxis:(Axis)rotateAxis
                                   deep:(CGFloat)deep;


/**
 创建拟合锚点改变动画，以曲线旋转动画拟合改变锚点后的旋转动画
 
 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @param startAngle 旋转起始角度
 @param endAngle 旋转终止角度
 @param anchor 拟合的改变后锚点
 @return 返回动画实例
 
 注：
 1.与上述Api不同，拟合动画需要预先接受Layer尺寸创建拟合曲线，故content不可为nil
 2.旋转角度为角度制
 3.实际锚点不发生改变，为拟合路径
 
 eg.:
 self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"arcAnimation" beginTime:2 duration:1 arcCenter:CGPointMake(self.view.center.x, self.view.center.y - 100) radius:200 startAngle:120 endAngle:60 clockwise:NO autoRotate:YES];
 
 */
-(instancetype)initAnimationWithContent:(id)content
                           animationKey:(NSString *)animationKey
                              beginTime:(CGFloat)beginTime
                               duration:(CGFloat)duration
                       rotateStartAngle:(CGFloat)startAngle
                         rotateEndAngle:(CGFloat)endAngle
                   simulateChangeAnchor:(CGPoint)anchor;

#pragma mark ---动画编辑方法---

/**
 拼接动画，在当前动画后拼接动画

 @param animation 将要组合的DWAnimation对象
 @param animationKey 组合后的动画的Key，可为nil或空，若为nil则以默认规则生成Key
 @return 返回动画实例
 
 注：拼接动画会改变调用对象及添加对象的beginTime，且具有累计效应。
 故参与添加动画后，仅返回的动画实例具有正确动画效果，调用对象和添加均不能正确展示。
 
 eg.:
 DWAnimation * ani1 = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.rotateTo(360).duration(2).install();
 }];
 
 DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"bgColor" animationCreater:^(DWAnimationMaker *maker) {
 maker.backgroundColorTo([UIColor blueColor]).duration(2).install();
 }];
 self.ani = [ani1 appendAnimation:ani2 animationKey:nil];
 
 */
-(DWAnimation *)appendAnimation:(DWAnimation *)animation
       animationKey:(NSString *)animationKey;


/**
 按顺序拼接数组中的所有动画

 @param animations DWAniamtion对象组成的数组
 @param animationKey 组合后的动画的Key，可为nil或空，若为nil则以默认规则生成Key
 @return 拼接完成的动画实例
 
 注：本方法会改变数组中动画的beginTime，且具有累积效应，故参与添加动画后，仅返回的动画实例具有正确动画效果，调用对象和添加均不能正确展示。
 
 eg.:
 DWAnimation * ani1 = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.rotateTo(360).duration(2).install();
 }];
 
 DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"bgColorAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.backgroundColorTo([UIColor blueColor]).duration(2).install();
 }];
 
 DWAnimation * ani3 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"moveAniamtion" animationCreater:^(DWAnimationMaker *maker) {
 maker.moveTo(CGPointMake(self.view.center.x, self.view.center.y - 100)).duration(2).install();
 }];
 
 self.ani = [DWAnimation createAnimationWithAnimations:@[ani1,ani2,ani3] animationKey:@"createAnimation"];
 
 */
+(DWAnimation *)createAnimationWithAnimations:(__kindof NSArray<DWAnimation *> *)animations
                                 animationKey:(NSString *)animationKey;


/**
 并发组合两个动画

 @param animation 将要组合的DWAnimation对象
 @param animationKey 组合后的动画的Key，可为nil或空，若为nil则以默认规则生成Key
 @return 组合后的动画实例
 
 注：组合后两动画并发执行
 若两动画中有相同动画属性且执行时间相同，则后者动作覆盖前者动作
 组合的动画的view应该为同一对象，否则返回自身
 若要实现不同view的动画并发执行，请调用DWAnimationManager中相关api
 
 eg.:
 DWAnimation * ani1 = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.rotateTo(360).duration(2).install();
 }];
 
 DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"bgColor" animationCreater:^(DWAnimationMaker *maker) {
 maker.backgroundColorTo([UIColor blueColor]).duration(2).install();
 }];
 self.ani = [ani1 combineWithAnimation:ani2 animationKey:nil];
 
 */
-(DWAnimation *)combineWithAnimation:(DWAnimation *)animation
                        animationKey:(NSString *)animationKey;


/**
 并发组合数组中的动画

 @param animations DWAniamtion对象组成的数组
 @param animationKey 组合后的动画的Key，可为nil或空，若为nil则以默认规则生成Key
 @return 组合后的动画实例
 
 注：组合后两动画并发执行
 若两动画中有相同动画属性且执行时间相同，则后者动作覆盖前者动作
 组合的动画的view应该为同一对象，否则返回自身
 若要实现不同view的动画并发执行，请调用DWAnimationManager中相关api
 
 eg.:
 DWAnimation * ani1 = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.rotateTo(360).duration(2).install();
 }];
 
 DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"bgColorAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.backgroundColorTo([UIColor blueColor]).duration(2).install();
 }];
 
 DWAnimation * ani3 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"moveAniamtion" animationCreater:^(DWAnimationMaker *maker) {
 maker.moveTo(CGPointMake(self.view.center.x, self.view.center.y - 100)).duration(2).install();
 }];
 
 self.ani = [DWAnimation combineAnimationsInArray:@[ani1,ani2,ani3] animationKey:nil];
 
 */
+(DWAnimation *)combineAnimationsInArray:(__kindof NSArray<DWAnimation *> *)animations
                            animationKey:(NSString *)animationKey;


/**
 创建恢复原状的动画

 @param content 将要展示动画的视图，可选类型，CALayer，UIView，nil
 @param animationKey 动画的标识，可为nil
 @param beginTime 动画延时时长
 @param duration 动画时长
 @return 恢复动画实例
 
 注：特殊属性动画不在恢复动画范围内，请自行恢复。恢复并不是倒放一遍动画，而是以最快捷的方式恢复初始状态，比如最开始旋转至365度，那么恢复时只反转5度
 
 eg.:
 DWAnimation * ani1 = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.rotateTo(360).duration(2).install();
 }];
 
 DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"bgColorAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.backgroundColorTo([UIColor blueColor]).duration(2).install();
 }];
 
 DWAnimation * ani3 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"moveAniamtion" animationCreater:^(DWAnimationMaker *maker) {
 maker.moveTo(CGPointMake(self.view.center.x, self.view.center.y - 100)).duration(2).install();
 }];
 
 DWAnimation * combine = [DWAnimation combineAnimationsInArray:@[ani1,ani2,ani3] animationKey:nil];
 DWAnimation * reset = [DWAnimation createResetAnimationWithContent:self.redView animationKey:@"resetAnimation" beginTime:0 duration:2];
 self.ani = [combine appendAnimation:reset animationKey:nil];
 
 */
+(DWAnimation *)createResetAnimationWithContent:(id)content
                                   animationKey:(NSString *)animationKey
                                      beginTime:(CGFloat)beginTime
                                       duration:(CGFloat)duration;


/**
 以content开始动画

 @param content content类型可为UIView或CALayer
 
 注：
 1.可更换DWAnimation对象的执行主体。
 非必须条件下不推荐更换DWAnimaion执行主体。
 2.拟合锚点改变动画的拟合路径由初始传入Layer的尺寸决定。
 若想改变主体，应保证改变后主题与初始尺寸相同，才能正确展示。
 
 eg.:
 DWAnimation * ani = [[DWAnimation alloc] initAnimationWithContent:nil animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
 maker.rotateTo(360).duration(2).install();
 }];
 [ani startAnimationWithContent:self.redView];
 
 */
-(void)startAnimationWithContent:(id)content;


/**
 为以贝塞尔曲线创建的移动动画添加时间间隔

 @param timeIntervals 时间间隔
 
 注：
 本方法非必须实现方法，若不实现，动画将按匀速执行
 若实现本方法，你需要传入正确的keyTimes，否则会造成动画显示异常。
 keyTimes元素个数为bezierPath的子路径数。
 keyTimes中每个元素即为bezierPath每条子路径的持续时间。
 keyTimes中所有元素之和应等于duration
 eg.    以
 [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)]
 创建的动画duration为6，keyTimes可传入下列形式 @[@1,@2,@1,@2]
 
 eg.:
 self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationType:(DWAnimationTypeBackgroundColor) animationKey:@"timeIntervalAnimation" beginTime:1 values:@[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor yellowColor],[UIColor redColor]] timeIntervals:@[@1,@2,@3,@1] transition:NO];
 [self.ani setTimeIntervals:@[@2,@2,@2,@2]];
 
 */
-(void)setTimeIntervals:(NSArray<NSNumber *> *)timeIntervals;

@end
