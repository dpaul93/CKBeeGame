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
    
}

-(void)beeLifecycleHandler:(BeeLifecycleGameHandler *)handler beeLifespanDidEnd:(BaseBee *)bee {
    
}

-(void)beeLifcycleHandlerDidUpdateData:(BeeLifecycleGameHandler *)handler {
    
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
        
        view.layer.borderColor = [UIColor blueColor].CGColor;
        view.layer.borderWidth = 2;
        
        [self.beeViews addObject:view];
        
        x += beeSquareSize;
        if(i > 0 && i % horizontalRowCount == 0) {
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

