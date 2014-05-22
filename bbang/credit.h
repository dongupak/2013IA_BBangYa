//
//  credit.h
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"
@interface credit : CCLayer {
    SimpleAudioEngine *sound;
    SimpleAudioEngine *sound2;

}
+(CCScene *) scene;

@end
