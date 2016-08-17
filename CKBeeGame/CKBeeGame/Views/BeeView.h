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

@property (weak, nonatomic, readonly) UIImageView *beeImageView;
@property (strong, nonatomic) BaseBee *bee;

-(instancetype)initWithBee:(BaseBee*)bee;

@end
