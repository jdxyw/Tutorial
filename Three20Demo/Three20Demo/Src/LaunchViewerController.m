//
//  LaunchViewerController.m
//  Three20Demo
//
//  Created by jdxyw on 12-1-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LaunchViewerController.h"

@implementation LaunchViewerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Fluid Fraactal";
        self.navigationBarStyle=UIBarStyleBlackTranslucent;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    launchview=[[TTLauncherView alloc] initWithFrame:self.view.bounds];
    launchview.backgroundColor = [UIColor blackColor];
    launchview.delegate = self;
    launchview.columnCount = 4;
    launchview.persistenceMode = TTLauncherPersistenceModeAll;
    
    launchview.pages=[NSArray arrayWithObjects:
                      [NSArray arrayWithObjects:[[TTLauncherItem alloc] initWithTitle:@"Julie Set"
                                                                                image:@"bundle://Icon.png"   
                                                                                  URL:@"tt://PlaneDeformation" 
                                                                            canDelete:YES],nil], nil];
    
    [self.view addSubview:launchview];
    
}

-(void)launcherView:(TTLauncherView *)launcher didSelectItem:(TTLauncherItem *)item
{
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:item.URL]];
}

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

@end
