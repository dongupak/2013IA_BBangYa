//
//  AppDelegate.h
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@class RootViewController;

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
    NSInteger       gameScore;
    SimpleAudioEngine *sound;
    
    NSInteger targetHit;
    NSInteger gold_targetHit;
    NSInteger bombHit;
    NSInteger combo;
    NSInteger comboMAX;
    

    RootViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (readwrite) NSInteger gameScore;
@property (retain) SimpleAudioEngine *sound;
@property (readwrite) NSInteger targetHit;
@property (readwrite) NSInteger gold_targetHit;
@property (readwrite) NSInteger bombHit;
@property (readwrite) NSInteger combo;
@property (readwrite) NSInteger comboMAX;

@end
