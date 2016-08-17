//
//  BeeView.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "BeeView.h"
#import "LifespanView.h"
#import "BaseBee.h"

@interface BeeView()

@property (weak, nonatomic) UIImageView *beeImageView;
@property (weak, nonatomic) LifespanView *lifespanView;

@end

@implementation BeeView

#pragma mark - Initialization

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
    self.lifespanView.maxProgress = _bee.maxLifespan;
    self.lifespanView.progress = _bee.lifespan;
}

-(void)setLifespan:(CGFloat)lifespan {
    self.lifespanView.progress = lifespan;
    _lifespan = self.lifespanView.progress;
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
    
    LifespanView *lifespan = [LifespanView new];
    lifespan.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lifespan];
    self.lifespanView = lifespan;

    [self.lifespanView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.lifespanView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.lifespanView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.lifespanView.heightAnchor constraintEqualToConstant:10.0f].active = YES;
}

@end
