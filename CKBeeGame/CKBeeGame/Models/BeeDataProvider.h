//
//  BeeDataProvider.h
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseBee;

@interface BeeDataProvider : NSObject

@property (strong, nonatomic, readonly) NSArray *bees;

-(void)updateData;
-(void)removeBee:(BaseBee*)bee;

@end