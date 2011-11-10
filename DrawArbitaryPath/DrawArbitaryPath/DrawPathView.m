//
//  DrawPathView.m
//  DrawArbitaryPath
//
//  Created by jdxyw on 11-9-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DrawPathView.h"

@implementation DrawPathView

@synthesize current;

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
//        topath=[[NSMutableArray alloc] init];
//        frompath=[[NSMutableArray alloc] init];
        paths=[[NSMutableArray alloc] init];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    UIColor *currentColor=[UIColor orangeColor];
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    for(UIBezierPath *path in paths){
        [path stroke];
    }
//    int num=[frompath count];
//    for(int i=0;i<num-2;i++){
//        CGPoint point1=[[frompath objectAtIndex:i] CGPointValue];
//        CGPoint point2=[[topath objectAtIndex:i] CGPointValue];
//        CGContextMoveToPoint(context, point1.x, point1.y);
//        CGContextAddLineToPoint(context, point2.x, point2.y);
//        CGContextStrokePath(context);
//    }
//    //if(!isTouch){
//        [topath removeAllObjects];
//        [frompath removeAllObjects];
//    //}    
//    [currentColor release];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint=[touches anyObject];
    CGPoint point=[touchPoint locationInView:self];
    current=[UIBezierPath bezierPath];
    [current moveToPoint:point];
    [paths addObject:current];
//    [frompath addObject:[NSValue valueWithCGPoint:point]];
//    isTouch=YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint=[touches anyObject];
    CGPoint point=[touchPoint locationInView:self];
    [current addLineToPoint:point];
    [self setNeedsDisplay];
//    [topath addObject:[frompath lastObject]];
//    [frompath addObject:[NSValue valueWithCGPoint:point]];
//    //[self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint=[touches anyObject];
    CGPoint point=[touchPoint locationInView:self];
//    [topath addObject:[frompath lastObject]];
//    [frompath addObject:[NSValue valueWithCGPoint:point]];
//    isTouch=NO;
//    [self setNeedsDisplay];
}

@end
