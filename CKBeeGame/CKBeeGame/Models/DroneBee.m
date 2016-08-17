//
//  DroneBee.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "DroneBee.h"
#import "BaseBee+Protected.h"

@implementation DroneBee

#pragma mark - Initialization

-(instancetype)init {
    if(self = [super init]) {
        pLifespan = 50;
        pImageName = @"droneBee";
    }
    
    return self;
}

#pragma mark - Overrides

-(void)hitBee {
    [self setLifespan:self.lifespan - 12];
}

@end
