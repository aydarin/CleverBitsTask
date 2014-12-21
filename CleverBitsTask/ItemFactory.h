//
//  ItemFactory.h
//  CleverBitsTask
//
//  Created by Aydar Mukhametzyanov on 21/12/14.
//  Copyright (c) 2014 Aydar Mukhametzyanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ItemFactory : NSObject

+ (instancetype)shared;
- (Item*)getConstLifeDurationItem;
- (Item*)getConstVelocityItem;

@end
