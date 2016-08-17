//
//  BaseBee.h
//  CKBeeGame
//
//  Created by Pavlo Deynega on 16.08.16.
//  Copyright © 2016 Pavlo Deynega. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kBeeLifespanDidChangeNotification;

@protocol BaseBeeInterface <NSObject>

-(void)hitBee;

@end

@interface BaseBee : NSObject <BaseBeeInterface> {
@protected
    NSInteger pLifespan;
    NSString *pImageName;
}

@property (assign, nonatomic, readonly) NSInteger lifespan;
@property (assign, nonatomic, readonly) NSInteger maxLifespan;
@property (strong, nonatomic, readonly) NSString *imageName;

@end
