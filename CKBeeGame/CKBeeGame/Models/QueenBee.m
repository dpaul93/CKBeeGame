//
//  QueenBee.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "QueenBee.h"
#import "BaseBee+Protected.h"

@implementation QueenBee

#pragma mark - Initialization

-(instancetype)init {
    if(self = [super init]) {
        pLifespan = self.maxLifespan;
        pImageName = @"queenBee";
    }
    
    return self;
}

#pragma mark - Overrides

-(void)hitBee {
    self.lifespan -= 8;
}

-(NSInteger)maxLifespan {
    return 100;
}

@end
