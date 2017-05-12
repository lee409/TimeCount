//
//  CustomDatePicker.h
//  DemoTimer
//
//  Created by pjd on 2017/5/12.
//  Copyright © 2017年 pjd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FetchTimeData)(NSDictionary *dic);

@interface CustomDatePicker : NSObject
+ (CustomDatePicker *)sharedManager;
@property (nonatomic, strong) UIDatePicker *currentDatePick;
@property (nonatomic, copy)FetchTimeData pop;

/**
 *  UIDatePicker时间
 *
 *  @param block block
 */
- (void)fetch:(FetchTimeData)block;

/**
 *  展示UIDatePicker控件
 *
 *  @param isShowDateOnly 服务器时间
 */
- (void)display:(BOOL)isShowDateOnly;
@end
