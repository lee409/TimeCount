//
//  ViewController.m
//  DemoTimer
//
//  Created by pjd on 2017/5/12.
//  Copyright © 2017年 pjd. All rights reserved.
//

#import "ViewController.h"
#import "CustomDatePicker.h"
#import "CustomTimeCount.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(showDemo) withObject:nil afterDelay:5.f];
    //    [self showDatePicker];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDemo
{
    NSLog(@"Time+%@",[[CustomTimeCount sharedManager] fetchDeviceTime]);

    [[CustomDatePicker sharedManager] display:NO];
    
    [[CustomDatePicker sharedManager] fetch:^(NSDictionary *dic) {
        NSLog(@"dic%@",dic);
    }];
}

@end
