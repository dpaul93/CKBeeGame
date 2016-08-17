//
//  LifespanView.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 17.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "LifespanView.h"

@interface LifespanView()

@property (weak, nonatomic) CAShapeLayer *progressLineLayer;
@property (weak, nonatomic) UILabel *progressLabel;

@end

@implementation LifespanView

#pragma mark - Initialization

-(void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    if(!self.progressLineLayer) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        [self drawProgressLayerAnimated:YES];
        [self drawProgressLabel];
        self.progressLineLayer.frame = self.bounds;
    }
}

-(void)setProgress:(CGFloat)progress {
    CGFloat previousValue = _progress;
    
    _progress = MAX(0.0f, progress);
    _progress = MIN(_progress, self.maxProgress);
    
    if(_progress != previousValue) {
        [self updateProgressLineAnimated:YES previousValue:previousValue];
        [self updateProgressLabel];
    }
}

#pragma mark - Drawing

-(void)drawProgressLayerAnimated:(BOOL)animated {
    [self.progressLineLayer removeAllAnimations];
    [self.progressLineLayer removeFromSuperlayer];
    self.progressLineLayer = nil;
    
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0.0f, CGRectGetMidY(self.bounds))];
    [linePath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetMidY(self.bounds))];
    line.path = linePath.CGPath;
    line.strokeColor = [UIColor redColor].CGColor;
    line.strokeStart = 0.0f;
    line.strokeEnd = 1.0f;
    line.lineWidth = CGRectGetHeight(self.bounds);
    self.progressLineLayer = line;
    [self.layer addSublayer:self.progressLineLayer];
    
    [self updateProgressLineAnimated:animated previousValue:0.0f];
}

-(void)updateProgressLineAnimated:(BOOL)animated previousValue:(CGFloat)previousValue {
    CABasicAnimation *animation = [CABasicAnimation animation];
    CGFloat previousProgress = self.maxProgress ? previousValue / self.maxProgress : 0.0f;
    animation.fromValue = @(previousProgress);
    CGFloat progressValue = self.maxProgress ? self.progress / self.maxProgress : 0.0f;
    animation.toValue = @(progressValue);
    animation.duration = 0.25f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.progressLineLayer addAnimation:animation forKey:@"strokeEnd"];
}

-(void)drawProgressLabel {
    [self.progressLabel removeFromSuperview];
    self.progressLabel = nil;
    
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    progressLabel.font = [UIFont systemFontOfSize:11.0f];
    progressLabel.textColor = [UIColor blackColor];
    progressLabel.textAlignment = NSTextAlignmentCenter;
    progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:progressLabel];
    self.progressLabel = progressLabel;
    [self updateProgressLabel];
    [self.progressLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.progressLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.progressLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.progressLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
}

-(void)updateProgressLabel {
    self.progressLabel.text = [NSString stringWithFormat:@"%.f", self.progress];
}

@end
