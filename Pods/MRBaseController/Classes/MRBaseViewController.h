//
//  MRBaseViewController.h
//  MRBaseController
//
//  Created by MrXir on 2017/6/29.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRBaseViewController : UIViewController

@property (nonatomic, readonly, getter=isViewDisplaying) BOOL viewDisplaying;

#pragma mark - controllers life cycle

- (void)dealloc;

- (void)viewDidLoad;

- (void)viewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)viewDidDisappear:(BOOL)animated;

#pragma mark - applications life cycle

- (void)appWillTerminate;

- (void)appWillActive;

- (void)appDidActive;

- (void)appWillInactive;

- (void)appDidInactive;

@end
