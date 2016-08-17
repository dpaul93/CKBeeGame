//
//  MockDataProvider.h
//  CKBeeGame
//
//  Created by Pavlo Deynega on 17.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BeeDataProvider.h"
#import "QueenBee.h"
#import "DroneBee.h"
#import "WorkerBee.h"

typedef NS_ENUM(NSInteger, MockDataProviderBeeTypeCount) {
    MockDataProviderBeeTypeCountQueen = 1,
    MockDataProviderBeeTypeCountWorker = 5,
    MockDataProviderBeeTypeCountDrone = 8,
    MockDataProviderBeeTypeCountTotal = MockDataProviderBeeTypeCountQueen + MockDataProviderBeeTypeCountDrone + MockDataProviderBeeTypeCountWorker
};

@interface MockDataProvider : BeeDataProvider

-(NSArray*)generateBees;

@end
