//
//  MockGameHandler.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 17.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "MockGameHandler.h"
#import "QueenBee.h"

@implementation MockGameHandler

-(void)hitQueen {
    for (NSInteger i = 0; i < self.bees.count; i++) {
        BaseBee *bee = self.bees[i];
        if([bee isKindOfClass:[QueenBee class]]) {
            [bee killBee];
            break;
        }
    }
}

-(void)beeLifecycleHandler:(BeeLifecycleGameHandler *)handler beeLifespanDidEnd:(BaseBee *)bee {
    if([bee isKindOfClass:[QueenBee class]]) {
        self.queenDied = YES;
    }
}

@end
