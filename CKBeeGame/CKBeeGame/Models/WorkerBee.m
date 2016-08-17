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
        pLifespan = self.maxLifespan;
        pImageName = @"workerBee";
    }
    
    return self;
}

#pragma mark - Overrides

-(void)hitBee {
    self.lifespan -= 10;
}

-(NSInteger)maxLifespan {
    return 75;
}

@end
