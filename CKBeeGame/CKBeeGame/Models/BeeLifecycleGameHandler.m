//
//  BeeLifecycleGameHandler.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BeeLifecycleGameHandler.h"
#import "BeeDataProvider.h"
#import "QueenBee.h"
#import "DroneBee.h"
#import "WorkerBee.h"

@interface BeeLifecycleGameHandler()

@property (strong, nonatomic) BeeDataProvider *provider;

@end

@implementation BeeLifecycleGameHandler

#pragma mark - Initialization

-(instancetype)init {
    if(self = [super init]) {
        self.provider = [BeeDataProvider new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beeLifespanDidChangeNotification:) name:kBeeLifespanDidChangeNotification object:nil];
    }
    
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification Handling

-(void)beeLifespanDidChangeNotification:(NSNotification*)notification {
    BaseBee *bee = notification.object;
    [self updateLifespanOfBee:bee];
    if(bee.lifespan <= 0) {
        [self endBeeLifespan:bee];
        if([bee isKindOfClass:[QueenBee class]]) {
            [self updateData];
        } else {
            [self.provider removeBee:bee];
            if(!self.provider.bees.count) {
                [self updateData];
            }
        }
    }
}

#pragma mark - Instance Methods

-(void)hitRandomBee {
    NSInteger randomIndex = arc4random_uniform((int)self.provider.bees.count);
    BaseBee *bee = self.provider.bees[randomIndex];
    [bee hitBee];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kBeeLifespanDidChangeNotification object:bee];
}

-(void)removeBee:(BaseBee *)bee {
    [self.provider removeBee:bee];
}

#pragma mark - Class Methods

+(BeeLifecycleGameHandler *)sharedInstance {
    static BeeLifecycleGameHandler *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [BeeLifecycleGameHandler new];
    });
    
    return _instance;
}

#pragma mark - Getters

-(NSArray<BaseBee *> *)bees {
    return self.provider.bees;
}

#pragma mark - Helpers

-(void)updateData {
    [self.provider updateData];
    if([self.delegate respondsToSelector:@selector(beeLifecycleHandlerDidUpdateData:)]) {
        [self.delegate beeLifecycleHandlerDidUpdateData:self];
    }
}

-(void)updateLifespanOfBee:(BaseBee*)bee {
    if([self.delegate respondsToSelector:@selector(beeLifecycleHandler:didUpdateBeeLifespan:)]) {
        [self.delegate beeLifecycleHandler:self didUpdateBeeLifespan:bee];
    }
}

-(void)endBeeLifespan:(BaseBee*)bee {
    if([self.delegate respondsToSelector:@selector(beeLifecycleHandler:beeLifespanDidEnd:)]) {
        [self.delegate beeLifecycleHandler:self beeLifespanDidEnd:bee];
    }
}

@end
