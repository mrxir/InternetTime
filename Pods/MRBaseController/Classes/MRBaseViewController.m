//
//  MRBaseViewController.m
//  MRBaseController
//
//  Created by MrXir on 2017/6/29.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "MRBaseViewController.h"

@interface MRBaseViewController ()

@end

@implementation MRBaseViewController

#pragma mark - controllers life cycle

- (void)dealloc
{
    [self removeObservers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self removeObservers];
    [self addObservers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _viewDisplaying = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _viewDisplaying = NO;
}

#pragma mark - application life cycle

- (void)appWillTerminate
{
    NSLog(@"%s - %@", __FUNCTION__, self);
}

- (void)appWillActive
{
    NSLog(@"%s - %@", __FUNCTION__, self);
}

- (void)appDidActive
{
    NSLog(@"%s - %@", __FUNCTION__, self);
}

- (void)appWillInactive
{
    NSLog(@"%s - %@", __FUNCTION__, self);
}

- (void)appDidInactive
{
    NSLog(@"%s - %@", __FUNCTION__, self);
}

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"!"]) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - orientation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (idiom == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

#pragma mark - extension

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self.view endEditing:YES];
}

#pragma mark - application notification handle

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dispatchEventsWithNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dispatchEventsWithNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dispatchEventsWithNotification:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dispatchEventsWithNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)removeObservers
{
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

- (void)dispatchEventsWithNotification:(NSNotification *)notification
{
    if (self.isViewDisplaying) {
        
        NSString *name = notification.name;
        
        if ([UIApplicationWillEnterForegroundNotification isEqualToString:name]) {
            [self appWillActive];
        } else if ([UIApplicationDidBecomeActiveNotification isEqualToString:name]) {
            [self appDidActive];
        } else if ([UIApplicationWillResignActiveNotification isEqualToString:name]) {
            [self appWillInactive];
        } else if ([UIApplicationDidEnterBackgroundNotification isEqualToString:name]) {
            [self appDidInactive];
        }
        
    }
}

@end
