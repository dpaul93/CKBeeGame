//
//  GameViewController.h
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  BeeLifecycleGameHandler;

@interface GameViewController : UIViewController

@property (strong, nonatomic) IBOutlet BeeLifecycleGameHandler *gameHandler;

@end
