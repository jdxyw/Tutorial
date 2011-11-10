//
//  MyDrawing.m
//  Drawing
//
//  Created by jdxyw on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyDrawing.h"

@implementation MyDrawing

@synthesize toPoint;
@synthesize fromPoint;
@synthesize background;

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        background=[UIImage imageNamed:@"Default.png"];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [background drawAtPoint:CGPointMake(0, 0)];
    
    UIColor *currentcolor=[UIColor orangeColor];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, currentcolor.CGColor);
    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
    CGContextStrokePath(context);
    [currentcolor release];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint=[touches anyObject];
    fromPoint=[touchPoint locationInView:self];
    toPoint=[touchPoint locationInView:self];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint=[touches anyObject];
    toPoint=[touchPoint locationInView:self];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint=[touches anyObject];
    toPoint=[touchPoint locationInView:self];
    [self setNeedsDisplay];
}

-(void)dealloc{
    [background release];
    [super dealloc];
}

@end
