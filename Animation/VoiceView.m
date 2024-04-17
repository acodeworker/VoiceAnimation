//
//  VoiceView.m
//  LoginDemo
//
//  Created by jeremy on 2024/3/27.
//  Copyright © 2024 aqara. All rights reserved.
//

#import "VoiceView.h"


@interface VoiceView()
{
  CGFloat lineWidth;
  CGFloat lineMargin;
  NSInteger lineNum;
  CGFloat animationDuration;
  CGFloat offsetX;
  CGFloat voiceValue;
}
@property(nonatomic, strong)UIBezierPath *levelPath;

@property(nonatomic, strong)NSMutableArray *currentLevels;

@property(nonatomic, strong)CAShapeLayer *shapeLayer;


@end

@implementation VoiceView


- (CGSize)intrinsicContentSize{
  return CGSizeMake(300, 40);
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    lineWidth = 4;
    lineMargin = 5;
    lineNum = 16;
    animationDuration = 0.3;
     offsetX = 0;
    voiceValue = 0.8;
    
    CAShapeLayer* levelLayer = [CAShapeLayer layer];
    levelLayer.fillColor = [UIColor redColor].CGColor;
    levelLayer.strokeColor = [UIColor redColor].CGColor;
    levelLayer.lineWidth = lineWidth;
    levelLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:levelLayer];
    self.shapeLayer = levelLayer;
    
    self.currentLevels = @[].mutableCopy;
  }
  return self;
}

- (void)reset{
  [self.currentLevels removeAllObjects];
}

- (void)setColor:(UIColor*)colcor{
  self.shapeLayer.strokeColor = colcor.CGColor;
}

- (void)inputDbValue:(float)value{
  voiceValue = value;
  [self drawWaveLayer];
}

- (void)drawWaveLayer {

    CGFloat height = self.intrinsicContentSize.height;
    CGFloat width = self.intrinsicContentSize.width;
  
    CGFloat F = voiceValue*height/2.0;
    CGFloat left = (width - lineNum*lineWidth - (lineNum-1)*lineMargin)/2.0;
    offsetX += (lineWidth + lineMargin);
    self.levelPath = [UIBezierPath bezierPath];
    for (int i = 0; i < lineNum; i++) {
      CGFloat x = left + i * (lineWidth + lineMargin);
      CGFloat pathH = F * sin( 1*x + offsetX);
      pathH = fabs(pathH)+5;
      CGFloat startY = height / 2.0 - pathH / 2.0;
      CGFloat endY = height / 2.0 + pathH / 2.0;
      CGPoint startPoint = CGPointMake(x, startY);
      CGPoint endPoint = CGPointMake(x, endY);
      [self.levelPath moveToPoint:startPoint];
      [self.levelPath moveToPoint:startPoint];
      [self.levelPath addLineToPoint:endPoint];
    }
   self.shapeLayer.path = self.levelPath.CGPath;
}

@end
