//
//  WorkerBee.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "WorkerBee.h"
#import "BaseBee+Protected.h"

@implementation WorkerBee

#pragma mark - Initialization

-(instancetype)init {
    if(self = [super init]) {
        pLifespan = 75;
        pImageName = @"workerBee";
    }
    
    return self;
}

#pragma mark - Overrides

-(void)hitBee {
    [self setLifespan:self.lifespan - 10];
}

@end
