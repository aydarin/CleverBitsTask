//
//  ItemsFieldView.m
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import "ItemsFieldView.h"

@interface ItemsFieldView ()
{
    NSMutableArray* _itemViews;
    int _itemsCount;
}

@end

@implementation ItemsFieldView

- (void)setup
{
    _isStarted = NO;
    _itemsCount = 5;
    _itemViews = [[NSMutableArray alloc] init];
    
    NSArray* items = [self getNeedsItemViews];
    [_itemViews addObjectsFromArray:items];
}

- (void)start
{
    _isStarted = YES;
    [self startLifeForItemViewsArray:[_itemViews copy]];
}

- (void)stop
{
    _isStarted = NO;
    NSArray* itemViews = [_itemViews copy];
    _itemViews = nil;
    
    for (ItemView* itemView in itemViews)
    {
        [itemView stopLife];
    }
}

#pragma mark - ItemView animation

- (void)startLifeForItemView:(ItemView*)itemView
{
    itemView.center = CGPointMake(self.frame.size.width / 2, 0);
    itemView.hidden = NO;
    CGPoint toPoint = [self calcDestinationPoint:itemView];
    CGFloat duration = [self calcAnimationDuration:itemView.center toPoint:toPoint velocity:itemView.item.velocity];
    [itemView startLife];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         itemView.center = toPoint;
                     } completion:^(BOOL finished) {
                         [self itemViewDidOutFromBounds:itemView];
                     }];
}

- (void)itemViewDidOutFromBounds:(ItemView*)itemView
{
    [itemView stopLife];
}

#pragma mark - ItemViewDelegate

- (void)itemViewDidStop:(ItemView *)itemView
{
    [itemView removeFromSuperview];
    [_itemViews removeObject:itemView];
    [self getNeedsItemsAndStart];
}

#pragma mark - Utils

- (void)getNeedsItemsAndStart
{
    if (_isStarted)
    {
        NSArray* items = [self getNeedsItemViews];
        [_itemViews addObjectsFromArray:items];
        [self startLifeForItemViewsArray:items];
    }
}

- (NSArray*)getNeedsItemViews
{
    int needsCount = _itemsCount - (int)_itemViews.count;
    if (needsCount < 0) needsCount = 0;
    
    NSMutableArray* itemViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < needsCount; i++)
    {
        Item* item = [self getItem];
        ItemView* itemView = [[ItemView alloc] init];
        itemView.item = item;
        itemView.delegate = self;
        [itemViews addObject:itemView];
        itemView.hidden = YES;
        [self addSubview:itemView];
    }
    
    return itemViews;
}

- (void)startLifeForItemViewsArray:(NSArray*)itemViews
{
    for (ItemView* itemView in itemViews)
    {
        [self startLifeForItemView:itemView];
    }
}

- (Item*)getItem
{
    Item* item;
    
    if (_constLifeDurationMode) item = [[ItemFactory shared] getConstLifeDurationItem];
    else item = [[ItemFactory shared] getConstVelocityItem];
    
    return item;
}

- (CGFloat)calcAnimationDuration:(CGPoint)fromPoint toPoint:(CGPoint)toPoint velocity:(CGFloat)velocity
{
    CGFloat x = toPoint.x - fromPoint.x;
    CGFloat y = toPoint.y - fromPoint.y;
    
    CGFloat dist = sqrtf(x*x + y*y);
    
    return dist / velocity;
}

- (CGPoint)calcDestinationPoint:(ItemView*)itemView
{
    CGPoint destPoint = CGPointZero;
    
    if (self.frame.size.height != 0 && self.frame.size.width != 0)
    {
        CGFloat sw = self.frame.size.width;
        CGFloat sh = self.frame.size.height;
        CGFloat iw = itemView.frame.size.width;
        
        CGFloat tgCornerAngle = (sw/2 + iw/2) / (sh + iw/2);
        int itemAngleSign = itemView.item.angle > 0 ? 1 : -1;
        
        if (itemView.item.tgAngle > tgCornerAngle)
        {
            destPoint.x = (sw/2 + iw/2) * itemAngleSign + sw/2;
            destPoint.y = (sw/2 + iw/2) / itemView.item.tgAngle;
        }
        else
        {
            destPoint.x = (sh + iw/2) * itemView.item.tgAngle * itemAngleSign + sw/2;
            destPoint.y = sh + iw/2;
        }
    }
    
    return destPoint;
}

@end
