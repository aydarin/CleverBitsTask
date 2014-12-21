//
//  ItemsFieldView.h
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemFactory.h"
#import "ItemView.h"

@interface ItemsFieldView : UIView<ItemViewDelegate>

@property (nonatomic, readonly) BOOL isStarted;
@property (nonatomic) BOOL constLifeDurationMode;

- (void)setup;
- (void)start;
- (void)stop;

@end
