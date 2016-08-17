//
//  BeeView.h
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseBee;

@interface BeeView : UIView

@property (strong, nonatomic) BaseBee *bee;
@property (assign, nonatomic) CGFloat lifespan;

-(instancetype)initWithBee:(BaseBee*)bee;

@end
