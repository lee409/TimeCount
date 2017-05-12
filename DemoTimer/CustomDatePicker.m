//
//  CustomDatePicker.m
//  DemoTimer
//
//  Created by pjd on 2017/5/12.
//  Copyright © 2017年 pjd. All rights reserved.
//

#import "CustomDatePicker.h"

@implementation CustomDatePicker
static CustomDatePicker *shared_manager = nil;
+ (CustomDatePicker *)sharedManager {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (void)display:(BOOL)isShowDateOnly
{
    UIWindow *curWindow = [[UIApplication sharedApplication].windows lastObject];
    CGSize aFactSize = [[UIScreen mainScreen] bounds].size;
    
    UIView *bgView = [curWindow viewWithTag:20001];
    if(!bgView){
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, aFactSize.width, aFactSize.height)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.f;
        bgView.tag = 20001;
        [curWindow addSubview:bgView];
        [curWindow bringSubviewToFront:bgView];
        UITapGestureRecognizer *aTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeDatePickerView)];
        [aTapGestureRecognizer setNumberOfTapsRequired:1];
        [bgView addGestureRecognizer:aTapGestureRecognizer];
    }
    UIDatePicker *datePickerView = [curWindow viewWithTag:20002];
    
    if(!datePickerView){
        datePickerView = [[UIDatePicker alloc] init];
        datePickerView.tag = 20002;
        datePickerView.datePickerMode = isShowDateOnly?UIDatePickerModeDate:UIDatePickerModeDateAndTime;
        datePickerView.backgroundColor = [UIColor whiteColor];
        [datePickerView setFrame:CGRectMake(0, aFactSize.height, aFactSize.width, 188)];
        [datePickerView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
        shared_manager.currentDatePick = datePickerView;
        [curWindow addSubview:datePickerView];
    }
    [UIView animateWithDuration:.5 animations:^{
        bgView.alpha = 0.5f;
        [datePickerView setFrame:CGRectMake(0, aFactSize.height - 188, aFactSize.width, 188)];
    } completion:^(BOOL finished) {
    }];
}

- (void)removeDatePickerView
{
    UIWindow *curWindow = [UIApplication sharedApplication].keyWindow;
    CGSize aFactSize = [[UIScreen mainScreen] bounds].size;
    
    UIView *bgView = [curWindow viewWithTag:20001];
    
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = [curWindow bounds];
        [[curWindow viewWithTag:20002] setFrame:CGRectMake(0, rect.size.height, aFactSize.width, [curWindow viewWithTag:20002].frame.size.height)];
        bgView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [[curWindow viewWithTag:20002] removeFromSuperview];
        [bgView removeFromSuperview];
    }];
}

- (void)fetch:(FetchTimeData)block
{
    shared_manager.pop = block;
}

- (void)dateChanged
{
    NSDate *theDate = shared_manager.currentDatePick.date;
    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH-mm-ss";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    if(shared_manager.pop)
        shared_manager.pop(@{@"Time":[dateFormatter stringFromDate:theDate]});
}
@end
