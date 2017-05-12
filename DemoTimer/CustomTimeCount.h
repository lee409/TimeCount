//
//  CustomTimeCount.h
//  DemoTimer
//
//  Created by pjd on 2017/5/12.
//  Copyright © 2017年 pjd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTimeCount : NSObject
{
    NSTimer *_timer;
    NSUInteger _currentTime;
}
+ (CustomTimeCount *)sharedManager;

/**
 *  记录服务器时间
 *
 *  @param serverTime 服务器时间
 */
- (void)recordServerTime:(NSString *)serverTime;

/**
 *  获取设备时间
 *
 *  @return NSString 服务器时间+Timer计数时间
 */
- (NSString *)fetchDeviceTime;
@end
