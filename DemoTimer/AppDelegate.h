//
//  AppDelegate.h
//  DemoTimer
//
//  Created by pjd on 2017/5/12.
//  Copyright © 2017年 pjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSTimer *_timer;
    NSUInteger _currentTime;
}
@property (strong, nonatomic) UIWindow *window;


@end

