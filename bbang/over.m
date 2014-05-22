//
//  over.m
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "over.h"
#import "SceneManager.h"
#import "AppDelegate.h"


@implementation over

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    over *layer = [over node];
    [scene addChild: layer];
    return scene;
}
-(AppController *)delegate
{
    return (AppController *)[[UIApplication sharedApplication] delegate];
}
-(id)init{
    if (self=[super init]) {
        AppController *delegate = [self delegate];

        CCSprite *bg = [CCSprite spriteWithFile:@"layer_gameover.png"];
        bg.position = ccp(240, 160);
        [self addChild:bg z:0];
        
        delegate.sound = [SimpleAudioEngine sharedEngine];
        CCMenuItem *back = [CCMenuItemImage itemWithNormalImage:@"btn_homeIcon.png" selectedImage:@"btn_homeIcon.png" target:self selector:@selector(goBack)];
        CCMenu *menu = [CCMenu menuWithItems:back, nil];
        menu.position = ccp(250, 20);
        [self addChild:menu z:1];

        myScore = delegate.gameScore;
        hitB = delegate.bombHit;
        hitG = delegate.gold_targetHit;
        hitT = delegate.targetHit;
        max_combo = delegate.comboMAX;
        
        NSString *str = [NSString stringWithFormat:@"%d", myScore];
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:str dimensions:CGSizeMake(100, 100) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeCharacterWrap fontName:@"Arial" fontSize:20];
        scoreLabel.position = ccp(190, 170.5);
        [self addChild:scoreLabel z:1];
        
        NSString *strC = [NSString stringWithFormat:@"%d Combo", max_combo];
        CCLabelTTF *comboLabel = [CCLabelTTF labelWithString:strC dimensions:CGSizeMake(30, 30) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeCharacterWrap fontName:@"Arial" fontSize:20];
        comboLabel.position = ccp(195, 170);
        [self addChild:comboLabel z:1];
        
        NSString *strB = [NSString stringWithFormat:@"%d", hitB];
        CCLabelTTF *B_hit = [CCLabelTTF labelWithString:strB dimensions:CGSizeMake(30, 30) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeCharacterWrap fontName:@"Arial" fontSize:20];
        B_hit.position = ccp(185, 74);
        [self addChild:B_hit z:1];
        
        NSString *strT = [NSString stringWithFormat:@"%d", hitT];
        CCLabelTTF *T_hit = [CCLabelTTF labelWithString:strT dimensions:CGSizeMake(30, 30) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeCharacterWrap fontName:@"Arial" fontSize:20];
        T_hit.position = ccp(285, 74);
        [self addChild:T_hit z:1];

        NSString *strG = [NSString stringWithFormat:@"%d", hitG];
        CCLabelTTF *G_hit = [CCLabelTTF labelWithString:strG dimensions:CGSizeMake(30, 30) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeCharacterWrap fontName:@"Arial" fontSize:20];
        G_hit.position = ccp(390, 74);
        [self addChild:G_hit z:1];
    }
    return self;
}
-(void)goBack {
    AppController *delegate = [self delegate];

    [SceneManager goMenu];
    if (delegate.sound != nil) {
        [delegate.sound preloadBackgroundMusic:@"menusound.mp3"];
    }
    [delegate.sound playBackgroundMusic:@"menusound.mp3" loop:YES];
}
@end
