//
//  ItemFactory.m
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import "ItemFactory.h"

@interface ItemFactory ()
{
    CGFloat _constLifeDuration;
    CGFloat _maxLifeDuration;
    CGFloat _minLifeDuration;
    
    CGFloat _constVelocity;
    CGFloat _maxVelocity;
    CGFloat _minVelocity;
    
    CGFloat _maxAngle;
    CGFloat _minAngle;
}

@end

@implementation ItemFactory

+ (instancetype)shared
{
    static ItemFactory *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _constLifeDuration = 10;
        _minLifeDuration = 5;
        _maxLifeDuration = 10;
        
        _constVelocity = 60;
        _minVelocity = 10;
        _maxVelocity = 100;
        
        _minAngle = -30;
        _maxAngle = 30;
    }
    
    return self;
}

#pragma mark - Items

- (Item*)getConstLifeDurationItem
{
    CGFloat angle = [self getRandomWithMin:_minAngle max:_maxAngle];
    CGFloat velocity = [self getRandomWithMin:_minVelocity max:_maxVelocity];
    
    Item* item = [[Item alloc] initWithAngle:angle velocity:velocity lifeDuration:_constLifeDuration];
    
    return item;
}

- (Item*)getConstVelocityItem
{
    CGFloat angle = [self getRandomWithMin:_minAngle max:_maxAngle];
    CGFloat lifeDuration = [self getRandomWithMin:_minLifeDuration max:_maxLifeDuration];
    
    Item* item = [[Item alloc] initWithAngle:angle velocity:_constVelocity lifeDuration:lifeDuration];
    
    return item;
}

#pragma mark - Utils

- (CGFloat)getRandomWithMin:(CGFloat)min max:(CGFloat)max
{
    CGFloat val = (CGFloat)arc4random()/0xFFFFFFFFu;
    val = min + val * (max - min);
    return val;
}

@end
