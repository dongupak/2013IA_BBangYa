//
//  selectGame.m
//  bbang
//
//  Created by Mobile-X on 13. 6. 2..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "selectGame.h"
#import "SceneManager.h"

@implementation selectGame
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    selectGame *layer = [selectGame node];
    [scene addChild: layer];
    return scene;
}
-(id)init{
    
    CGSize winsize = [[CCDirector sharedDirector] winSize];

    if (self=[super init]) {
        CCSprite *bg = [CCSprite spriteWithFile:@"무제-4.png"];
        bg.position = ccp(winsize.width / 2, winsize.height / 2);
        [self addChild:bg z:0];
        CCSprite *bg1 = [CCSprite spriteWithFile:@"layer_mode.png"];
        bg1.position = ccp(winsize.width / 2, winsize.height / 2);
        [self addChild:bg1 z:1];
        CCMenuItem *classic = [CCMenuItemImage itemWithNormalImage:@"btn_classic1.png" selectedImage:@"btn_clssic_s1.png" target:self selector:@selector(goGame)];
        CCMenuItem *timeA = [CCMenuItemImage itemWithNormalImage:@"btn_time1.png" selectedImage:@"btn_timeA_s.png" target:self selector:@selector(goTimeGame)];
        CCMenu *menu = [CCMenu menuWithItems:classic,timeA, nil];
        menu.position = ccp(winsize.width / 2, (winsize.height / 2)-15);
        [menu alignItemsHorizontallyWithPadding:20];
        [self addChild:menu];
    }
    return self;
}
-(void)goGame{
    [SceneManager goGame];
}
-(void)goTimeGame{
    [SceneManager goTimeGame];
}

@end
