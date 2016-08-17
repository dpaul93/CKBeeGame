//
//  CKBeeGameTests.m
//  CKBeeGameTests
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameViewController.h"
#import "MockGameHandler.h"
#import "MockDataProvider.h"
#import "MockBee.h"

@interface CKBeeGameTests : XCTestCase

@property (strong, nonatomic) GameViewController *gameViewController;
@property (strong, nonatomic) MockGameHandler *handler;
@property (strong, nonatomic) MockDataProvider *provider;

@end

@implementation CKBeeGameTests

- (void)setUp {
    [super setUp];

    self.gameViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([GameViewController class])];
    self.provider = [MockDataProvider new];
    self.handler = [MockGameHandler new];
    self.handler.provider = self.provider;
    self.gameViewController.gameHandler = self.handler;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHitMockBee {
    MockBee *bee = [MockBee new];
    [bee hitBee];
    XCTAssertTrue(bee.didChange, @"Lifespan value should have been changed.");
}

- (void)testHitQueenBee {
    BaseBee *bee = [QueenBee new];
    NSInteger currentLifespan = bee.lifespan;
    [bee hitBee];
    XCTAssertTrue(currentLifespan != bee.lifespan, @"Lifespan value should have been changed.");
}

-(void)testProviderIsSetUp {
    XCTAssertNotNil(self.gameViewController.gameHandler.provider, @"Data provider should be set.");
}

-(void)testDataProviderGenerateBees {
    NSArray *bees = [self.provider generateBees];
    XCTAssertTrue(bees.count == MockDataProviderBeeTypeCountTotal, @"Bees array must be generated.");
}

-(void)testDataProviderBeesEquality {
    NSArray *bees = [self.provider generateBees];
    NSInteger queen, worker, drone;
    for (BaseBee *bee in bees) {
        if([bee isKindOfClass:[QueenBee class]]) {
            queen++;
        } else if ([bee isKindOfClass:[WorkerBee class]]) {
            worker++;
        } else if ([bee isKindOfClass:[DroneBee class]]) {
            drone++;
        }
    }
    
    XCTAssertTrue(queen == MockDataProviderBeeTypeCountQueen, @"There must be 1 queen generated");
    XCTAssertTrue(worker == MockDataProviderBeeTypeCountWorker, @"There must be 5 workers generated");
    XCTAssertTrue(drone == MockDataProviderBeeTypeCountDrone, @"There must be 8 drones generated");
}

-(void)testHandlerDelegateOnQueenDeath {
    self.handler.delegate = self.handler;
    [self.handler hitQueen];
    XCTAssertTrue(self.handler.queenDied, @"Queen should have died.");
}

-(void)testResetOnQueenDeath {
    NSArray *previousArray = self.handler.bees;
    self.handler.delegate = self.handler;
    [self.handler hitQueen];
    NSArray *updatedArray = self.handler.bees;
    XCTAssertNotEqual(previousArray, updatedArray, @"There should be 2 different arrays.");
}

-(void)testDataProviderRemoveBee {
    NSInteger beesCount = self.handler.bees.count;
    [self.handler removeBee:self.handler.bees.firstObject];
    XCTAssertFalse(beesCount == self.handler.bees.count, @"Bees array must have less count value after deleting.");
}

@end
