//
//  game.m
//  bbang
//
//  Created by Mobile-X on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//
#import "menu.h"
#import "game.h"
#import "SceneManager.h"
#import "AppDelegate.h"
#import "MessageNode.h"

#define FRONT_CLOUD_SIZE 563
#define BACK_CLOUD_SIZE  509
#define FRONT_CLOUD_TOP  310
#define BACK_CLOUD_TOP   230

#define LIFE_MAX 5

@implementation game

@synthesize scoreLabel, score, touchBeganTime, message;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    game *layer = [game node];
    [scene addChild: layer];
    return scene;
}
-(AppController *)delegate
{
    return (AppController *)[[UIApplication sharedApplication] delegate];
}

-(id)init{
    if (self=[super init]) {
        sound2 = [SimpleAudioEngine sharedEngine];
        sound3 = [SimpleAudioEngine sharedEngine];
        
        AppController *delegate = [self delegate];

        [delegate.sound stopBackgroundMusic];
        delegate.gameScore = 0;
        delegate.targetHit = 0;
        delegate.bombHit = 0;
        delegate.gold_targetHit = 0;
        
        CGSize winsize = [[CCDirector sharedDirector] winSize];
        
        self.isTouchEnabled = YES;

        CCSprite *bg = [CCSprite spriteWithFile:@"배경151.png"];
        bg.position = ccp(winsize.width / 2, winsize.height / 2);
        [self addChild:bg z:0];
        
        CCSprite *scoreP = [CCSprite spriteWithFile:@"label_score.png"];
        scoreP.position = ccp(330, winsize.height / 1.103);
        [self addChild:scoreP z:3];
        
        scoreLabel = [[CCLabelTTF alloc] initWithString:@" : 0" fontName:@"Arial Black" fontSize:22];
        scoreLabel.color = ccORANGE;
        scoreLabel.position = ccp(winsize.width / 1.170, 320 / 1.103);
        [self addChild:scoreLabel z:3];
        
        man = [CCSprite spriteWithFile:@"무제-1.png"];
        man.position = ccp(winsize.width / 2, 50);
        [self addChild:man];
        
        targetNode = [CCNode node];
        [self addChild:targetNode z:10];
        lifeNode = [CCNode node];
        [self addChild:lifeNode z:10];
        bulletNode = [CCNode node];
        [self addChild:bulletNode];
        bombNode = [CCNode node];
        [self addChild:bombNode z:10];
        goldNode = [CCNode node];
        [self addChild:goldNode z:10];
        message = [[MessageNode alloc]init];
		[self addChild:message z:30];
        comboMess = [[MessageNode alloc] init];
        [self addChild:comboMess z:30];
    
        life = LIFE_MAX;
        bulletNum=0;
            
        CCMenuItem *pause = [CCMenuItemImage itemWithNormalImage:@"btn_pause.png" selectedImage:@"btn_pause_s.png" target:self selector:@selector(pause)];
        CCMenu *menu = [CCMenu menuWithItems:pause, nil];
        menu.position = ccp(winsize.width / 2, winsize.height-20);
        [self addChild:menu];
        
        [self createGun];
        [self dieAnimateT];
        [self dieAnimateG];
        [self dieAnimateB];
        [self createCloudWithSize:FRONT_CLOUD_SIZE top:FRONT_CLOUD_TOP fileName:@"layer_cloud1.png" interval:15 z:2];
        [self createCloudWithSize:BACK_CLOUD_SIZE  top:BACK_CLOUD_TOP  fileName:@"layer_cloud1.png"  interval:30 z:1];
        [self performSelector:@selector(life)];
        [self performSelector:@selector(makeBullet)];
        [self performSelector:@selector(makeLife)];
        [self performSelector:@selector(comboL)];
        [self performSelector:@selector(Goicon)];
        [self preLoadingEffectSounds];
        [self schedule:@selector(comboCount) interval:1.0];
        
        delegate.combo = 0;
        delegate.comboMAX = 0;
        NSInteger bulletH = (winsize.height / 6.4)+10;
        
        bullet1 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet1.position = ccp(winsize.width - 20, bulletH);
        bullet2 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet2.position = ccp(winsize.width - 20, bulletH+10);
        bullet3 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet3.position = ccp(winsize.width - 20, bulletH+20);
        bullet4 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet4.position = ccp(winsize.width - 20, bulletH+30);
        bullet5 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet5.position = ccp(winsize.width - 20, bulletH+40);
        bullet6 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet6.position = ccp(winsize.width - 20, bulletH+50);
        bullet7 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet7.position = ccp(winsize.width - 20, bulletH+60);
        bullet8 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet8.position = ccp(winsize.width - 20, bulletH+70);
        bullet9 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet9.position = ccp(winsize.width - 20, bulletH+80);
        bullet10 = [CCSprite spriteWithFile:@"icon_bulle1.png"];
        bullet10.position = ccp(winsize.width - 20, bulletH+90);
        [bulletNode addChild:bullet1];
        [bulletNode addChild:bullet2];
        [bulletNode addChild:bullet3];
        [bulletNode addChild:bullet4];
        [bulletNode addChild:bullet5];
        [bulletNode addChild:bullet6];
        [bulletNode addChild:bullet7];
        [bulletNode addChild:bullet8];
        [bulletNode addChild:bullet9];
        [bulletNode addChild:bullet10];
        
        CCMenuItem *reroad = [CCMenuItemImage itemWithNormalImage:@"icon_reroad.png" selectedImage:@"icon_reroad.png" target:self selector:@selector(charge)];
        Rmenu = [CCMenu menuWithItems:reroad, nil];
        Rmenu.position = ccp(winsize.width - 20, 30);
        [self addChild:Rmenu z:30];
        
    }
    return self;
}
-(void)comboCount{
    AppController *delegate = [self delegate];

    if (delegate.comboMAX > delegate.combo) {
        
    }
    else if (delegate.comboMAX < delegate.combo){
        delegate.comboMAX = delegate.combo;
        NSLog(@"%d", delegate.combo);
        NSLog(@"%d", delegate.comboMAX);
    }
}
-(void)preLoadingEffectSounds
{
	sound = [SimpleAudioEngine sharedEngine];
    [sound preloadEffect:@"reloadBullet.wav"];
    [sound preloadEffect:@"oooh_laugh.wav"];
    [sound preloadEffect:@"plate.wav"];
    [sound preloadEffect:@"shotgun.mp3"];
}
-(void)Goicon{
    CGSize winsize = [[CCDirector sharedDirector] winSize];
    CCSprite *gamestart = [CCSprite spriteWithFile:@"label_start.png"];
    gamestart.position = ccp(-150, winsize.height / 2);
    
    CCMoveBy *move = [CCMoveBy actionWithDuration:1 position:ccp((winsize.width / 2)+150, 0)];
    CCCallFuncN *gamelogic = [CCCallFuncN actionWithTarget:self selector:@selector(startG)];
    CCCallFuncN *soundE = [CCCallFuncN actionWithTarget:self selector:@selector(whistle)];
    CCSequence *startact = [CCSequence actions:move,soundE,[CCDelayTime actionWithDuration:0.5],[move copy],gamelogic, nil];
    [gamestart runAction:startact];
    [self addChild:gamestart];
}
-(void)whistle{
    [sound playEffect:@"whistle.wav"];
}
-(void)startG{
    if (sound2 != nil) {
        [sound2 preloadBackgroundMusic:@"gamesound.mp3"];
    }
    [sound2 playBackgroundMusic:@"gamesound.mp3" loop:YES];
    sound2.backgroundMusicVolume = 1;
    
    [self schedule:@selector(gameLogic:) interval:1.0];
}


-(void)comboL{
    CGSize winsize = [[CCDirector sharedDirector] winSize];

    CCLabelAtlas *sco = [CCLabelAtlas labelWithString:@"0" charMapFile:@"score_number.png" itemWidth:20 itemHeight:28 startCharMap:'0'];
    self.scoreNumSprite = sco;
    [sco release];
    self.scoreNumSprite.position = ccp(winsize.width / 2.5, winsize.height/1.7);
    [self addChild:self.scoreNumSprite z:30];
    [sco runAction:[CCFadeTo actionWithDuration:0.01 opacity:0]];
	[sco runAction:[CCSequence actions:
					   [CCFadeTo actionWithDuration:0.1 opacity:250],
					   [CCDelayTime actionWithDuration:0.2],
					   [CCFadeTo actionWithDuration:0.1 opacity:0],
					   nil]];
}
-(void)pause{
    CGSize winsize = [[CCDirector sharedDirector] winSize];
    sound2.backgroundMusicVolume = 0.0;
    [[CCDirector sharedDirector] pause];
    targetNode.visible = NO;
    bombNode.visible = NO;
    goldNode.visible = NO;
    id fade = [CCFadeOut actionWithDuration:.5];
    CCMenuItem *resume = [CCMenuItemImage itemWithNormalImage:@"label_return2.png" selectedImage:@"label_return2.png" target:self selector:@selector(resume)];
    CCMenuItem *back = [CCMenuItemImage itemWithNormalImage:@"label_home.png" selectedImage:@"label_home.png" target:self selector:@selector(goBack)];
    menuP = [CCMenu menuWithItems:resume, back, nil];
    menuP.position = ccp(winsize.width/2, winsize.height/2);
    [menuP alignItemsHorizontallyWithPadding:50];
    [menuP runAction:fade];
    [self addChild:menuP z:20];
}
-(void)goBack {
    sound2.backgroundMusicVolume = 1;
    [[CCDirector sharedDirector] resume];
    [SceneManager goMenu];
}
-(void)resume{
    sound2.backgroundMusicVolume = 1;
    [[CCDirector sharedDirector] resume];
    targetNode.visible = YES;
    bombNode.visible = YES;
    goldNode.visible = YES;
    id fade = [CCFadeIn actionWithDuration:.5];
    [menuP runAction:fade];
    menuP.visible = NO;
}
- (void)createCloudWithSize:(int)imgSize top:(int)imgTop fileName:(NSString*)fileName interval:(int)interval z:(int)z {
    //구름의 애니매이션
    id enterRight	= [CCMoveTo actionWithDuration:interval position:ccp(0, imgTop)];
    id enterRight2	= [CCMoveTo actionWithDuration:interval position:ccp(0, imgTop)];
    id exitLeft		= [CCMoveTo actionWithDuration:interval position:ccp(-imgSize, imgTop)];
    id exitLeft2	= [CCMoveTo actionWithDuration:interval position:ccp(-imgSize, imgTop)];
    id reset		= [CCMoveTo actionWithDuration:0  position:ccp( imgSize, imgTop)];
    id reset2		= [CCMoveTo actionWithDuration:0  position:ccp( imgSize, imgTop)];
    id seq1			= [CCSequence actions: exitLeft, reset, enterRight, nil];
    id seq2			= [CCSequence actions: enterRight2, exitLeft2, reset2, nil];
    CCSprite *spCloud1 = [CCSprite spriteWithFile:fileName];
    [spCloud1 setAnchorPoint:ccp(0,1)];
    [spCloud1.texture setAliasTexParameters];
    [spCloud1 setPosition:ccp(0, imgTop)];
    [spCloud1 runAction:[CCRepeatForever actionWithAction:seq1]];
    [self addChild:spCloud1 z:2 ];
    CCSprite *spCloud2 = [CCSprite spriteWithFile:fileName];
    [spCloud2 setAnchorPoint:ccp(0,1)];
    [spCloud2.texture setAliasTexParameters];
    [spCloud2 setPosition:ccp(imgSize, imgTop)];
    [spCloud2 runAction:[CCRepeatForever actionWithAction:seq2]];
    [self addChild:spCloud2 z:1 ];
}

-(void)makeLife{
    CGSize winsize = [[CCDirector sharedDirector] winSize];
    NSInteger lifeW = winsize.width / 24;
    
    life1 = [CCSprite spriteWithFile:@"icon_heart.png"];
    life1.position = ccp(lifeW, winsize.height - 20);
    life2 = [CCSprite spriteWithFile:@"icon_heart.png"];
    life2.position = ccp(lifeW+30, winsize.height - 20);
    life3 = [CCSprite spriteWithFile:@"icon_heart.png"];
    life3.position = ccp(lifeW+60, winsize.height - 20);
    life4 = [CCSprite spriteWithFile:@"icon_heart.png"];
    life4.position = ccp(lifeW+90, winsize.height - 20);
    life5 = [CCSprite spriteWithFile:@"icon_heart.png"];
    life5.position = ccp(lifeW+120, winsize.height - 20);
    
    [lifeNode addChild:life1 z:3];
    [lifeNode addChild:life2 z:3];
    [lifeNode addChild:life3 z:3];
    [lifeNode addChild:life4 z:3];
    [lifeNode addChild:life5 z:3];
    
}
-(void)makeBullet{
    bullet1.visible = YES;
    bullet2.visible = YES;
    bullet3.visible = YES;
    bullet4.visible = YES;
    bullet5.visible = YES;
    bullet6.visible = YES;
    bullet7.visible = YES;
    bullet8.visible = YES;
    bullet9.visible = YES;
    bullet10.visible = YES;
    
}
-(void)reroad{
    if (bulletNum == 0) {
        bullet1.visible = YES;
        bullet2.visible = YES;
        bullet3.visible = YES;
        bullet4.visible = YES;
        bullet5.visible = YES;
        bullet6.visible = YES;
        bullet7.visible = YES;
        bullet8.visible = YES;
        bullet9.visible = YES;
        bullet10.visible = YES;
    }
    
    if (bulletNum == 1) {
        bullet1.visible = NO;
    }
    else if (bulletNum == 2){
        bullet2.visible = NO;
    }
    else if (bulletNum == 3){
        bullet3.visible = NO;
    }
    else if (bulletNum == 4){
        bullet4.visible = NO;
    }
    else if (bulletNum == 5){
        bullet5.visible = NO;
    }
    else if (bulletNum == 6){
        bullet6.visible = NO;
    }
    else if (bulletNum == 7){
        bullet7.visible = NO;
    }
    else if (bulletNum == 8){
        bullet8.visible = NO;
    }
    else if (bulletNum == 9){
        bullet9.visible = NO;
    }
    else if (bulletNum == 10){
        bullet10.visible = NO;
        [self performSelector:@selector(reroadAlert)];
    }
}

-(void)reroadAlert{
    CGSize winsize = [[CCDirector sharedDirector] winSize];
    
    alert = [CCSprite spriteWithFile:@"reload_message.png"];
    alert.position = ccp(winsize.width / 2, winsize.height / 2);
    [self addChild:alert];
    id action = [CCBlink actionWithDuration:3 blinks:10];
    [alert runAction:[CCRepeatForever actionWithAction:action]];
}

-(void)charge{
    [sound playEffect:@"reloadBullet.wav"];
    [self performSelector:@selector(makeBullet)];
    alert.opacity = 0;
    bulletNum = 0;
}


-(void) lifeAct {
    id fade = [CCFadeOut actionWithDuration:1];
    id rot = [CCRotateTo actionWithDuration:1 angle:2700];
    if (life >=1) {
        if (life == 4) {
            [life5 runAction:[CCSpawn actions:fade, rot, nil]];
            [self performSelector:@selector(life) withObject:life5 afterDelay:1];
        }
        else if (life == 3) {
            [life4 runAction:[CCSpawn actions:fade, rot, nil]];
            [self performSelector:@selector(life) withObject:life4 afterDelay:1];
        }
        else if (life == 2) {
            [life3 runAction:[CCSpawn actions:fade, rot, nil]];
            [self performSelector:@selector(life) withObject:life3 afterDelay:1];
        }
        else if (life == 1){
            [life2 runAction:[CCSpawn actions:fade, rot, nil]];
            [self performSelector:@selector(life) withObject:life2 afterDelay:1];
        }
    }
    else if (life == 0){
            [life1 runAction:[CCSpawn actions:fade, rot, nil]];
            [self performSelector:@selector(life) withObject:life1 afterDelay:1];
            [self overA];
    }
}


-(void) life {
    
    if (life >=1) {
        if (life == 4) {
            life5.opacity = 0;
        }
        else if (life == 3) {
            life4.opacity = 0;        }
        else if (life == 2) {
            life3.opacity = 0;        }
        else if (life == 1){
            life2.opacity = 0;        }
    }
    else if (life == 0){
            life1.opacity = 0;
            [self overA];
    }
}
-(void)gameLogic:(ccTime)dt{
    AppController *delegate = [self delegate];
    if (life==0) {
        
    }
    else if (life >=0){
    time = arc4random()%3+1;
    [self schedule:@selector(gameLogic:) interval:time];
    if (delegate.gameScore<200) {
        [self makeTarget];
    }
    else if (delegate.gameScore>200 && delegate.gameScore<800){
        [self makeTarget];
        [self makeTarget];
    }else if (delegate.gameScore>800 && delegate.gameScore<1500){
        [self makeTarget];
        [self makeTarget];
        [self makeTarget];
    }
    else if (delegate.gameScore>1500){
        [self makeTarget];
        [self makeTarget];
        [self makeTarget];
        [self makeTarget];
    }
    }
}
-(void)makeTarget {
    
    NSInteger random = arc4random()%20;
    double timeB = (arc4random()%3)+1.5;
    ccBezierConfig bezier1;
    
    NSInteger startW = -80;
    int startH = (arc4random()%180)+50;
    
    NSInteger midW = (arc4random()%250)+30;
    NSInteger midH = (arc4random()%200)+30;
    
    NSInteger endW = 600;
    NSInteger endH = (arc4random()%180);
    
    
    bezier1.controlPoint_1 = ccp(-startW, startH);
    bezier1.controlPoint_2 = ccp(midW, midH);
    bezier1.endPosition = ccp(endW, endH);
    
    id bezier = [CCBezierBy actionWithDuration:timeB bezier:bezier1];
    NSInteger birdTime = 2.5;
    id bezierBird = [CCBezierBy actionWithDuration:birdTime bezier:bezier1];
    if (random == 3 || random == 5) {
        bomb = [CCSprite spriteWithFile:@"fly1.png"];
        bomb.position = ccp(-50, 100);
        [bombNode addChild:bomb];
        CCAnimation *animation = [[CCAnimation alloc] init];
        NSString *fileName = [[NSString alloc] init];
        for(int i = 1; i < 5; ++i) {
            fileName = [NSString stringWithFormat:@"fly%d.png",i];
            [animation addSpriteFrameWithFilename:fileName];
        }
        [animation setDelayPerUnit:0.1];
        CCAnimate *animateR = [CCAnimate actionWithAnimation:animation];
        [bomb runAction:[CCRepeatForever actionWithAction:animateR]];
        [bomb runAction:bezierBird];
    }
    else if(random==2 || random == 4){
        gold_target = [CCSprite spriteWithFile:@"icon_goldplate.png"];
        gold_target.position = ccp(-50, 100);
        [goldNode addChild:gold_target];
        [gold_target runAction:bezier];
    }
    else{
        target = [CCSprite spriteWithFile:@"icon_plate.png"];
        target.position = ccp(-50, 100);
        [targetNode addChild:target];
        [target runAction:bezier];
    }
    [self schedule:@selector(callEveryFrame:)];
}


-(void) callEveryFrame:(ccTime)dt {
    AppController *delegate = [self delegate];

    CGSize size = [[CCDirector sharedDirector] winSize];
    for (CCSprite *tar in [targetNode children]){
        if (tar.position.x>size.width + tar.contentSize.width/2) {
            [message showMessage:MISS_MESSAGE];
            [targetNode removeChild:tar cleanup:YES];
            life -= 1;
            
            delegate.combo = 0;
            [self performSelector:@selector(lifeAct)];
        }
    }
    for (CCSprite *gold in [goldNode children]) {

        
        if (gold.position.x>size.width + gold.contentSize.width/2) {
            [message showMessage:MISS_MESSAGE];
            [goldNode removeChild:gold cleanup:YES];
            life -= 1;
             delegate.combo = 0;
            [self performSelector:@selector(lifeAct)];
        }
    }
}
-(void)onEnter{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    AppController *delegate = [self delegate];    
    if (bulletNum <10) {
        [sound playEffect:@"shotgun.mp3"];
    }
    if (bulletNum >= 10){
        [sound playEffect:@"switch.wav"];
        sound.effectsVolume = 3.0;
    }
    bulletNum++;
    [self performSelector:@selector(reroad)];
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    double ax = convertedLocation.x - 240;
    double ay = convertedLocation.y - 10;
    double rad = atan2(ax, ay);
    double ang = (rad*180)/3.14;
    if (ang>37) {
        id rot = [CCRotateTo actionWithDuration:0.1 angle:37.1741];
        [man runAction:rot];
    }
    else if(ang<-50.931){
        id rot = [CCRotateTo actionWithDuration:0.1 angle:-50.93];
        [man runAction:rot];
    }
    else{
        id rot = [CCRotateTo actionWithDuration:0.1 angle:ang];
        [man runAction:rot];
    }
    
    for (CCSprite *tar in [targetNode children]) {
        if (CGRectContainsPoint([tar boundingBox], convertedLocation)) {
            self.touchBeganTime = [NSDate date];
            if (bulletNum<=10) {
                 delegate.combo+=1;
                delegate.targetHit+=1;
                [sound playEffect:@"plate.wav"];
                sound.effectsVolume = 0.5;
                [message showMessage:CORRECT_MESSAGE];
                if ( delegate.combo == 0 ||  delegate.combo == 1) {
                     delegate.gameScore += 10;
                    NSString *str = [[NSString alloc] initWithFormat:@": %d", delegate.gameScore];
                    [scoreLabel setString:str];
                }
                if ( delegate.combo>=2) {
                    delegate.gameScore += 10* delegate.combo;
                    NSString *str = [[NSString alloc] initWithFormat:@": %d", delegate.gameScore];
                    [scoreLabel setString:str];
                    [comboMess showMessage:COMBO_MESSAGE];
                    [self.scoreNumSprite setString:[NSString stringWithFormat:@"%d",  delegate.combo]];
                    [self.scoreNumSprite runAction:[CCFadeTo actionWithDuration:0.01 opacity:0]];
                    [self.scoreNumSprite runAction:[CCSequence actions:
                                       [CCFadeTo actionWithDuration:0.1 opacity:250],
                                       [CCDelayTime actionWithDuration:0.2],
                                       [CCFadeTo actionWithDuration:0.1 opacity:0],
                                       nil]];
                }
                [self dieT:convertedLocation];
                [self performSelector:@selector(removeT:) withObject:tar];
            }
        }
    }
    for (CCSprite *bom in [bombNode children]) {
        if (CGRectContainsPoint([bom boundingBox], convertedLocation)) {
            self.touchBeganTime = [NSDate date];
            if (bulletNum<=10) {
                [sound playEffect:@"oooh_laugh.wav"];
                sound.effectsVolume = 0.5;
                delegate.bombHit += 1;
                [message showMessage:MISS_MESSAGE];
                [self dieB:convertedLocation];
                [bombNode removeChild:bom cleanup:YES];
                life -= 1;
                 delegate.combo = 0;
                [self performSelector:@selector(lifeAct)];
                [self performSelector:@selector(removeB:) withObject:bom];
            }
        }
    }
    for (CCSprite *gold in [goldNode children]) {
        if (CGRectContainsPoint([gold boundingBox], convertedLocation)) {
            self.touchBeganTime = [NSDate date];
            if (bulletNum<=10) {
                 delegate.combo +=1;
                delegate.gold_targetHit += 1;
                [sound playEffect:@"plate.wav"];
                sound.effectsVolume = 0.5;
                [message showMessage:BONUS_MESSAGE];
                if ( delegate.combo == 0 ||  delegate.combo == 1) {
                    delegate.gameScore += 10;
                    NSString *str = [[NSString alloc] initWithFormat:@": %d", delegate.gameScore];
                    [scoreLabel setString:str];
                }
                if ( delegate.combo>=2) {
                    delegate.gameScore += 10* delegate.combo;
                    NSString *str = [[NSString alloc] initWithFormat:@": %d", delegate.gameScore];
                    [scoreLabel setString:str];
                    [comboMess showMessage:COMBO_MESSAGE];
                    [self.scoreNumSprite setString:[NSString stringWithFormat:@"%d",  delegate.combo]];
                    [self.scoreNumSprite runAction:[CCFadeTo actionWithDuration:0.01 opacity:0]];
                    [self.scoreNumSprite runAction:[CCSequence actions:
                                                    [CCFadeTo actionWithDuration:0.1 opacity:250],
                                                    [CCDelayTime actionWithDuration:0.2],
                                                    [CCFadeTo actionWithDuration:0.1 opacity:0],
                                                    nil]];
                }
                [self dieG:convertedLocation];
                [self performSelector:@selector(removeG:) withObject:gold];
                [self performSelector:@selector(lifeAct2)];
                
            }
        }
    }
    if (bulletNum<10)
        [self bang: convertedLocation];
    
    return self;
}
-(void) lifeAct2 {
    id fade = [CCFadeIn actionWithDuration:1];
    id rot = [CCRotateTo actionWithDuration:1 angle:3600];
        if (life == 4) {
            [life5 runAction:[CCSpawn actions:fade, rot, nil]];
            life5.opacity = 1;
            life += 1;
        }
        else if (life == 3) {
            [life4 runAction:[CCSpawn actions:fade, rot, nil]];
            life4.opacity = 1;
            life += 1;        }
        else if (life == 2) {
            [life3 runAction:[CCSpawn actions:fade, rot, nil]];
            life3.opacity = 1;
            life += 1;        }
        else if (life == 1){
            [life2 runAction:[CCSpawn actions:fade, rot, nil]];
            life2.opacity = 1;
            life += 1;        }
}
-(void) dieAnimateT{
    die = [[CCSprite alloc] init];
    [self addChild:die z:22];

    CCAnimation *animation = [[CCAnimation alloc] init];
    NSString *fileName = [[NSString alloc] init];
    for(int i = 1; i < 8; ++i) {
        fileName = [NSString stringWithFormat:@"ani_plate%d.png",i];
        [animation addSpriteFrameWithFilename:fileName];
    }
    [animation setDelayPerUnit:0.1];
    animateT = [[CCAnimate alloc] initWithAnimation:animation];
}
-(void) dieAnimateG{
    die = [[CCSprite alloc] init];
    [self addChild:die z:22];
    
    CCAnimation *animation = [[CCAnimation alloc] init];
    NSString *fileName = [[NSString alloc] init];
    for(int i = 1; i < 8; ++i) {
        fileName = [NSString stringWithFormat:@"ani_goldplate%d.png",i];
        [animation addSpriteFrameWithFilename:fileName];
    }
    [animation setDelayPerUnit:0.1];
    animateG = [[CCAnimate alloc] initWithAnimation:animation];
}
-(void) dieAnimateB{
    die = [[CCSprite alloc] init];
    [self addChild:die z:22];
    
    CCAnimation *animation = [[CCAnimation alloc] init];
    NSString *fileName = [[NSString alloc] init];
    for(int i = 1; i < 15; ++i) {
        fileName = [NSString stringWithFormat:@"tail%d.png",i];
        [animation addSpriteFrameWithFilename:fileName];
    }
    [animation setDelayPerUnit:0.1];
    animateB = [[CCAnimate alloc] initWithAnimation:animation];
}
-(void)dieT:(CGPoint)location{
    [die setPosition:location];
    if (![animateT isDone]) [die stopAction:animateT];
    [die runAction:animateT];
}
-(void)dieG:(CGPoint)location{
    [die setPosition:location];
    if (![animateG isDone]) [die stopAction:animateG];
    [die runAction:animateG];
}
-(void)dieB:(CGPoint)location{
    [die setPosition:location];
    if (![animateB isDone]) [die stopAction:animateB];
    [die runAction:animateB];
}
- (void)createGun {
    gunSmoke = [[CCSprite alloc] init];
    [self addChild:gunSmoke z:21];

    CCAnimation *animation = [[CCAnimation alloc] init];
    NSString *fileName = [[NSString alloc] init];
    for(int i = 1; i < 5; ++i) {
        fileName = [NSString stringWithFormat:@"bang%d.png",i];
        [animation addSpriteFrameWithFilename:fileName];
    }
    [animation setDelayPerUnit:0.1];
    smokeAnimate = [[CCAnimate alloc] initWithAnimation:animation];
}
- (void)bang:(CGPoint)location  {
    [gunSmoke setPosition:location];
    if (![smokeAnimate isDone]) [gunSmoke stopAction:smokeAnimate];
    [gunSmoke runAction:smokeAnimate];
}
-(void)removeT:(id) tar {
    [targetNode removeChild:tar cleanup:YES];
}
-(void)removeG:(id) gold {
    [goldNode removeChild:gold cleanup:YES];
}
-(void)removeB:(id) bom {
    [bombNode removeChild:bom cleanup:YES];
}
-(void)overA{
    [self stopAllActions];
    CCSprite *overA = [CCSprite spriteWithFile:@"label_gameover.png"];
    overA.position = ccp(240, 160);
    id action = [CCFadeIn actionWithDuration:1];
    [overA runAction:action];
    [self addChild:overA z:100];
    [self performSelector:@selector(goOver) withObject:self afterDelay:3];
}
-(void)goOver{
    [SceneManager goGameOver];
}
- (void) dealloc
{
	[super dealloc];
}
@end
