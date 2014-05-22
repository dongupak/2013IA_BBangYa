//
//  timeGame.h
//  bbang
//
//  Created by Mobile-X on 13. 6. 2..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//
#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "MessageNode.h"

@interface timeGame : CCLayer {
    MessageNode *message;
    MessageNode *comboMess;
    
    CCNode *targetNode;
    CCNode *lifeNode;
    CCNode *bulletNode;
    CCNode *bombNode;
    CCNode *goldNode;
    
    CCSprite *target;
    CCSprite *bomb;
    CCSprite *gold_target;
    CCSprite *man;
    NSInteger life;
    
    CCSprite *life1;
    CCSprite *life2;
    CCSprite *life3;
    CCSprite *life4;
    CCSprite *life5;
    
    CCMenu *Rmenu;
    
    CCSprite *bullet1;
    CCSprite *bullet2;
    CCSprite *bullet3;
    CCSprite *bullet4;
    CCSprite *bullet5;
    CCSprite *bullet6;
    CCSprite *bullet7;
    CCSprite *bullet8;
    CCSprite *bullet9;
    CCSprite *bullet10;
    NSInteger bulletNum;
    CCLabelTTF *alert;
    CCMenuItem *stop;
    CCMenuItem *replay;
    CCMenu *menuP;
    
    CCSprite *gunSmoke;
    CCAnimate *smokeAnimate;
    CCAnimate *animate;
    
    CCLabelTTF *time;
    float t;
    CCSprite *energyM;
    
    CCProgressTimer *timeBar;
    
    CCSprite *die;
    CCAnimate *animateT;
    CCAnimate *animateG;
    CCAnimate *animateB;
    
    int combo;
    CCLabelAtlas *scoreNumSprite;
    
    SimpleAudioEngine *sound;
    SimpleAudioEngine *sound2;
    SimpleAudioEngine *sound3;
    
    float timeM;
}
@property(nonatomic, retain) NSDate *touchBeganTime;
@property(nonatomic, retain) CCLabelTTF *scoreLabel;
@property(nonatomic) NSInteger score;

@property (nonatomic, retain) MessageNode *message;
@property (nonatomic, retain) CCLabelAtlas *scoreNumSprite;
+(CCScene *) scene;

@end
