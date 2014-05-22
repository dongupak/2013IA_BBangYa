//
//  howto.h
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface howto : CCLayer {
    SimpleAudioEngine *sound;
    CCSprite *howtoScene1;
    CCSprite *howtoScene2;
    CCSprite *howtoW1;
    CCSprite *howtoW2;

}
+(CCScene *) scene;

@end
