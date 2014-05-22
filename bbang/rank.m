//
//  rank.m
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "rank.h"
#import "SceneManager.h"
#import "AppDelegate.h"

@implementation rank

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    rank *layer = [rank node];
    [scene addChild: layer];
    return scene;
}
-(id)init{
    if((self = [super init]))
    {
        
    }
    return self;
}

@end

