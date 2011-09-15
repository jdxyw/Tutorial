//
//  CellsViewController.m
//  Cells
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CellsViewController.h"

@implementation CellsViewController

@synthesize computers;

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
    NSDictionary *row1=[[NSDictionary alloc] initWithObjectsAndKeys:
                        @"MacBook",@"Name",@"White",@"Color",nil];
    NSDictionary *row2=[[NSDictionary alloc] initWithObjectsAndKeys:
                        @"MacBook Pro",@"Name",@"Silver",@"Color",nil];
    NSDictionary *row3=[[NSDictionary alloc] initWithObjectsAndKeys:
                        @"iMac",@"Name",@"White",@"Color",nil];
    
    NSArray *array=[[NSArray alloc] initWithObjects:row1,row2,row3, nil];
    self.computers=array;
    [row1 release];
    [row2 release];
    [row3 release];
    [array release];
    //[super viewDidLoad];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.computers count];  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier=@"CellTableIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell==Nil)
    {
        //CGRect *rect=CGRectMake(0, 0, 300, 65);
        cell=[[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 300, 65)
              reuseIdentifier:CellTableIdentifier]autorelease];
        
        CGRect nameLabelRect=CGRectMake(0, 5, 70, 15);
        UILabel *nameLable=[[UILabel alloc]initWithFrame:nameLabelRect];
        nameLable.textAlignment=UITextAlignmentCenter;
        nameLable.text=@"Name";
        nameLable.font=[UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview:nameLable];
        [nameLable release];
        
        CGRect colorLabelRect=CGRectMake(0, 26, 70, 15);
        UILabel *colorLable=[[UILabel alloc]initWithFrame:colorLabelRect];
        colorLable.textAlignment=UITextAlignmentCenter;
        colorLable.text=@"Name";
        colorLable.font=[UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview:colorLable];
        [colorLable release];
        
        CGRect nameValueRect=CGRectMake(80, 5, 200, 15);
        UILabel *nameValue=[[UILabel alloc] initWithFrame:nameValueRect];
        nameValue.tag=KNameValueTag;
        [cell.contentView addSubview:nameValue];
        [nameValue release];
        
        CGRect colorValueRect=CGRectMake(80, 25, 200, 15);
        UILabel *colorValue=[[UILabel alloc] initWithFrame:colorValueRect];
        colorValue.tag=KColorValueTag;
        [cell.contentView addSubview:colorValue];
        [colorValue release];
        
        NSUInteger row=[indexPath row];
        NSDictionary *data=[self.computers objectAtIndex:row];
        UILabel *name=(UILabel *)[cell.contentView viewWithTag:KNameValueTag];
        name.text=[data objectForKey:@"Name"];
        
        UILabel *color=(UILabel *)[cell.contentView viewWithTag:KColorValueTag];
        color.text=[data objectForKey:@"Color"];
    }
    return cell;
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
