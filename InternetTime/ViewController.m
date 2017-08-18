//
//  ViewController.m
//  InternetTime
//
//  Created by MrXir on 2017/8/14.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "ViewController.h"

#import "NSDate+InternetDate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSDate internetDateWithURL:[NSURL URLWithString:@"http://www.baidu.com"] completion:^(NSDate *internetDate, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        } else {
            
            NSDate *localDate = [NSDate date];
            
            NSComparisonResult result = [localDate compare:internetDate];
            
            if (result == NSOrderedAscending) {
                
                NSTimeInterval interval = [internetDate timeIntervalSinceReferenceDate] - [localDate timeIntervalSinceReferenceDate];
                
                NSLog(@"系统时间[%@] 早于 网络时间[%@] %f 秒", localDate, internetDate, interval);
                
            } else if (result == NSOrderedDescending) {
                
                NSTimeInterval interval = [localDate timeIntervalSinceReferenceDate] - [internetDate timeIntervalSinceReferenceDate];
                
                NSLog(@"系统时间[%@] 晚于 网络时间[%@] %f 秒", localDate, internetDate, interval);
                
            } else {
                
                NSLog(@"系统时间[%@] 等于 网络时间[%@]", localDate, internetDate);
            }
            
        }
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
