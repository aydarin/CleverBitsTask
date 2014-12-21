//
//  Item.m
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import "Item.h"

@interface Item ()

@property (nonatomic, retain) NSTimer* timer;

@end

@implementation Item

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _angle = 0;
        _tgAngle = 0;
        _velocity = 1;
        _lifeDuration = 1;
    }
    
    return self;
}

- (instancetype)initWithAngle:(CGFloat)angle
                     velocity:(CGFloat)velocity
                 lifeDuration:(CGFloat)lifeDuration
{
    self = [self init];
    
    if (self)
    {
        _angle = angle;
        _tgAngle = tanf(M_PI * (fabs(_angle) / 180));
        _velocity = velocity;
        _lifeDuration = lifeDuration;
    }
    
    return self;
}

- (void)startLife
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:_lifeDuration
                                              target:self
                                            selector:@selector(stopLife)
                                            userInfo:nil
                                             repeats:NO];
}

- (void)stopLife
{
    _timer = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_STOP_LIFE_NOTIFICATION object:self];
}

@end
