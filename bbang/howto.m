//
//  howto.m
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "howto.h"
#import "SceneManager.h"


@implementation howto

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    howto *layer = [howto node];
    [scene addChild: layer];
    return scene;
}
-(id)init{
    if (self=[super init]) {
        howtoScene1 = [CCSprite node];

        howtoScene1 = [CCSprite spriteWithFile:@"layer_bgH.png"];
        howtoScene1.position = ccp(240, 160);
        [self addChild:howtoScene1];
        
        howtoW1 = [CCSprite node];
        CGSize parentSize;
        parentSize = howtoScene1.contentSize;
        howtoW1 = [CCSprite spriteWithFile:@"layer_howto1.png"];
        howtoW1.position = ccp(parentSize.width/2, parentSize.height/2);
        [howtoScene1 addChild:howtoW1];
        
        CCMenuItem *next = [CCMenuItemImage itemWithNormalImage:@"label_next.png" selectedImage:@"label_next.png" target:self selector:@selector(next)];
        CCMenu *menu1 = [CCMenu menuWithItems:next, nil];
        menu1.position = ccp(parentSize.width-30, 30);
        [howtoScene1 addChild:menu1];
        
        howtoScene2 = [CCSprite node];
        howtoScene2 = [CCSprite spriteWithFile:@"layer_bgH.png"];
        howtoScene2.position = ccp(960, 160);
        [self addChild:howtoScene2];
        
        howtoW2 = [CCSprite node];
        CGSize parent2Size;
        parent2Size = howtoScene2.contentSize;
        howtoW2 = [CCSprite spriteWithFile:@"layer_howto2.png"];
        howtoW2.position = ccp(parent2Size.width/2, parent2Size.height/2);
        [howtoScene2 addChild:howtoW2];
        
        CCMenuItem *pre = [CCMenuItemImage itemWithNormalImage:@"label_back.png" selectedImage:@"label_back.png" target:self selector:@selector(preview)];
        CCMenu *menu2 = [CCMenu menuWithItems:pre, nil];
        menu2.position = ccp(parent2Size.width-30, 30);
        [howtoScene2 addChild:menu2];
        
        
        CCMenuItem *back = [CCMenuItemImage itemWithNormalImage:@"btn_homeIcon.png" selectedImage:@"btn_homeIcon.png" target:self selector:@selector(goBack)];
        CCMenu *menu = [CCMenu menuWithItems:back, nil];
        [menu alignItemsVertically];
        menu.position = ccp(250, 30);
        [self addChild:menu];
        
    }
    return self;
}

-(void)next{
    id moveNextPage = [CCMoveBy actionWithDuration:0.5 position:ccp(-480, 0)];
    [howtoScene1 runAction:moveNextPage];
    [self performSelector:@selector(moveHow2)];
}
-(void)moveHow2{
    id move = [CCMoveTo actionWithDuration:.5 position:ccp(240, 160)];
    [howtoScene2 runAction:move];
}

-(void)preview{
    id movePrePage = [CCMoveBy actionWithDuration:.5 position:ccp(480, 0)];
    [howtoScene2 runAction:movePrePage];
    [self performSelector:@selector(moveHow1)];
}
-(void)moveHow1{
    id move = [CCMoveTo actionWithDuration:.5 position:ccp(240, 160)];
    [howtoScene1 runAction:move];
}

-(void)goBack {
    [SceneManager goMenu];
}
@end
