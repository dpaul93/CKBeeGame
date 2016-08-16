//
//  BaseBee+Protected.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BaseBee+Protected.h"

@implementation BaseBee (Protected)

#pragma mark - Protected setter

-(void)setLifespan:(NSInteger)lifespan {
    [self willChangeValueForKey:@"lifespan"];
    pLifespan = lifespan;
    [self didChangeValueForKey:@"lifespan"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBeeLifespanDidChangeNotification object:self];
}

@end
