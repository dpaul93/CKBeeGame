//
//  MockGameHandler.h
//  CKBeeGame
//
//  Created by Pavlo Deynega on 17.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BeeLifecycleGameHandler.h"

@class BeeDataProvider;

@interface MockGameHandler : BeeLifecycleGameHandler <BeeLifecycleGameHandlerDelegate>

@property (assign, nonatomic) BOOL queenDied;

-(void)hitQueen;
-(void)updateBeeData;

@end
