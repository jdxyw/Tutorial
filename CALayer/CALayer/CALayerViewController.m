//
//  CALayerViewController.m
//  CALayer
//
//  Created by jdxyw on 11-11-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CALayerViewController.h"

@implementation CALayerViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    self.view.layer.backgroundColor=[[UIColor orangeColor] CGColor];
//    self.view.layer.cornerRadius=20.0;
//    self.view.layer.frame=CGRectInset(self.view.layer.frame, 40, -40);
    CALayer *layer=[CALayer layer];
    layer.backgroundColor=[[UIColor orangeColor] CGColor];
    layer.opacity=0.6;
    layer.shadowOffset=CGSizeMake(0, 12);
    layer.shadowRadius=8.0;
    layer.shadowColor=[[UIColor blackColor] CGColor];
    layer.frame=CGRectInset([[UIScreen mainScreen] bounds], 20, 20);
    layer.cornerRadius=20.0;
    
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor blueColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(0, 3);
    sublayer.shadowRadius = 5.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 0.8;
    sublayer.frame = CGRectMake(30, 30, 128, 192);
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setDuration:3.0];
    [animation setRepeatCount:INT_MAX];
    [animation setFromValue:[NSNumber numberWithFloat:0.5]];
    [animation setToValue:[NSNumber numberWithFloat:1.0]];
    [animation setAutoreverses:YES];
    [layer addAnimation:animation forKey:nil];
    
    CATransition *t=[CATransition animation];
    [CATransaction setDisableActions:YES];
    t.duration=3.0;
    t.type=kCATransitionPush;
    t.subtype=kCATransitionFromLeft;
    [sublayer addAnimation:t forKey:nil];
    
    [self.view.layer addSublayer:layer];
    [layer addSublayer:sublayer];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
