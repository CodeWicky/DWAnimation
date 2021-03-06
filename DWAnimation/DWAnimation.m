//
//  DWAnimation.m
//  DWHUD
//
//  Created by Wicky on 16/8/20.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWAnimation.h"
#import "DWAnimationMaker.h"

#define IllegalContentReturnNil \
{\
if (content && ![content isKindOfClass:[UIView class]] && ![content isKindOfClass:[CALayer class]]) {\
NSAssert(NO, @"Illegal content type to initialize animation.Content should be kind of UIView or CALayer or nil.");\
return nil;\
}\
}

@interface DWAnimation ()<CAAnimationDelegate>

@property (nonatomic ,assign) CGFloat actualDuration;

@end

@implementation DWAnimation

#pragma mark ---接口方法---

#pragma mark ------构造方法------

///以block形式创建动画
-(instancetype)initAnimationWithContent:(id)content animationKey:(NSString *)animationKey animationCreater:(void(^)(DWAnimationMaker * maker))animationCreater {
    IllegalContentReturnNil
    if (self = [super init]) {
        _layer = layerFromContent(content);
        _animationKey = animationKey;
        _timingFunctionName = @"linear";
        [super setStatus:DWAnimationStatusReadyToShow];
        _repeatCount = 1;
        DWAnimationMaker * maker = [DWAnimationMaker new];
        maker.layer = self.layer;
        if (animationCreater) {
            animationCreater(maker);
        }
        [maker make];
        [super setDuration:maker.totalDuration];
        self.animation = maker.animation;
        self.animation.repeatCount = 1;
        [self handleActualDuration];
    }
    return self;
}

///以数组形式创建动画
-(instancetype)initAnimationWithContent:(id)content animationKey:(NSString *)animationKey beginTime:(CGFloat)beginTime duration:(CGFloat)duration animations:(__kindof NSArray<__kindof CAAnimation *> *)animations {
    IllegalContentReturnNil
    ///空数组返回空
    if (animations.count == 0) {
        return nil;
    }
    if (self = [super init]) {
        [super setBeginTime:beginTime];
        self.duration = duration;
        _layer = layerFromContent(content);
        _animationKey = animationKey;
        _timingFunctionName = @"linear";
        [super setStatus:DWAnimationStatusReadyToShow];
        _repeatCount = 1;
        
        ///只有一个对象则不需要动画组
        if (animations.count == 1) {
            self.animation = animations.firstObject;
            if (self.animation.repeatCount == 0) {
                self.animation.repeatCount = 1;
            }
            [self handleActualDuration];
            return self;
        }
        
        NSArray * arr = [animations sortedArrayUsingComparator:^NSComparisonResult(CAAnimation * ani1, CAAnimation * ani2) {
            if (ani1.beginTime > ani2.beginTime) {
                return NSOrderedDescending;
            } else if (ani1.beginTime < ani2.beginTime) {
                return NSOrderedAscending;
            } else {
                return NSOrderedSame;
            }
        }];
        
        CAAnimationGroup * group = [CAAnimationGroup animation];
        group.duration = duration;
        group.beginTime = beginTime;
        group.repeatCount = 1;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.animations = arr;
        self.animation = group;
        [self handleActualDuration];
    }
    return self;
}

///创建连续动画
-(instancetype)initAnimationWithContent:(id)content animationType:(DWAnimationType)animationType animationKey:(NSString *)animationKey beginTime:(CGFloat)beginTime values:(NSArray *)values timeIntervals:(NSArray *)timeIntervals transition:(BOOL)transtion {
    IllegalContentReturnNil
    CALayer * layer = layerFromContent(content);
    
    if (!((values.count - timeIntervals.count == 1) && timeIntervals.count)) {
        return nil;
    }
    
    NSString * type = nil;
    switch (animationType) {
        case DWAnimationTypeMove:
        {
            if (!allObjsIsKindOfClass(values,[NSValue class])) {
                return nil;
            }
            type = @"position";
            break;
        }
        case DWAnimationTypeScale:
        {
            if (!allObjsIsKindOfClass(values, [NSNumber class])) {
                return nil;
            }
            type = @"transform.scale";
            break;
        }
        case DWAnimationTypeRotate:
        {
            if (!allObjsIsKindOfClass(values, [NSNumber class])) {
                return nil;
            }
            NSMutableArray * arr = [NSMutableArray array];
            for (NSNumber * number in values) {
                [arr addObject:@RadianFromDegree(number.floatValue)];
            }
            values = [NSArray arrayWithArray:arr];
            type = @"transform.rotation";
            break;
        }
        case DWAnimationTypeAlpha:
        {
            if (!allObjsIsKindOfClass(values, [NSNumber class])) {
                return nil;
            }
            type = @"opacity";
            break;
        }
        case DWAnimationTypeCornerRadius:
        {
            if (!allObjsIsKindOfClass(values, [NSNumber class])) {
                return nil;
            }
            type = @"cornerRadius";
            break;
        }
        case DWAnimationTypeBorderColor:
        {
            if (!allObjsIsKindOfClass(values, [UIColor class])) {
                return nil;
            }
            NSMutableArray * arr = [NSMutableArray array];
            for (UIColor * color in values) {
                [arr addObject:(id)color.CGColor];
            }
            values = [NSArray arrayWithArray:arr];
            if (!layer.borderWidth) {
                layer.borderWidth = 3;
            }
            type = @"borderColor";
            break;
        }
        case DWAnimationTypeBorderWidth:
        {
            if (!allObjsIsKindOfClass(values, [NSNumber class])) {
                return nil;
            }
            type = @"borderWidth";
            break;
        }
        case DWAnimationTypeShadowColor:
        {
            if (!allObjsIsKindOfClass(values, [UIColor class])) {
                return nil;
            }
            NSMutableArray * arr = [NSMutableArray array];
            for (UIColor * color in values) {
                [arr addObject:(id)color.CGColor];
            }
            values = [NSArray arrayWithArray:arr];
            if (!layer.shadowOpacity) {
                layer.shadowOpacity = 0.5;
            }
            type = @"shadowColor";
            break;
        }
        case DWAnimationTypeShadowAlpha:
        {
            if (!allObjsIsKindOfClass(values, [NSNumber class])) {
                return nil;
            }
            type = @"shadowOpacity";
            break;
        }
        case DWAnimationTypeShadowOffset:
        {
            if (!allObjsIsKindOfClass(values, [NSValue class])) {
                return nil;
            }
            if (!layer.shadowOpacity) {
                layer.shadowOpacity = 0.5;
            }
            type = @"shadowOffset";
            break;
        }
        case DWAnimationTypeShadowCornerRadius:
        {
            if (!allObjsIsKindOfClass(values, [NSNumber class])) {
                return nil;
            }
            if (!layer.shadowOpacity) {
                layer.shadowOpacity = 0.5;
            }
            type = @"shadowRadius";
            break;
        }
        case DWAnimationTypeShadowPath:
        {
            if (!allObjsIsKindOfClass(values, [UIBezierPath class])) {
                return nil;
            }
            NSMutableArray * arr = [NSMutableArray array];
            for (UIBezierPath * path in values) {
                [arr addObject:(id)path.CGPath];
            }
            values = [NSArray arrayWithArray:arr];
            if (!layer.shadowOpacity) {
                layer.shadowOpacity = 0.5;
            }
            type = @"shadowPath";
            break;
        }
        case DWAnimationTypeBackgroundImage:
        {
            if (!allObjsIsKindOfClass(values, [UIImage class])) {
                return nil;
            }
            NSMutableArray * arr = [NSMutableArray array];
            for (UIImage * image in values) {
                [arr addObject:(id)image.CGImage];
            }
            values = [NSArray arrayWithArray:arr];
            type = @"contents";
            break;
        }
        case DWAnimationTypeBackgroundColor:
        {
            if (!allObjsIsKindOfClass(values, [UIColor class])) {
                return nil;
            }
            NSMutableArray * arr = [NSMutableArray array];
            for (UIColor * color in values) {
                [arr addObject:(id)color.CGColor];
            }
            values = [NSArray arrayWithArray:arr];
            type = @"backgroundColor";
            break;
        }
        default:
        {
            if (!allObjsIsKindOfClass(values, [NSNumber class])) {
                return nil;
            }
            type = @"position";
            break;
        }
    }
    __block CGFloat duration = 0;
    [timeIntervals enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        duration += [(NSNumber *)obj floatValue];
    }];
    NSMutableArray * arrTimes = [NSMutableArray arrayWithObject:@0];
    CGFloat numTemp = 0;
    for (NSNumber * number in timeIntervals) {
        numTemp += number.floatValue;
        [arrTimes addObject:[NSNumber numberWithFloat:numTemp / duration]];
    }
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:type];
    animation.duration = duration;
    animation.beginTime = beginTime;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.values = values;
    animation.keyTimes = arrTimes;
    if (transtion) {
        animation.calculationMode = kCAAnimationCubic;
    }
    return [self initAnimationWithContent:layer animationKey:animationKey beginTime:beginTime duration:duration animations:@[animation]];
}

///以贝尔塞曲线创建移动动画
-(instancetype)initAnimationWithContent:(id)content animationKey:(NSString *)animationKey
                           beginTime:(CGFloat)beginTime duration:(CGFloat)duration bezierPath:(UIBezierPath *)bezierPath autoRotate:(BOOL)autoRotate {
    IllegalContentReturnNil
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = duration;
    animation.beginTime = beginTime;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.path = bezierPath.CGPath;
    if (autoRotate) {
        animation.rotationMode = kCAAnimationRotateAuto;
    }
    return [self initAnimationWithContent:content animationKey:animationKey beginTime:beginTime duration:duration animations:@[animation]];
}

///创建弧线动画
-(instancetype)initAnimationWithContent:(id)content animationKey:(NSString *)animationKey beginTime:(CGFloat)beginTime duration:(CGFloat)duration arcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise autoRotate:(BOOL)autoRotate {
    IllegalContentReturnNil
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:RadianFromDegree(startAngle) endAngle:RadianFromDegree(endAngle) clockwise:clockwise];
    return [self initAnimationWithContent:content animationKey:animationKey beginTime:beginTime duration:duration bezierPath:path autoRotate:autoRotate];
}

///创建震荡动画
-(instancetype)initAnimationWithContent:(id)content animationKey:(NSString *)animationKey springingType:(DWAnimationSpringType)springingType beginTime:(CGFloat)beginTime fromValue:(id)fromValue toValue:(id)toValue mass:(CGFloat)mass stiffness:(CGFloat)stiffness damping:(CGFloat)damping initialVelocity:(CGFloat)initialVelocity {
    IllegalContentReturnNil
    CALayer * layer = layerFromContent(content);
    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(9.0)) {
        return nil;
    }
    if (!toValue) {
        return nil;
    }
    NSString * key = nil;
    switch (springingType) {
        case DWAnimationSpringTypeMove:
            key = @"position";
            break;
        case DWAnimationSpringTypeScale:
            key = @"transform.scale";
            break;
        case DWAnimationSpringTypeRotate:
            key = @"transform.rotation";
            break;
        case DWAnimationSpringTypeAlpha:
            key = @"opacity";
            break;
        case DWAnimationSpringTypeCornerRadius:
        {
            key = @"cornerRadius";
            layer.masksToBounds = YES;
            break;
        }
        case DWAnimationSpringTypeBorderColor:
            key = @"borderColor";
            break;
        case DWAnimationSpringTypeBorderWidth:
            key = @"borderWidth";
            break;
        case DWAnimationSpringTypeShadowColor:
            key = @"shadowColor";
            break;
        case DWAnimationSpringTypeShadowOffset:
            key = @"shadowOffset";
            break;
        case DWAnimationSpringTypeShadowAlpha:
            key = @"shadowOpacity";
            break;
        case DWAnimationSpringTypeShadowCornerRadius:
            key = @"shadowRadius";
            break;
        case DWAnimationSpringTypeShadowPath:
            key = @"shadowPath";
            break;
        case DWAnimationSpringTypeBackgroundImage:
            key = @"contents";
            break;
        case DWAnimationSpringTypeBackgroundColor:
            key = @"backgroundColor";
            break;
        default:
            key = @"position";
            break;
    }
    if ((springingType == DWAnimationSpringTypeMove || springingType == DWAnimationSpringTypeShadowOffset) && ((![toValue isKindOfClass:[NSValue class]]) || ((fromValue) && (![fromValue isKindOfClass:[NSValue class]])))){
        return nil;
    }
    if ((springingType == DWAnimationSpringTypeRotate || springingType == DWAnimationSpringTypeScale || springingType == DWAnimationSpringTypeAlpha || springingType == DWAnimationSpringTypeCornerRadius || springingType == DWAnimationSpringTypeBorderWidth || springingType == DWAnimationSpringTypeShadowAlpha || springingType == DWAnimationSpringTypeShadowCornerRadius) && ((![toValue isKindOfClass:[NSNumber class]]) || ((fromValue) && (![fromValue isKindOfClass:[NSNumber class]])))){
        return nil;
    }
    if ((springingType == DWAnimationSpringTypeBorderColor || springingType== DWAnimationSpringTypeShadowColor || springingType == DWAnimationSpringTypeBackgroundColor)  && ((![toValue isKindOfClass:[UIColor class]]) || ((fromValue) && (![fromValue isKindOfClass:[UIColor class]])))){
        return nil;
    }
    if ((springingType == DWAnimationSpringTypeShadowPath)  && ((![toValue isKindOfClass:[UIBezierPath class]]) || ((fromValue) && (![fromValue isKindOfClass:[UIBezierPath class]])))) {
        return nil;
    }
    if ((springingType == DWAnimationSpringTypeBackgroundImage) && ((![toValue isKindOfClass:[UIImage class]]) || ((fromValue) && (![fromValue isKindOfClass:[UIImage class]])))) {
        return nil;
    }
    CASpringAnimation * animation = [CASpringAnimation animationWithKeyPath:key];
    animation.beginTime = beginTime;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.mass = mass;
    animation.stiffness = stiffness;
    animation.damping = damping;
    animation.initialVelocity = initialVelocity;
    animation.duration = animation.settlingDuration;
    if (springingType == DWAnimationSpringTypeBackgroundImage && !fromValue) {
        fromValue = UIImageNull;
    }
    if (springingType == DWAnimationSpringTypeShadowPath && !fromValue) {
        fromValue = UIBezierPathNull(layer.bounds.size.width, layer.bounds.size.height);
    }
    if (springingType == DWAnimationSpringTypeShadowOffset && !fromValue) {
        fromValue = [NSValue valueWithCGSize:CGSizeNull];
    }    
    switch (springingType) {
        case DWAnimationSpringTypeMove:
        case DWAnimationSpringTypeShadowOffset:
        {
            if (springingType == DWAnimationSpringTypeMove) {
                CGPoint point = [(NSValue *)toValue CGPointValue];
                if (!CGPointIsNull((point))) {
                    animation.toValue = toValue;
                } else {
                    return nil;
                }
                if (fromValue) {
                    point = [(NSValue *)fromValue CGPointValue];
                    if (!CGPointIsNull((point))) {
                        animation.fromValue = fromValue;
                    }
                }
            } else {
                CGSize size = [(NSValue *)toValue CGSizeValue];
                if (!CGSizeIsNull(size)) {
                    animation.toValue = toValue;
                    if (!layer.shadowOpacity) {
                        layer.shadowOpacity = 0.5;
                    }
                } else {
                    return nil;
                }
                if (fromValue) {
                    size = [(NSValue *)fromValue CGSizeValue];
                    if (!CGSizeIsNull(size)) {
                        animation.fromValue = fromValue;
                    }
                }
            }
            break;
        }
        case DWAnimationSpringTypeRotate:
        case DWAnimationSpringTypeScale:
        case DWAnimationSpringTypeAlpha:
        case DWAnimationSpringTypeCornerRadius:
        case DWAnimationSpringTypeBorderWidth:
        case DWAnimationSpringTypeShadowAlpha:
        case DWAnimationSpringTypeShadowCornerRadius:
        {
            CGFloat num = [(NSNumber *)toValue floatValue];
            if (!CGFloatIsNull(num)) {
                if (springingType == DWAnimationSpringTypeRotate) {
                    toValue = @(RadianFromDegree(num));
                }
                if (springingType == DWAnimationSpringTypeAlpha || springingType == DWAnimationSpringTypeShadowAlpha) {
                    if (num > 1) {
                        num = 1;
                        toValue = @(num);
                    }
                    if (num < 0) {
                        num = 0;
                        toValue = @(num);
                    }
                }
                if ((springingType == DWAnimationSpringTypeShadowAlpha || springingType == DWAnimationSpringTypeShadowCornerRadius) && !layer.shadowOpacity) {
                    layer.shadowOpacity = 0.5;
                }
                animation.toValue = toValue;
            } else {
                return nil;
            }
            if (fromValue) {
                num = [(NSNumber *)fromValue floatValue];
                if (!CGFloatIsNull(num)) {
                    if (springingType == DWAnimationSpringTypeRotate) {
                        fromValue = @(RadianFromDegree(num));
                    }
                    if (springingType == DWAnimationSpringTypeAlpha || springingType == DWAnimationSpringTypeShadowAlpha) {
                        if (num > 1) {
                            num = 1;
                            fromValue = @(num);
                        }
                        if (num < 0) {
                            num = 0;
                            fromValue = @(num);
                        }
                    }
                    animation.fromValue = fromValue;
                }
            }
            break;
        }
        case DWAnimationSpringTypeBorderColor:
        case DWAnimationSpringTypeShadowColor:
        case DWAnimationSpringTypeBackgroundColor:
        {
            UIColor * toColor = (UIColor *)toValue;
            animation.toValue = (id)toColor.CGColor;
            if (springingType == DWAnimationSpringTypeBorderColor && !layer.borderWidth) {
                layer.borderWidth = 3;
            }
            if (springingType == DWAnimationSpringTypeShadowColor && !layer.shadowOpacity) {
                layer.shadowOpacity = 0.5;
            }
            if (fromValue) {
                UIColor * fromColor = (UIColor *)fromValue;
                animation.fromValue = (id)fromColor.CGColor;
            }
            break;
        }
        case DWAnimationSpringTypeShadowPath:
        {
            UIBezierPath * toPath = (UIBezierPath *)toValue;
            animation.toValue = (id)toPath.CGPath;
            if (springingType == DWAnimationSpringTypeShadowPath && !layer.shadowOpacity) {
                layer.shadowOpacity = 0.5;
            }
            if (fromValue) {
                UIBezierPath * fromPath = (UIBezierPath *)fromValue;
                animation.fromValue = (id)fromPath.CGPath;
            }
            break;
        }
        case DWAnimationSpringTypeBackgroundImage:
        {
            UIImage * toImage = (UIImage *)toValue;
            animation.toValue = (id)toImage.CGImage;
            if (fromValue) {
                UIImage * fromImage = (UIImage *)fromValue;
                animation.fromValue = (id)fromImage.CGImage;
            }
            break;
        }
        default:
            break;
    }    
    return [self initAnimationWithContent:layer animationKey:animationKey beginTime:beginTime duration: animation.duration animations:@[animation]];
}

///创建特殊属性动画
-(instancetype)initAnimationWithContent:(id)content keyPath:(NSString *)keyPath animationKey:(NSString *)animationKey beginTime:(CGFloat)beginTime duration:(CGFloat)duration fromValue:(id)fromValue toValue:(id)toValue timingFunctionName:(NSString *)timingFunctionName {
    IllegalContentReturnNil
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.duration = duration;
    animation.beginTime = beginTime;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    if (fromValue) {
        animation.fromValue = fromValue;
    }
    animation.toValue = toValue;
    if (timingFunctionName.length) {
        animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    }
    return [self initAnimationWithContent:content animationKey:animationKey beginTime:beginTime duration:duration animations:@[animation]];
}

///创建景深旋转动画
-(instancetype)initAnimationWithContent:(id)content animationKey:(NSString *)animationKey beginTime:(CGFloat)beginTime duration:(CGFloat)duration rotateStartAngle:(CGFloat)startAngle rotateEndAngle:(CGFloat)endAngle rotateAxis:(Axis)rotateAxis deep:(CGFloat)deep {
    IllegalContentReturnNil
    if (rotateAxis == Z) {
        return [self initAnimationWithContent:content animationKey:animationKey animationCreater:^(DWAnimationMaker *maker) {
            maker.rotateFrom(startAngle).rotateTo(endAngle).beginTime(beginTime).duration(duration).install();
        }];
    } else {
        CATransform3D fromValue = CATransform3DIdentity;
        fromValue.m34 = -1.f / deep;
        CATransform3D toValue = CATransform3DIdentity;
        toValue.m34 = -1.f / deep;
        if (rotateAxis == X) {
            fromValue = CATransform3DRotate(fromValue, RadianFromDegree(startAngle), 1, 0, 0);
            toValue = CATransform3DRotate(toValue, RadianFromDegree(endAngle), 1, 0, 0);
        } else {
            fromValue = CATransform3DRotate(fromValue, RadianFromDegree(startAngle), 0, 1, 0);
            toValue = CATransform3DRotate(toValue, RadianFromDegree(endAngle), 0, 1, 0);
        }
        return [self initAnimationWithContent:content keyPath:@"transform" animationKey:animationKey beginTime:beginTime duration:duration fromValue:[NSValue valueWithCATransform3D:fromValue] toValue:[NSValue valueWithCATransform3D:toValue] timingFunctionName:kCAMediaTimingFunctionLinear];
    }
}

///创建拟合锚点移动的旋转动画
-(instancetype)initAnimationWithContent:(id)content animationKey:(NSString *)animationKey beginTime:(CGFloat)beginTime duration:(CGFloat)duration rotateStartAngle:(CGFloat)startAngle rotateEndAngle:(CGFloat)endAngle simulateChangeAnchor:(CGPoint)anchor {
    IllegalContentReturnNil
    if (!content) {
        NSAssert(NO, @"SimulateChangeAnchor Animation Can't initialize with nil content!");
        return nil;
    }
    DWAnimation * ro = [self initAnimationWithContent:content animationKey:animationKey animationCreater:^(DWAnimationMaker *maker) {
        maker.rotateFrom(startAngle).rotateTo(endAngle).beginTime(beginTime).duration(duration).install();
    }];
    if (CGPointEqualToPoint(anchor, CGPointMake(0.5, 0.5)) || endAngle == startAngle) {
        return ro;
    }
    CALayer * layer = layerFromContent(content);
    CGFloat offsetX = layer.bounds.size.width * (anchor.x - 0.5);
    CGFloat offsetY = layer.bounds.size.height * (anchor.y - 0.5);
    CGFloat radius = sqrtf(powf(offsetX, 2) + powf(offsetY, 2));
    CGPoint center = CGPointMake(layer.position.x + offsetX, layer.position.y + offsetY);
    CGFloat deltaAngle = 0;
    if (anchor.x == 0.5) {
        if (anchor.y < 0.5) {
            deltaAngle = M_PI_2;
        }
        else
        {
            deltaAngle = M_PI_2 * 3;
        }
    }
    else
    {
        deltaAngle = atan2(- offsetY, - offsetX);
    }
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:RadianFromDegree(startAngle) + deltaAngle endAngle:RadianFromDegree(endAngle) + deltaAngle clockwise:endAngle>startAngle];
    
    DWAnimation * trans = [[DWAnimation alloc] initAnimationWithContent:layer animationKey:animationKey beginTime:beginTime duration:duration bezierPath:path autoRotate:NO];
    
    return [ro combineWithAnimation:trans animationKey:animationKey];
}

#pragma mark ------动画控制方法------
///开始播放动画
-(void)start {
    if (self.layer && self.repeatCount > 0) {
        if (self.status == DWAnimationStatusReadyToShow || self.status == DWAnimationStatusRemoved || self.status == DWAnimationStatusFinished) {
            self.animation.delegate = self;
            self.animation.beginTime = CACurrentMediaTime() + self.beginTime - self.layer.beginTime;
            [self.layer addAnimation:self.animation forKey:self.animationKey];
        }
    }
}

///暂停动画
-(void)suspend {
    if (self.status == DWAnimationStatusPlaying) {
        CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.layer.speed = 0.0;
        self.layer.timeOffset = pausedTime;
        [super setStatus:DWAnimationStatusSuspended];
    }
}

///恢复动画
-(void)resume {
    if (self.status == DWAnimationStatusSuspended) {
        CFTimeInterval pausedTime = self.layer.timeOffset;
        self.layer.speed = 1.0;
        self.layer.timeOffset = 0.0;
        self.layer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.layer.beginTime = timeSincePause;
        [super setStatus:DWAnimationStatusPlaying];
    }
}

///移除动画
-(void)remove {
    if (self.status != DWAnimationStatusRemoved) {
        self.repeatCount = 0;
        [self.layer removeAnimationForKey:self.animationKey];
        [super setStatus:DWAnimationStatusRemoved];
    }
}

#pragma mark ------动画编辑方法------

///拼接两个动画
-(DWAnimation *)appendAnimation:(DWAnimation *)animation animationKey:(NSString *)animationKey {
    CALayer * layer = self.layer;
    if (![layer isEqual:animation.layer]) {
        return self;
    }
    CGFloat beginTime = self.actualDuration;
    if (animationKey == nil || animationKey.length == 0) {
        animationKey = [NSString stringWithFormat:@"(%@_ADD_%@)",self.animationKey,animation.animationKey];
    }
    CGFloat duration = beginTime + animation.actualDuration;
    animation.beginTime += beginTime;
    NSMutableArray * arr = [NSMutableArray array];
    [arr addObject:self.animation];
    [arr addObject:animation.animation];
    return [[DWAnimation alloc] initAnimationWithContent:layer animationKey:animationKey beginTime:0 duration:duration animations:arr];
}

///按顺序拼接数组中的所有动画
+(DWAnimation *)createAnimationWithAnimations:(__kindof NSArray<DWAnimation *> *)animations animationKey:(NSString *)animationKey {
    int count = (int)animations.count;
    if (!count) {
        return nil;
    }
    if (count == 1) {
        return animations.firstObject;
    }
    
    CALayer * layer = animations.firstObject.layer;
    NSMutableArray * tmp = [NSMutableArray arrayWithCapacity:animations.count];
    __block CGFloat duration = 0;
    __block NSString * key = nil;
    BOOL buildKey = !animationKey || !animationKey.length;
    
    [animations enumerateObjectsUsingBlock:^(DWAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.animation && [layer isEqual:obj.layer]) {
            obj.beginTime += duration;
            duration = obj.actualDuration;
            [tmp addObject:obj.animation];
            if (buildKey) {
                if (!key) {
                    key = obj.animationKey;
                } else {
                    key = [NSString stringWithFormat:@"(%@_ADD_%@)",key,obj.animationKey];
                }
            }
        }
    }];
    
    if (buildKey) {
        animationKey = key;
    }
    
    return [[DWAnimation alloc] initAnimationWithContent:layer animationKey:animationKey beginTime:0 duration:duration animations:tmp];
}

-(void)startAnimationWithContent:(id)content {
    self.layer = layerFromContent(content);
    [self start];
}

///并发组合两个动画
-(DWAnimation *)combineWithAnimation:(DWAnimation *)animation animationKey:(NSString *)animationKey {
    if (![self.layer isEqual:animation.layer]) {
        return self;
    }
    NSMutableArray * arr = [NSMutableArray array];
    [arr addObject:self.animation];
    [arr addObject:animation.animation];
    CGFloat duration = MAX(self.actualDuration, animation.actualDuration);
    if (animationKey == nil || animationKey.length == 0) {
        animationKey = [NSString stringWithFormat:@"(%@_COMBINE_%@)",self.animationKey,animation.animationKey];
    }
    return [[DWAnimation alloc] initAnimationWithContent:self.layer animationKey:animationKey beginTime:0 duration:duration animations:arr];
}

///并发组合数组中的动画
+(DWAnimation *)combineAnimationsInArray:(__kindof NSArray<DWAnimation *> *)animations animationKey:(NSString *)animationKey {
    int count = (int)animations.count;
    if (!count) {
        return nil;
    }
    if (count == 1) {
        return animations.firstObject;
    }
    
    CALayer * layer = animations.firstObject.layer;
    NSMutableArray * tmp = [NSMutableArray arrayWithCapacity:animations.count];
    __block CGFloat duration = 0;
    __block NSString * key = nil;
    BOOL buildKey = !animationKey || !animationKey.length;
    [animations enumerateObjectsUsingBlock:^(DWAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.animation && [obj.layer isEqual:layer]) {
            duration = MAX(duration, obj.actualDuration);
            [tmp addObject:obj.animation];
            if (buildKey) {
                if (!key) {
                    key = obj.animationKey;
                } else {
                    key = [NSString stringWithFormat:@"(%@_COMBINE_%@)",key,obj.animationKey];
                }
            }
        }
    }];
    
    if (buildKey) {
        animationKey = key;
    }
    
    return [[DWAnimation alloc] initAnimationWithContent:layer animationKey:animationKey beginTime:0 duration:duration animations:tmp];
}

///创建恢复动画
+(DWAnimation *)createResetAnimationWithContent:(id)content animationKey:(NSString *)animationKey beginTime:(CGFloat)beginTime duration:(CGFloat)duration {
    if (animationKey == nil || animationKey.length == 0) {
        animationKey = @"resetAnimation";
    }
    return [[DWAnimation alloc] initAnimationWithContent:(id)content animationKey:animationKey animationCreater:^(DWAnimationMaker *maker) {
        maker.reset.beginTime(beginTime).duration(duration).install();
    }];
}

///为以贝塞尔曲线创建的动画的每段子路径设置时间
-(void)setTimeIntervals:(NSArray<NSNumber *> *)timeIntervals {
    
    if (![self.animation isKindOfClass:[CAKeyframeAnimation class]]) {
        return;
    }
    
    NSMutableArray * arr = [NSMutableArray arrayWithArray:@[@0]];
    __block float duration = 0;
    [timeIntervals enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        duration += obj.floatValue;
    }];
    __block float time = 0;
    [timeIntervals enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        time += obj.floatValue;
        [arr addObject:@(time / duration)];
    }];
    CAKeyframeAnimation * animation =(CAKeyframeAnimation *)self.animation;
    animation.keyTimes = arr;
}

#pragma mark ---animation代理---

-(void)animationDidStart:(CAAnimation *)anim {
    [super setStatus:DWAnimationStatusPlaying];
    if (self.animationStart) {
        self.animationStart(self);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:DWAnimationPlayStartNotification object:@{@"animation":self}];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.completion) {
        self.completion(self);
    }
    [super setStatus:DWAnimationStatusFinished];
    [[NSNotificationCenter defaultCenter] postNotificationName:DWAnimationPlayFinishNotification object:@{@"animation":self,@"finished":@(flag)}];
}

#pragma mark ---setter、getter---

-(void)setBeginTime:(CGFloat)beginTime {
    if (self.beginTime != beginTime) {
        [super setBeginTime:beginTime];
        self.animation.beginTime = beginTime;
        [self handleActualDuration];
    }
}

-(void)setDuration:(CGFloat)duration {
    if (self.duration != duration) {
        [super setDuration:duration];
        self.animation.duration = duration;
        [self handleActualDuration];
    }
}

-(void)setRepeatCount:(CGFloat)repeatCount {
    if (_repeatCount != repeatCount) {
        _repeatCount = repeatCount;
        self.animation.repeatCount = repeatCount;
        [self handleActualDuration];
    }
}

-(void)setTimingFunctionName:(NSString *)timingFunctionName {
    _timingFunctionName = timingFunctionName;
    self.animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
}

#pragma mark --- inline func ---
NS_INLINE CALayer * layerFromContent(id content) {
    if ([content isKindOfClass:[UIView class]]) {
        return [content layer];
    } else if ([content isKindOfClass:[CALayer class]]) {
        return content;
    }
    return nil;
}

NS_INLINE BOOL allObjsIsKindOfClass(NSArray * objs,Class clazz) {
    for (id object in objs) {
        BOOL result = [object isKindOfClass:clazz];
        if (!result) {
            return NO;
        }
    }
    return YES;
}

#pragma mark --- tool method ---
-(void)handleActualDuration {
    self.actualDuration = self.animation.beginTime + self.animation.duration * self.animation.repeatCount;
}
@end
