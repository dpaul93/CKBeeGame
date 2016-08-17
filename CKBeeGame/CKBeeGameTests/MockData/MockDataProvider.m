//
//  MockDataProvider.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 17.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "MockDataProvider.h"

@implementation MockDataProvider

-(NSArray*)generateBees {
    NSMutableArray *temp = [NSMutableArray new];
    
    NSDictionary *vals = @{
                           NSStringFromClass([QueenBee class]) : @(MockDataProviderBeeTypeCountQueen),
                           NSStringFromClass([WorkerBee class]) : @(MockDataProviderBeeTypeCountWorker),
                           NSStringFromClass([DroneBee class]) : @(MockDataProviderBeeTypeCountDrone)
                           };
    for (NSString *key in vals.allKeys) {
        NSNumber *count = vals[key];
        NSArray *bees = [self generateBeeOfType:NSClassFromString(key) count:count.integerValue];
        [temp addObjectsFromArray:bees];
    }
    
    return [self shuffleArray:temp];
}

-(NSArray*)generateBeeOfType:(Class)type count:(NSInteger)count {
    NSMutableArray *temp = [NSMutableArray new];
    
    for (NSInteger i = 0; i < count; i++) {
        BaseBee *bee = [type new];
        [temp addObject:bee];
    }
    
    return temp;
}

-(NSArray*)shuffleArray:(NSArray*)array {
    NSMutableArray *temp = array.mutableCopy;
    for (NSInteger i = 0; i < temp.count; i++) {
        NSInteger previous = temp.count - i;
        NSInteger randomIndex = (arc4random() % previous) + i;
        [temp exchangeObjectAtIndex:i withObjectAtIndex:randomIndex];
    }
    
    return temp;
}

@end
