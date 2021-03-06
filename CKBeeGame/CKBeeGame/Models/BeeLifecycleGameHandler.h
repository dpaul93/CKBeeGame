//
//  BeeLifecycleGameHandler.h
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import <Foundation/Foundation.h>

static void * const BeeLifecycleKVOContext = (void*)&BeeLifecycleKVOContext;

@class BaseBee, BeeDataProvider;

@protocol BeeLifecycleGameHandlerDelegate;

@interface BeeLifecycleGameHandler : NSObject

@property (strong, nonatomic) BeeDataProvider *provider;
@property (strong, nonatomic, readonly) NSArray<BaseBee*> *bees;
@property (weak, nonatomic) IBOutlet id<BeeLifecycleGameHandlerDelegate> delegate;

-(void)hitRandomBee;
-(void)removeBee:(BaseBee*)bee;

+(BeeLifecycleGameHandler*)sharedInstance;

@end

@protocol BeeLifecycleGameHandlerDelegate <NSObject>

@optional
-(void)beeLifecycleHandler:(BeeLifecycleGameHandler*)handler didUpdateBeeLifespan:(BaseBee*)bee;
-(void)beeLifecycleHandler:(BeeLifecycleGameHandler*)handler beeLifespanDidEnd:(BaseBee*)bee;
-(void)beeLifecycleHandlerDidUpdateData:(BeeLifecycleGameHandler*)handler;

@end