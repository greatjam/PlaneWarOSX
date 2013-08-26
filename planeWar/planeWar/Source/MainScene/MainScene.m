//
//  MyScene.m
//  planeWar
//
//  Created by croath on 13-8-24.
//  Copyright (c) 2013年 Croath. All rights reserved.
//

#import "MainScene.h"
#import "PlayerSprite.h"
#import "EnemySprite.h"

#define ENEMIES_MAX_COUNT     20

@interface MainScene(){
  SKLabelNode *_scoreLabel;
  
  SKSpriteNode *_player;
  
  NSMutableArray *_enemiesArray;
}

@end

@implementation MainScene

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    self.backgroundColor = [SKColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
//    [self setBackgroundColor:[SKColor colorWithPatternImage:[NSImage imageNamed:@"bg"]]];
    [self addScoreLabel];
    [self setUpPlayer];
    [self setUpEnemies];
  }
  return self;
}

- (void)addScoreLabel{
  _scoreLabel = [[SKLabelNode alloc] init];
  _scoreLabel.fontColor = [SKColor blackColor];
  _scoreLabel.text = @"0";
  _scoreLabel.fontSize = 15;
  _scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMaxY(self.frame) - 15);
  
  [self addChild:_scoreLabel];
}

- (void)setUpPlayer{
  _player = [SKSpriteNode spriteNodeWithImageNamed:@"plane"];
  _player.position = CGPointMake(CGRectGetMidX(self.frame), 50);
  _player.scale = 0.5;
  [self addChild:_player];
}

- (void)setUpEnemies{
  _enemiesArray = [NSMutableArray arrayWithCapacity:ENEMIES_MAX_COUNT];
  for (int i = 0; i < [_enemiesArray count]; i ++) {
    EnemySprite *sprite = [EnemySprite newEnemyWithEnemyType:EnemyTypeSmall];
    [_enemiesArray addObject:sprite];
  }
}

- (EnemySprite*)availabelSprite{
  for (EnemySprite *sprite in _enemiesArray) {
    if (![sprite inScene]) {
      return sprite;
    }
  }
  return nil;
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
  [self movePlayer];
}

- (void)movePlayer{
  NSPoint mouseLoc = [MainView mousePoint];
  SKAction *action = [SKAction moveTo:mouseLoc duration:0.05];
  [_player runAction:action];
}

@end
