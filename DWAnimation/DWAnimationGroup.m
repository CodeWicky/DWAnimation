//
//  DWAnimationGroup.m
//  DWAnimation
//
//  Created by Wicky on 16/10/27.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWAnimationGroup.h"
#import "DWAnimation.h"

@interface DWAnimationGroup ()

@property (nonatomic ,assign) CGFloat actualDuration;

@property (nonatomic ,strong) NSMutableDictionary * beginTimes;

@property (nonatomic ,weak) DWAnimationAbstraction * firstAnimation;

@property (nonatomic ,weak) DWAnimationAbstraction * lastAnimation;

@end

@implementation DWAnimationGroup

-(instancetype)initWithAnimations:(__kindof NSArray<DWAnimationAbstraction *> *)animations {
    self = [super init];
    if (self) {
        self.animations = animations;
        [super setStatus:DWAnimationStatusReadyToShow];
    }
    return self;
}

-(void)setAnimations:(NSMutableArray<DWAnimation *> *)animations {
    _animations = animations;
    [self handleAnimationsInfo];
    [self handleActualDuration];
}

-(void)handleAnimationsInfo {
    __block CGFloat duration = 0;
    [self.beginTimes removeAllObjects];
    [self.animations enumerateObjectsUsingBlock:^(DWAnimationAbstraction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat actualDuration = [[obj valueForKey:@"actualDuration"] floatValue];
        
        if (actualDuration > duration) {
            duration = actualDuration;
            self.lastAnimation = obj;
        }
        
        if (!self.firstAnimation || self.firstAnimation.beginTime > obj.beginTime) {
            self.firstAnimation = obj;
        }
        
        [self.beginTimes setValue:@(obj.beginTime) forKey:[NSString stringWithFormat:@"%p",obj]];
    }];
    
    __weak typeof(self)weakSelf = self;
    DWAnimationCallback firstStart = self.firstAnimation.animationStart;
    self.firstAnimation.animationStart = ^(__kindof DWAnimationAbstraction *ani) {
        [super setStatus:DWAnimationStatusPlaying];
        if (weakSelf.animationStart) {
            weakSelf.animationStart(weakSelf);
        }
        if (firstStart) {
            firstStart(ani);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:DWAnimationPlayStartNotification object:@{@"animation":self}];
    };
    
    DWAnimationCallback lastCompletion = self.lastAnimation.completion;
    self.lastAnimation.completion = ^(__kindof DWAnimationAbstraction *ani) {
        if (weakSelf.completion) {
            weakSelf.completion(weakSelf);
        }
        if (lastCompletion) {
            lastCompletion(ani);
        }
        [super setStatus:DWAnimationStatusFinished];
        [[NSNotificationCenter defaultCenter] postNotificationName:DWAnimationPlayFinishNotification object:@{@"animation":self}];
    };
    
    self.duration = duration;
}

-(void)setBeginTime:(CGFloat)beginTime {
    [super setBeginTime:beginTime];
    [self handleActualDuration];
}

-(void)start {
    [self.animations enumerateObjectsUsingBlock:^(DWAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat beginTime = [[self.beginTimes valueForKey:[NSString stringWithFormat:@"%p",obj]] floatValue];
        obj.beginTime = beginTime + self.beginTime;
        [obj start];
    }];
}

-(void)resume {
    [self.animations enumerateObjectsUsingBlock:^(DWAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj resume];
    }];
    [super setStatus:DWAnimationStatusPlaying];
}

-(void)suspend {
    [self.animations enumerateObjectsUsingBlock:^(DWAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj suspend];
    }];
    [super setStatus:DWAnimationStatusSuspended];
}

-(void)remove {
    [self.animations enumerateObjectsUsingBlock:^(DWAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat beginTime = [[self.beginTimes valueForKey:[NSString stringWithFormat:@"%p",obj]] floatValue];
        obj.beginTime = beginTime;
        [obj remove];
    }];
    [super setStatus:DWAnimationStatusRemoved];
}

-(void)handleActualDuration {
    self.actualDuration = self.beginTime + self.duration;
}

-(NSMutableDictionary *)beginTimes {
    if (!_beginTimes) {
        _beginTimes = [NSMutableDictionary dictionary];
    }
    return _beginTimes;
}

@end
