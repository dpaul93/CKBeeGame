//
//  BeeView.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BeeView.h"
#import "BaseBee.h"

@interface BeeView()

@property (weak, nonatomic, readwrite) UIImageView *beeImageView;

@end

@implementation BeeView

#pragma mark - Initialization

-(instancetype)init {
    if(self = [super init]) {
        [self baseSetup];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self baseSetup];
    }
    
    return self;
}

-(instancetype)initWithBee:(BaseBee *)bee {
    if(self = [self init]) {
        self.bee = bee;
    }
    
    return self;
}

#pragma mark - Setters

-(void)setBee:(BaseBee *)bee {
    _bee = bee;
    self.beeImageView.image = [UIImage imageNamed:_bee.imageName];
    // TODO: add lifespan
}

#pragma mark - Helpers

-(void)baseSetup {
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    self.beeImageView = imageView;
    [self.beeImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.beeImageView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.beeImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.beeImageView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
}

@end
