//
//  over.h
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface over : CCLayer {
    NSInteger myScore;
    NSInteger hitT;
    NSInteger hitG;
    NSInteger hitB;
    NSInteger max_combo;
    
    SimpleAudioEngine *sound;
}
+(CCScene *) scene;
@end
