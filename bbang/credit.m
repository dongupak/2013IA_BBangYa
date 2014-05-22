//
//  credit.m
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "credit.h"
#import "SceneManager.h"


@implementation credit

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    credit *layer = [credit node];
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

        sound = [SimpleAudioEngine sharedEngine];
        sound2 = [SimpleAudioEngine sharedEngine];
        
        [delegate.sound stopBackgroundMusic];
        CCSprite *bg = [CCSprite spriteWithFile:@"cred.png"];
        bg.position = ccp(240, 160);
        [self addChild:bg];
        
        CCSprite *bg1 = [CCSprite spriteWithFile:@"layer_credit.png"];
        bg1.position = ccp(240, 160);
        [self addChild:bg1];
        
        
        CCMenuItem *back = [CCMenuItemImage itemWithNormalImage:@"btn_homeIcon.png" selectedImage:@"btn_homeIcon.png" target:self selector:@selector(goBack)];
        CCMenu *menu = [CCMenu menuWithItems:back, nil];
        [menu alignItemsVertically];
        menu.position = ccp(250, 30);
        [self addChild:menu];
        
        [self performSelector:@selector(BGM)];
     }
    return self;
}
-(void)BGM{
    if (sound2 != nil) {
        [sound2 preloadBackgroundMusic:@"creditsound.mp3"];
    }
    [sound2 playBackgroundMusic:@"creditsound.mp3"
     loop:YES];
}
-(void)goBack {
    [sound2 stopBackgroundMusic];
    [SceneManager goMenu];
}
@end
