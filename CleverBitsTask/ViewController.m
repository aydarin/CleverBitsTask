//
//  ViewController.m
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ItemsFieldView *itemsFieldView;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Items generator";
    
    [self.modeSwitch setOn:YES];
    self.itemsFieldView.constLifeDurationMode = YES;
    
    [self.itemsFieldView setup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stop) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self start];
}

#pragma mark - Field

- (void)start
{
    if (!self.itemsFieldView.isStarted) [self.itemsFieldView start];
}

- (void)stop
{
    if (self.itemsFieldView.isStarted)
    {
        [self.itemsFieldView stop];
        [self.itemsFieldView setup];
    }
}

#pragma mark - Actions

- (IBAction)modeSwitchValueChanged:(id)sender
{
    self.itemsFieldView.constLifeDurationMode = self.modeSwitch.isOn;
}

@end
