//
//  SceneManager.h
//  GNCatch
//
//  Created by MajorTom on 9/7/10.
//  Copyright iphonegametutorials.com 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "game.h"
#import "howto.h"
#import "rank.h"
#import "credit.h"
#import "menu.h"
#import "over.h"
#import "selectGame.h"
#import "timeGame.h"
// SceneManager 클래스로 Menu, Game, GameOver, Credit Layer로의 
// 전환을 담당하는 역할을 한다
@interface SceneManager : NSObject {
}

// goXXX의 경우 정적 메소드임. 
+(void) goMenu;
+(void) goGame;
+(void) goGameOver;
+(void) goCredit;
+(void) goHowto;
+(void) goRank;
+(void) goTimeGame;
+(void) goSelect;

+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString ofDelay:(float)t;
+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString;
+(void) go:(CCLayer *)layer;

@end
