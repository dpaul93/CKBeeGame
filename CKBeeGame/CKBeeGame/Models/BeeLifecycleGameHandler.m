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

static NSString * const kLifespanKeyPath = @"lifespan";

@interface BeeLifecycleGameHandler()

@property (strong, nonatomic) NSMutableArray<BaseBee*> *bees;

@end

@implementation BeeLifecycleGameHandler

#pragma mark - Initialization

-(instancetype)init {
    if(self = [super init]) {
        self.provider = [BeeDataProvider new];
        self.bees = [self.provider generateBees].mutableCopy;
    }
    
    return self;
}

-(void)dealloc {
    self.bees = nil;
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if(context == BeeLifecycleKVOContext) {
        BaseBee *bee = object;
        [self updateLifespanOfBee:bee];
        if(bee.lifespan <= 0) {
            [self endBeeLifespan:bee];
            [self removeBee:bee];
            if([bee isKindOfClass:[QueenBee class]]) {
                [self removeRemainingBees];
            } else if(!self.bees.count) {
                [self updateData];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Instance Methods

-(void)hitRandomBee {
    NSInteger randomIndex = arc4random_uniform((int)self.bees.count);
    BaseBee *bee = self.bees[randomIndex];
    [bee hitBee];
}

-(void)removeBee:(BaseBee *)bee {
    @try {
        [bee removeObserver:self forKeyPath:kLifespanKeyPath context:BeeLifecycleKVOContext];
    } @catch (NSException *exception) { }
    [((NSMutableArray*)self.bees) removeObject:bee];
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

#pragma mark - Setters

-(void)setBees:(NSMutableArray<BaseBee *> *)bees {
    @try {
        for (BaseBee *bee in _bees) {
            [bee removeObserver:self forKeyPath:kLifespanKeyPath context:BeeLifecycleKVOContext];
        }
    } @catch (NSException *exception) { }

    _bees = bees;

    for (BaseBee *bee in _bees) {
        [bee addObserver:self forKeyPath:kLifespanKeyPath options:NSKeyValueObservingOptionNew context:BeeLifecycleKVOContext];
    }
}

#pragma mark - Helpers

-(void)removeRemainingBees {
    for (NSInteger i = 0; i < self.bees.count; i++) {
        BaseBee *remainingBee = self.bees[i];
        @try {
            [remainingBee removeObserver:self forKeyPath:kLifespanKeyPath context:BeeLifecycleKVOContext];
        } @catch (NSException *exception) { }
        [remainingBee killBee];
        [self updateLifespanOfBee:remainingBee];
        [self endBeeLifespan:remainingBee];
    }
    [self updateData];
}

-(void)updateData {
    self.bees = [self.provider generateBees].mutableCopy;
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
