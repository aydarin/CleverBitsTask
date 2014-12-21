//
//  ItemView.m
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

- (instancetype)init
{
    self = [self initWithImage:[UIImage imageNamed:@"shuriken.png"]];
    self.frame = CGRectMake(0, 0, 50, 50);
    
    return self;
}

- (void)dealloc
{
    self.item = nil;
}

- (void)startLife
{
    [_item startLife];
}

- (void)stopLife
{
    Item* item = self.item;
    self.item = nil;
    [item stopLife];
    
    [_delegate itemViewDidStop:self];
}

- (void)setItem:(Item *)item
{
    if (_item != item)
    {
        if (_item) [[NSNotificationCenter defaultCenter] removeObserver:self name:ITEM_STOP_LIFE_NOTIFICATION object:_item];
        _item = item;
        if (_item) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemStopLifeNotification:) name:ITEM_STOP_LIFE_NOTIFICATION object:_item];
    }
}

- (void)itemStopLifeNotification:(NSNotification*)not
{
    CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.transform = transform;
                     } completion:^(BOOL finished) {
                         if (self.item) [self stopLife];
                     }];
}

@end
