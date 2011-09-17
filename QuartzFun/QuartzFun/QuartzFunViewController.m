//
//  QuartzFunViewController.m
//  QuartzFun
//
//  Created by jdxyw on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "QuartzFunViewController.h"
#import "QuartzFunView.h"
#import "UIColor-Random.h"

@implementation QuartzFunViewController

@synthesize colorcontroller;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)changeColor:(id)sender
{
    UISegmentedControl *color=sender;
    NSInteger index=[color selectedSegmentIndex];
    QuartzFunView *quartzview=(QuartzFunView *)self.view;
    switch (index) {
        case kRedColorTab:
            quartzview.currentcolor=[UIColor redColor];
            quartzview.useRandomColor=NO;
            break;
        case kGreenColorTab:
            quartzview.currentcolor=[UIColor greenColor];    
            quartzview.useRandomColor=NO;
            break;
        case kBlueColorTab:
            quartzview.currentcolor=[UIColor blueColor];
            quartzview.useRandomColor=NO;
            break;
        case kYellowColorTab:
            quartzview.currentcolor=[UIColor yellowColor];
            quartzview.useRandomColor=NO;
            break;
        case kRandomColorTab:
            quartzview.currentcolor=[UIColor randomColor];
            quartzview.useRandomColor=YES;
            break;
        default:
            break;
    }
}

-(IBAction)changeShape:(id)sender{
    UISegmentedControl *control=sender;
    [(QuartzFunView *)self.view setShapetype:[control selectedSegmentIndex]];
    if([control selectedSegmentIndex]==kImageShape){
        colorcontroller.hidden=YES;
    }else
    {
        colorcontroller.hidden=NO;
    }
}
#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

-(void)dealloc
{
    [colorcontroller release];
    [super dealloc];
}

@end
