//
//  AddSubViewWithAnimationViewController.m
//  AddSubViewWithAnimation
//
//  Created by jdxyw on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AddSubViewWithAnimationViewController.h"
#import "SecondView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AddSubViewWithAnimationViewController

@synthesize btn;

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
    popup=NO;
}


-(IBAction)btnClick:(id)sender{
    if(!popup){
        SecondView *sview=[[SecondView alloc] init];
        [self.view addSubview:[sview view]];
        sview.view.layer.cornerRadius=20;
        CGRect rect=sview.view.frame;
        CGRect bound=sview.view.bounds;
        sview.view.transform = CGAffineTransformMakeScale(1, 0.01);
        //sview.view.center=CGPointMake(rect.origin.x, btn.frame.origin.y, rect.size.width, 0);
        //[sview.view.layer.bounds setAnchorPoint:CGPointMake(0.5, 0.5)];
        //[sview.view setFrame:CGRectMake(rect.origin.x, btn.frame.origin.y, rect.size.width, 0)];
        //sview.view setBounds:CGRectMake(0, 0, bound.size.width, 0)];
        //[sview.view.layer setAnchorPoint:CGPointMake(0.5, 0)];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        //[sview.view setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
        
        sview.view.transform = CGAffineTransformMakeScale(1, 1);
        //[sview.view setBounds:CGRectMake(0, 0, bound.size.width, bound.size.height)];
        [sview.view setTag:10];
        [UIView commitAnimations];
        popup=YES;
    }
    else
    {
        CGRect rect=[self.view viewWithTag:10].frame;
        CGRect bound=[self.view viewWithTag:10].bounds;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        //[UIView setAnimationDidStopSelector:@selector(removeLayer)];
        //[[self.view viewWithTag:10] setFrame:CGRectMake(rect.origin.x, btn.frame.origin.y, rect.size.width, 0)];
        [UIView animateWithDuration:1.0 animations:^{
            [self.view viewWithTag:10].transform = CGAffineTransformMakeScale(1, 0.01);;
        } completion:^(BOOL finished){[[self.view viewWithTag:10] removeFromSuperview];}];
        //[[self.view viewWithTag:10] removeFromSuperview];
        [UIView commitAnimations];
        popup=NO;

    }
}

-(void)removeLayer{
    [[self.view viewWithTag:10] removeFromSuperview];
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
