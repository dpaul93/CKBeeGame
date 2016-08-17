//
//  BeeLifecycleGameHandler.h
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseBee;

@protocol BeeLifecycleGameHandlerDelegate;

@interface BeeLifecycleGameHandler : NSObject

@property (strong, nonatomic, readonly) NSArray<BaseBee*> *bees;
@property (weak, nonatomic) id<BeeLifecycleGameHandlerDelegate> delegate;

-(void)hitRandomBee;
-(void)removeBee:(BaseBee*)bee;

+(BeeLifecycleGameHandler*)sharedInstance;

@end

@protocol BeeLifecycleGameHandlerDelegate <NSObject>

@optional
-(void)beeLifecycleHandler:(BeeLifecycleGameHandler*)handler didUpdateBeeLifespan:(BaseBee*)bee;
-(void)beeLifecycleHandler:(BeeLifecycleGameHandler*)handler beeLifespanDidEnd:(BaseBee*)bee;
-(void)beeLifcycleHandlerDidUpdateData:(BeeLifecycleGameHandler*)handler;

@end