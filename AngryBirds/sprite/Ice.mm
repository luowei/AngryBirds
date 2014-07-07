//
//  Ice.m
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "Ice.h"

@implementation Ice

-(id)initWithX:(float)x andY:(float)y andWorld:(b2World *)world andLayer:(CCLayer <SpriteDelegate> *)layer{
    myWorld = world;
    myLayer = layer;
    imageUrl = @"ice";
    
    HP = 27;
    fullHP = HP;
    self = [self initWithFile:[NSString stringWithFormat:@"%@1.png",imageUrl]];
    self.position = ccp(x, y);
    self.tag = ICE_ID;
    
    float scale = 2;
    
    self.scale = scale/10;
    
    
    // Create ball body
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(x/PTM_RATIO, y/PTM_RATIO);
    ballBodyDef.userData = self;
    
    b2Body * ballBody = world->CreateBody(&ballBodyDef);
    
    //    // Create block shape
    b2PolygonShape blockShape;
    blockShape.SetAsBox(self.contentSize.width/11/PTM_RATIO,self.contentSize.height/11/PTM_RATIO);
    
    // Create shape definition and add to body
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &blockShape;
    ballShapeDef.density = 10.0f;
    ballShapeDef.friction = 1.0f; // We don't want the ball to have friction!
    ballShapeDef.restitution = 0;
    ballBody->CreateFixture(&ballShapeDef);
    
    return self;
}

@end