//
//  BaseBee.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BaseBee.h"

NSString * const kBeeLifespanDidChangeNotification = @"BeeLifespanDidChangeNotification";

@implementation BaseBee

@synthesize lifespan = pLifespan;

#pragma mark - Base Methods

-(void)hitBee {
    NSAssert(![self isMemberOfClass:[BaseBee class]], @"Base method should be overriden in child class.");
}

@end
