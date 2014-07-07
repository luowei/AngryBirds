//
//  SpriteBase.m
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "SpriteBase.h"

@implementation SpriteBase

@synthesize HP;

-(id) initWithX:(float)x andY:(float)y andWorld:(b2World *)world andLayer:(CCLayer <SpriteDelegate> *)layer {
    return nil;
}

-(void)destoryBody:(id)sender{
    CCSprite *temp = (CCSprite*)sender;
    temp.tag = 0;
    
    for (b2Body* b = myWorld->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			SpriteBase *myActor = (SpriteBase *)b->GetUserData();
            if (myActor.tag == 0) {
                myWorld->DestroyBody(b);
            }
        }
    }
    temp = NULL;
}


-(void)runEnd:(id)sender{
    CCSprite *temp = (CCSprite*)sender;
    if (temp.tag == BIRD_ID) {
        [self destoryBody:sender];
    }
    [myLayer removeChild:sender cleanup:YES];
}

-(void)destoryPig{
    CCSprite *score = [CCSprite spriteWithFile:[NSString stringWithFormat:@"10000%d.png",arc4random()%3+1]];
    score.scale = 0.2;
    score.position = self.position;
    id action1 = [CCScaleTo actionWithDuration:0.25f scale:0.4];
    
    id action2 = [CCScaleBy actionWithDuration:0.5f scale:0];
    id actionMoveEnd = [CCCallFuncN actionWithTarget:self selector:@selector(runEnd:)];
    [score runAction:[CCSequence actions:action1,action2,actionMoveEnd, nil]];
    [myLayer addChild:score];
    [myLayer sprite:self withScore:10000];
}

-(void) destory {
    
    NSString *name = @"littlewood";
    
    switch (self.tag) {
        case ICE_ID:
            name = @"littleice";
            break;
            
        case BIRD_ID:
            name = @"yumao";
            break;
            
        case PIG_ID:
            [self destoryPig];
            [myLayer removeChild:self cleanup:YES];
            return;
    }
    
    for (int i = 0; i<10; i++) {
        int random = arc4random()%3+1;
        int range = 6;
        
        CCSprite *temp = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@%d.png",name,random]];
        temp.scale = (float)(arc4random()%5/10.1f);
        
        temp.position = CGPointMake(self.position.x+arc4random()%10*range-20, self.position.y+arc4random()%10*range-10);
        id actionMove = [CCMoveTo actionWithDuration:1 position:CGPointMake(self.position.x+arc4random()%10*range-20, self.position.y+arc4random()%10*range-10)];
        
        id actionAlpha = [CCFadeOut actionWithDuration:1];
        id actionMoveEnd = [CCCallFuncN actionWithTarget:self selector:@selector(runEnd:)];
        id actionRotate = [CCRotateTo actionWithDuration:1 angle:arc4random()%180];
        id mut =[CCSpawn actions:actionMove,actionAlpha,actionRotate,nil];
        [temp runAction:[CCSequence actions:mut, actionMoveEnd,nil]];
        [myLayer addChild:temp];
    }
    
    UIImage *image = [UIImage imageNamed:@"smoke.png"];
    CCTexture2D * somkeTexture = [[CCTexture2D alloc]initWithImage:image];
    NSMutableArray *frams = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        [frams addObject:[[CCSpriteFrame alloc]initWithTexture:somkeTexture rect:CGRectMake(0+i*image.size.width/4, 0, image.size.width/4, image.size.height)]];
    }
    CCAnimation *animation = [CCAnimation animationWithFrames:frams delay:0.1f];
    id actionMoveEnd = [CCCallFuncN actionWithTarget:self selector:@selector(runEnd:)];
    CCSequence * m = [CCSequence actions:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO] , actionMoveEnd,nil];
    [self runAction:m];
    
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:32];
    switch (self.tag) {
        case ICE_ID:
            [label setString:@"500"];
            [label setColor:ccc3(0, 250, 0)];
            [myLayer sprite:self withScore:500];
            
            //((HelloWorldLayer*)myLayer).score +=500;
            break;
    }
    
    //    [((HelloWorldLayer *)myLayer).scoreLable setString:[NSString stringWithFormat:@"Score : %d",((HelloWorldLayer*)myLayer).score]];
    label.position = self.position;
    id action1 = [CCScaleTo actionWithDuration:0.5f scale:0.4];
    
    id action2 = [CCScaleBy actionWithDuration:0.5f scale:0];
    [label runAction:[CCSequence actions:action1,action2,actionMoveEnd, nil]];
    
    [myLayer addChild:label];
}

@end
