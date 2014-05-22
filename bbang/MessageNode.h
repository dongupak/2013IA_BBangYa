//
//  MessageNode.h
//  bbang
//
//  Created by Mobile-X on 13. 6. 4..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AppDelegate.h"

@interface MessageNode : CCNode {
    CCSprite *miss;
	CCSprite *correct;
	CCSprite *bonus;
	CCSprite *combo;
    
	BOOL missVisible;
	BOOL correctVisible;
	BOOL bonusVisible;
    BOOL comboVisible;

}
extern int const MISS_MESSAGE;
extern int const CORRECT_MESSAGE;
extern int const BONUS_MESSAGE;
extern int const COMBO_MESSAGE;

@property (nonatomic, retain) CCSprite *miss;
@property (nonatomic, retain) CCSprite *correct;
@property (nonatomic, retain) CCSprite *bonus;
@property (nonatomic, retain) CCSprite *combo;
-(void)showMessage:(int) message;

@end
