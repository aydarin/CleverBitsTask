//
//  Item.h
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ITEM_STOP_LIFE_NOTIFICATION @"ItemStopLifeNotification"

@interface Item : NSObject

@property (nonatomic, readonly) CGFloat angle;
@property (nonatomic, readonly) CGFloat tgAngle;
@property (nonatomic, readonly) CGFloat velocity;
@property (nonatomic, readonly) CGFloat lifeDuration;

- (instancetype)initWithAngle:(CGFloat)angle
                     velocity:(CGFloat)velocity
                 lifeDuration:(CGFloat)lifeDuration;

- (void)startLife;
- (void)stopLife;

@end
