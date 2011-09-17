//
//  QuartzFunView.m
//  QuartzFun
//
//  Created by jdxyw on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "QuartzFunView.h"
#import "UIColor-Random.h"

@implementation QuartzFunView

@synthesize firsttouch;
@synthesize lasttouch;
@synthesize shapetype;
@synthesize drawimage;
@synthesize currentcolor;
@synthesize useRandomColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder]){
        self.currentcolor=[UIColor redColor];
        self.useRandomColor=NO;
        if(drawimage == nil)
        {
            self.drawimage=[UIImage imageNamed:@"iphone.png"];
        }
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef content=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(content, 2.0);
    CGContextSetStrokeColorWithColor(content, currentcolor.CGColor);
    CGContextSetFillColorWithColor(content, currentcolor.CGColor);
    
    CGRect currectRect=CGRectMake((firsttouch.x>lasttouch.x) ? lasttouch.x:firsttouch.x, 
                                  (firsttouch.y>lasttouch.y) ? lasttouch.y:firsttouch.y, 
                                  fabsf(firsttouch.x-lasttouch.x), 
                                  fabsf(firsttouch.y-lasttouch.y));
    
    switch (shapetype) {
        case kLineShape:
            CGContextMoveToPoint(content, firsttouch.x, firsttouch.y);
            CGContextAddLineToPoint(content, lasttouch.x, lasttouch.y);
            CGContextStrokePath(content);
            break;
        case kRectShape:
            CGContextAddRect(content, currectRect);
            CGContextDrawPath(content,kCGPathFillStroke);
            break;
        case kImageShape:
            break;
        case kEllipseShape:
            CGContextAddEllipseInRect(content, currectRect);
            CGContextDrawPath(content,kCGPathFillStroke);            
            break;
            
        default:
            break;
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(useRandomColor)
        self.currentcolor=[UIColor randomColor];
    UITouch *touch=[touches anyObject];
    firsttouch=[touch locationInView:self];
    lasttouch=[touch locationInView:self];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    lasttouch=[touch locationInView:self];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    lasttouch=[touch locationInView:self];
    [self setNeedsDisplay];
}

-(void)dealloc{
    [currentcolor release];
    [drawimage release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
