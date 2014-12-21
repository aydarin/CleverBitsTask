//
//  ItemView.h
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@class ItemView;

@protocol ItemViewDelegate <NSObject>

- (void)itemViewDidStop:(ItemView*)itemView;

@end

@interface ItemView : UIImageView

@property (nonatomic, retain) Item* item;
@property (nonatomic, weak) id<ItemViewDelegate> delegate;

- (void)startLife;
- (void)stopLife;

@end
