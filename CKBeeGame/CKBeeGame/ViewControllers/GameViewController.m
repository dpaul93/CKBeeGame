//
//  GameViewController.m
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import "GameViewController.h"
#import "BeeLifecycleGameHandler.h"
#import "BeeView.h"
#import "BaseBee.h"

@interface GameViewController () <BeeLifecycleGameHandlerDelegate>

@property (strong, nonatomic) IBOutlet BeeLifecycleGameHandler *gameHandler;
@property (strong, nonatomic) NSMutableArray *beeViews;

@end

@implementation GameViewController

#pragma amrk - Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    [self redrawBees];
}

#pragma mark - BeeLifecycleGameHandler Delegate

-(void)beeLifecycleHandler:(BeeLifecycleGameHandler *)handler didUpdateBeeLifespan:(BaseBee *)bee {
    BeeView *view = [self beeViewFromViewsArrayWithBee:bee];
    view.lifespan = bee.lifespan;
}

-(void)beeLifecycleHandler:(BeeLifecycleGameHandler *)handler beeLifespanDidEnd:(BaseBee *)bee {
    BeeView *view = [self beeViewFromViewsArrayWithBee:bee];
    [self.beeViews removeObject:view];
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.frame = CGRectOffset(view.frame, 0.0f, CGRectGetHeight(self.view.bounds));
        view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

-(void)beeLifecycleHandlerDidUpdateData:(BeeLifecycleGameHandler *)handler {
    [self redrawBees];
}

#pragma mark - Actions

- (IBAction)hitButtonPressed:(id)sender {
    [self.gameHandler hitRandomBee];
}

#pragma mark - Helpers

-(void)redrawBees {
    for (BeeView *view in self.beeViews) {
        [view removeFromSuperview];
    }
    self.beeViews = [NSMutableArray new];
    
    NSInteger horizontalRowCount = 5;
    CGFloat beeSquareSize = CGRectGetWidth(self.view.bounds) / horizontalRowCount;
    for (NSInteger i = 0, x = 0, y = 40; i < self.gameHandler.bees.count; i++) {
        BaseBee *currentBee = self.gameHandler.bees[i];
        BeeView *view = [[BeeView alloc] initWithBee:currentBee];
        view.frame = CGRectMake(x, y, beeSquareSize, beeSquareSize);
        [self.view addSubview:view];
                
        [self.beeViews addObject:view];
        
        x += beeSquareSize;
        if((i + 1) % horizontalRowCount == 0) {
            x = 0;
            y += beeSquareSize;
        }
    }
}

-(BeeView*)beeViewFromViewsArrayWithBee:(BaseBee*)bee {
    NSArray *filteredArray = [self.beeViews filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"bee = %@", bee]];
    return filteredArray.count ? filteredArray.firstObject : nil;
}

@end

