//
//  ViewController.m
//  Animation
//
//  Created by jeremy on 2024/4/17.
//

#import "ViewController.h"
#import "VoiceView.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

@interface ViewController ()

@property(nonatomic, strong)CADisplayLink *dbTimer;

@property(nonatomic, strong)VoiceView *voice;


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  VoiceView* subView = [[VoiceView alloc]init];
  [self.view addSubview:subView];
  subView.translatesAutoresizingMaskIntoConstraints = NO;
  [subView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
  [subView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
  [subView inputDbValue:0.5];
  self.voice = subView;
  
  UIView* line = [[UIView alloc]init];
  [self.view addSubview:line];
  line.backgroundColor = [UIColor blueColor];
  line.translatesAutoresizingMaskIntoConstraints = NO;
  [line.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
  [line.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
  [line.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
  [line.heightAnchor constraintEqualToConstant:1].active = YES;

  
  self.view.backgroundColor = UIColor.whiteColor;
  
  self.dbTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(levelTimerCallback:)];
  self.dbTimer.preferredFramesPerSecond = 10;
  [self.dbTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


- (void)levelTimerCallback:(CADisplayLink *)timer {
  int a;
  srand((unsigned)time(NULL));
  a = rand() % 101;
  float value = a/100.0;
  [self.voice inputDbValue:value];
}

@end
