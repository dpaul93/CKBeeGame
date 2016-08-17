//
//  BeeDataProvider.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BeeDataProvider.h"
#import "QueenBee.h"
#import "DroneBee.h"
#import "WorkerBee.h"

typedef NS_ENUM(NSInteger, BeeDataProviderBeeTypeCount) {
    BeeDataProviderBeeTypeCountQueen = 1,
    BeeDataProviderBeeTypeCountWorker = 5,
    BeeDataProviderBeeTypeCountDrone = 8,
    BeeDataProviderBeeTypeCountTotal = BeeDataProviderBeeTypeCountQueen + BeeDataProviderBeeTypeCountDrone + BeeDataProviderBeeTypeCountWorker
};

@interface BeeDataProvider()

@property (strong, nonatomic, readwrite) NSArray *bees;

@end

@implementation BeeDataProvider

#pragma mark - Initialization

-(instancetype)init {
    if(self = [super init]) {
        [self updateData];
    }
    
    return self;
}

#pragma mark - External Methods

-(void)removeBee:(BaseBee *)bee {
    NSMutableArray *temp = self.bees.mutableCopy;
    [temp removeObject:bee];
    self.bees = temp;
}

-(void)updateData {
    self.bees = [self generateBees];
}

#pragma mark - Internal Methods

-(NSArray*)generateBees {
    NSMutableArray *temp = [NSMutableArray new];
    
    NSDictionary *vals = @{
                           NSStringFromClass([QueenBee class]) : @(BeeDataProviderBeeTypeCountQueen),
                           NSStringFromClass([WorkerBee class]) : @(BeeDataProviderBeeTypeCountWorker),
                           NSStringFromClass([DroneBee class]) : @(BeeDataProviderBeeTypeCountDrone)
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
