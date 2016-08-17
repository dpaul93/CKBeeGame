//
//  MockBee.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 17.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "MockBee.h"
#import "MockBee+Protected.h"

@implementation MockBee

-(void)hitBee {
    [self setLifespan:10];
}

@end
