//
//  MockBee+Protected.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 17.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "MockBee+Protected.h"

@implementation MockBee (Protected)

#pragma mark - Protected setter

-(void)setLifespan:(NSInteger)lifespan {
    pLifespan = lifespan;
    self.didChange = YES;
}

@end
