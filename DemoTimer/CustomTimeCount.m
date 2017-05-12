//
//  CustomTimeCount.m
//  DemoTimer
//
//  Created by pjd on 2017/5/12.
//  Copyright © 2017年 pjd. All rights reserved.
//

#import "CustomTimeCount.h"

@implementation CustomTimeCount
static CustomTimeCount *shared_manager = nil;
+ (CustomTimeCount *)sharedManager {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

/**
 *  记录服务器时间
 *
 *  @param serverTime 服务器时间
 */
- (void)recordServerTime:(NSString *)serverTime
{
    /*记录服务器下发时间*/
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:serverTime forKey:@"ServerTime"];
    [ud synchronize];
    /*启动计时器*/
    [self countTimer];
}

/**
 *  获取设备时间
 *
 *  @return NSString 服务器时间+Timer计数时间
 */
- (NSString *)fetchDeviceTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSUInteger timeTemp = [[ud objectForKey:@"ServerTime"] integerValue]+_currentTime;
    return [NSString stringWithFormat:@"%ld",timeTemp];
}

/**
 *  NSTimer计数
 *
 */
- (void)countTimer
{
    _currentTime=0;
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerLogic) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  NSTimer执行函数
 *
 */
- (void)timerLogic
{
    _currentTime++;
    NSLog(@"_currentTime+%ld",(long)_currentTime);
}
@end
