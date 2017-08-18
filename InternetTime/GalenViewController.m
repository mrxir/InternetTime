//
//  GalenViewController.m
//  InternetTime
//
//  Created by MrXir on 2017/8/14.
//  Copyright © 2017年 MrXir. All rights reserved.
//

#import "GalenViewController.h"

#import "LOL.h"

#import <MRUIKit.h>

#import "SUMMONER+CoreDataClass.h"

@interface GalenViewController ()

@property (nonatomic, strong) LOL *lol;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign, getter=isTimerRunning) BOOL timerRunning;

@property (nonatomic, weak) IBOutlet UIButton *qButton;
@property (nonatomic, weak) IBOutlet UIButton *wButton;
@property (nonatomic, weak) IBOutlet UIButton *eButton;
@property (nonatomic, weak) IBOutlet UIButton *rButton;

@property (nonatomic, strong) SUMMONER *galen;

@property (nonatomic, assign) NSTimeInterval cdQ;
@property (nonatomic, assign) NSTimeInterval cdW;
@property (nonatomic, assign) NSTimeInterval cdE;
@property (nonatomic, assign) NSTimeInterval cdR;

@end

@implementation GalenViewController

#pragma mark - controllers life cycle

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
    
    SUMMONER *galen = [self.lol summoner_recent];

    if (galen != nil) {
        NSLog(@"%@: 我去吃个饭先...", galen.nickname);
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.lol = [[LOL alloc] initWithFolderName:@"LOL" fileName:@"SUMMONER.sqlite" modelName:@"SUMMONER"];
        
        SUMMONER *galen = [self.lol summoner_recent];

        if (!galen) {
            galen = [self.lol summoner_instance];
            
            galen.nickname = @"德玛西亚之力";
            galen.realname = @"盖伦";
            
            galen.nameQ = @"致命打击";
            galen.nameW = @"勇气";
            galen.nameE = @"审判";
            galen.nameR = @"德玛西亚正义";
            
            galen.cdQ = 12;
            galen.cdW = 30;
            galen.cdE = 15;
            galen.cdR = 140;
            
            galen.level = 18;
            
            galen.magicResistance = 300;
            galen.physicalResistanc = 300;
            
            if ([self.lol saveContext:nil]) {
                NSLog(@"%@: 人在塔在", galen.nickname);
            } else {
                NSLog(@"%@: 对不起, 我还没准备好", galen.nickname);
            }
            
        } else {
            NSLog(@"%@: 我又回来啦!", galen.nickname);
        }
        
        self.galen = galen;
        self.galen.lol = self.lol;
        
    }
    
    return self;
}

- (void)revertSkillStatus
{
    NSLog(@"%s", __FUNCTION__);
    
    __weak typeof(self) _self = self;
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    
    _self.cdQ = MAX(0, _self.galen.cdQ - (now - _self.galen.timestampQ));
    _self.cdW = MAX(0, _self.galen.cdW - (now - _self.galen.timestampW));
    _self.cdE = MAX(0, _self.galen.cdE - (now - _self.galen.timestampE));
    _self.cdR = MAX(0, _self.galen.cdR - (now - _self.galen.timestampR));
    
    [self refreshSkillStatus:_self.timer];
    
    if (!_self.timer) {
        _self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [_self refreshSkillStatus:timer];
        }];
        _timerRunning = YES;
    }
    
}

- (void)refreshSkillStatus:(NSTimer *)timer
{
    
    // Q
    if (self.cdQ > 0.5) {
        
        NSLog(@"🌀 Q %@ 冷却 %f", self.galen.nameQ, self.cdQ);
        
        [self.qButton setTitle:[NSString stringWithFormat:@"%@ %.0f", self.galen.nameQ, self.cdQ] forState:UIControlStateNormal];
        
        self.cdQ = MAX(0, self.cdQ - 1.0f);
        
    } else {
        
        NSLog(@"✅ Q %@ 就绪", self.galen.nameQ);
        
        [self.qButton setTitle:[NSString stringWithFormat:@"Q %@ 就绪", self.galen.nameQ] forState:UIControlStateNormal];
        
    }
    
    // W
    if (self.cdW > 0.5) {
        
        NSLog(@"🌀 W %@ 冷却 %f", self.galen.nameW, self.cdW);
        
        [self.wButton setTitle:[NSString stringWithFormat:@"%@ %.0f", self.galen.nameW, self.cdW] forState:UIControlStateNormal];
        
        self.cdW = MAX(0, self.cdW - 1.0f);
        
    } else {
        
        NSLog(@"✅ W %@ 就绪", self.galen.nameW);
        
        [self.wButton setTitle:[NSString stringWithFormat:@"W %@ 就绪", self.galen.nameW] forState:UIControlStateNormal];
        
    }
    
    // E
    if (self.cdE > 0.5) {
        
        NSLog(@"🌀 E %@ 冷却 %f", self.galen.nameE, self.cdE);
        
        [self.eButton setTitle:[NSString stringWithFormat:@"%@ %.0f", self.galen.nameE, self.cdE] forState:UIControlStateNormal];
        
        self.cdE = MAX(0, self.cdE - 1.0f);
        
    } else {
        
        NSLog(@"✅ E %@ 就绪", self.galen.nameW);
        
        [self.eButton setTitle:[NSString stringWithFormat:@"E %@ 就绪", self.galen.nameE] forState:UIControlStateNormal];
        
    }
    
    // R
    if (self.cdR > 0.5) {
        
        NSLog(@"🌀 R %@ 冷却 %f", self.galen.nameR, self.cdR);
        
        [self.rButton setTitle:[NSString stringWithFormat:@"%@ %.0f", self.galen.nameR, self.cdR] forState:UIControlStateNormal];
        
        self.cdR = MAX(0, self.cdR - 1.0f);
        
    } else {
        
        NSLog(@"✅ R %@ 就绪", self.galen.nameR);
        
        [self.rButton setTitle:[NSString stringWithFormat:@"R %@ 就绪", self.galen.nameR] forState:UIControlStateNormal];
        
    }
    
}

- (void)countDown
{
    if (!self.isTimerRunning) {
        [self.timer setFireDate:[NSDate distantPast]];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) _self = self;
    
    [self revertSkillStatus];
    
    [self.qButton handleWithEvents:UIControlEventTouchUpInside completion:^(__kindof UIControl *control) {
        [_self.galen Q:^(BOOL success) {
            if (success) {
                _self.cdQ = _self.galen.cdQ;
                [_self countDown];
            }
            
        }];
    }];
    
    [self.wButton handleWithEvents:UIControlEventTouchUpInside completion:^(__kindof UIControl *control) {
        [_self.galen W:^(BOOL success) {
            if (success) {
                _self.cdW = _self.galen.cdW;
                [_self countDown];
            }
        }];
    }];
    
    [self.eButton handleWithEvents:UIControlEventTouchUpInside completion:^(__kindof UIControl *control) {
        [_self.galen E:^(BOOL success) {
            if (success) {
                _self.cdE = _self.galen.cdE;
                [_self countDown];
            }
        }];
    }];
    
    [self.rButton handleWithEvents:UIControlEventTouchUpInside completion:^(__kindof UIControl *control) {
        [_self.galen R:^(BOOL success) {
            if (success) {
                _self.cdR = _self.galen.cdR;
                [_self countDown];
            }
        }];
    }];
}

#pragma mark - application life cycle

- (void)appWillActive
{
    [self revertSkillStatus];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
