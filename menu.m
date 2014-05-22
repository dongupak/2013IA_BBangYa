//
//  menu.m
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//
#import "menu.h"
#import "AppDelegate.h"
#import "SceneManager.h"

@implementation menu

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    menu *layer = [menu node];
    [scene addChild: layer];
    return scene;
}
-(AppController *)delegate
{
    return (AppController *)[[UIApplication sharedApplication] delegate];
}
-(id) init
{
    if (self=[super init]) {
        AppController *delegate = [self delegate];
        
        CGSize winsize = [[CCDirector sharedDirector] winSize];
        
        delegate.sound = [SimpleAudioEngine sharedEngine];
        
        if (delegate.sound != nil) {
            [delegate.sound preloadBackgroundMusic:@"menusound.mp3"];
        }
        [delegate.sound playBackgroundMusic:@"menusound.mp3" loop:YES];
        
        menuNode = [CCNode node];
        [self addChild:menuNode z:10];
        
        CCSprite *name = [CCSprite spriteWithFile:@"무제-7.png"];
        name.position = ccp(winsize.width / 2, winsize.height+100);
        id moveT = [CCMoveTo actionWithDuration:1.5 position:ccp(winsize.width / 2, winsize.height - 90)];
        id jump = [CCJumpTo actionWithDuration:4 position:ccp(winsize.width / 2, winsize.height - 90) height:40 jumps:4];
        [name runAction:[CCSequence actions:moveT, jump, nil]];
        [self addChild:name z:1];

        CCSprite *bg = [CCSprite spriteWithFile:@"무제-4.png"];
        bg.position = ccp(winsize.width / 2, winsize.height / 2);
        [self addChild:bg z:0];

        CCMenuItem *game = [CCMenuItemImage itemWithNormalImage:@"무제-6.png" selectedImage:@"무제-6.png" target:self selector:@selector(goGame)];
        CCMenuItem *howto = [CCMenuItemImage itemWithNormalImage:@"무제-2.png" selectedImage:@"무제-2.png" target:self selector:@selector(goHowto)];
        CCMenu *menu = [CCMenu menuWithItems:game, howto, nil];
        menu.position = ccp(winsize.width+300, winsize.height / 3.7);
        [menu alignItemsVerticallyWithPadding:5];
        
        id move = [CCMoveTo actionWithDuration:1.4 position:ccp(winsize.width-105, winsize.height / 3.7)];
        [menu runAction:move];
        [menuNode addChild:menu z:10];
        
        CCMenuItem *rank = [CCMenuItemImage itemWithNormalImage:@"gameC.jpeg" selectedImage:@"gameC.jpeg" target:self selector:@selector(goRank)];
        CCMenuItem *credit = [CCMenuItemImage itemWithNormalImage:@"btn_i.png" selectedImage:@"btn_i_s.png" target:self selector:@selector(goCredit)];
        CCMenu *menu2 = [CCMenu menuWithItems:rank, credit, nil];
        menu2.position = ccp(30, winsize.height / 8);
        [menu2 alignItemsVerticallyWithPadding:20];
        [menuNode addChild:menu2];        
    }
	return self;
}
-(void)goGame {
    [SceneManager goSelect];
}
-(void)goHowto {
    [SceneManager goHowto];
}
-(void)goRank {
    [SceneManager goRank];
}
-(void)goCredit {
    [SceneManager goCredit];
}

- (void) dealloc{
    [super dealloc];
}

@end
