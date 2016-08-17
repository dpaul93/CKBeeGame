//
//  BaseBee.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BaseBee.h"
#import "BaseBee+Protected.h"

NSString * const kBeeLifespanDidChangeNotification = @"BeeLifespanDidChangeNotification";

@implementation BaseBee

@synthesize lifespan = pLifespan, imageName = pImageName;

#pragma mark - Base Methods

-(void)hitBee {
    NSAssert(![self isMemberOfClass:[BaseBee class]], @"Base method should be overriden in child class.");
}

-(void)killBee {
    [self setLifespan:0];
}

@end
