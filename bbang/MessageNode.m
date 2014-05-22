//
//  MessageNode.m
//  bbang
//
//  Created by Mobile-X on 13. 6. 4..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "MessageNode.h"
#import "game.h"
#import "timeGame.h"

@implementation MessageNode

int const MISS_MESSAGE = 0;
int const CORRECT_MESSAGE = 1;
int const BONUS_MESSAGE = 2;
int const COMBO_MESSAGE = 3;
@synthesize miss, correct, bonus, combo;

-(AppController *)delegate
{
    return (AppController *)[[UIApplication sharedApplication] delegate];
}
-(id) init {
	self = [super init];
	if (self) {
        CGSize winsize = [[CCDirector sharedDirector] winSize];
        AppController *delegate = [self delegate];

		CCSprite *m = [[CCSprite alloc] initWithFile:@"miss.png"];
		self.miss = m;
		[m release];
		[self addChild:miss z:30];
		
		CCSprite *c = [[CCSprite alloc] initWithFile:@"hit.png"];
		self.correct = c;
		[c release];
		[self addChild:correct z:30];
		
		CCSprite *b = [[CCSprite alloc] initWithFile:@"bonus.png"];
		self.bonus = b;
		[b release];
		[self addChild:bonus z:30];
        
        CCSprite *cb = [[CCSprite alloc] initWithFile:@"label_combo.png"];
        self.combo = cb;
        [cb release];
        [self addChild:combo z:30];
        
		miss.position = ccp(winsize.width / 2, winsize.height / 1.23);
		correct.position = ccp(winsize.width / 2, winsize.height / 1.23);
		bonus.position = ccp(winsize.width / 2, winsize.height / 1.23);
        combo.position = ccp(winsize.width / 2+35, winsize.height / 1.6);
		
		[correct runAction:[CCFadeOut actionWithDuration:0.0]];
		[miss runAction:[CCFadeOut actionWithDuration:0.0]];
		[bonus runAction:[CCFadeOut actionWithDuration:0.0]];
        [combo runAction:[CCFadeOut actionWithDuration:0.0]];
	}
	
	return self;
}
- (void) showMessage:(int) message
{
	CCSprite *sprite;
	
	if(message == MISS_MESSAGE)
	{
		sprite = miss;
		missVisible = YES;
	}else if(message == CORRECT_MESSAGE)
	{
		sprite = correct;
		correctVisible = YES;
	}else if(message == BONUS_MESSAGE)
	{
		sprite = bonus;
		bonusVisible = YES;
	}else if(message == COMBO_MESSAGE)
	{
		sprite = combo;
		comboVisible = YES;
	}
	
	[sprite runAction:[CCFadeTo actionWithDuration:0.01 opacity:0]];
	[sprite runAction:[CCSequence actions:
					   [CCFadeTo actionWithDuration:0.1 opacity:250],
					   [CCDelayTime actionWithDuration:0.2],
					   [CCFadeTo actionWithDuration:0.1 opacity:0],
					   nil]];    
}

- (void) dealloc
{
	[correct release];
	[miss release];
	[bonus release];
    [combo release];
	[super dealloc];
}

@end

