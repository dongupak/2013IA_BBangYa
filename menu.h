//
//  menu.h
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//
//#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface menu : CCLayer {
    CCNode *menuNode;
    
    CCSprite *gunSmoke;
    CCAnimate *smokeAnimate;
    CCAnimate *animate;
    
    CCNode *targetNode;
    
    CCSprite *target;
    CCSprite *man;
    
    SimpleAudioEngine *sound;
}
+(CCScene *) scene;
@property(nonatomic, retain) NSDate *touchBeganTime;

@end
