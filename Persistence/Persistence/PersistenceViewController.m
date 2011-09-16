//
//  PersistenceViewController.m
//  Persistence
//
//  Created by jdxyw on 11-9-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PersistenceViewController.h"
#import "FourLines.h"

@implementation PersistenceViewController

@synthesize field1;
@synthesize field2;
@synthesize field3;
@synthesize field4;

#define kDatakey @"kDataKEY"

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(NSString*)datafilepath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dictory=[paths objectAtIndex:0];
    return  [dictory stringByAppendingPathComponent:kFilename];
}

-(void)applicationWillterminate:(NSNotification *)notification
{
//    NSMutableArray *array=[[NSMutableArray alloc] init];
//    [array addObject:field1.text];
//    [array addObject:field2.text];
//    [array addObject:field3.text];
//    [array addObject:field4.text];
//    [array writeToFile:[self datafilepath] atomically:YES];
//    [array release];
    
//    FourLines *fourline=[[FourLines alloc] init];
//    fourline.field1=field1.text;
//    fourline.field2=field2.text;
//    fourline.field3=field3.text;
//    fourline.field4=field4.text;
//    
//    NSMutableData *data=[[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//    [archiver encodeObject:fourline forKey:kDatakey];
//    [archiver finishEncoding];
//    [data writeToFile:[self datafilepath] atomically:YES];
//    [fourline release];
//    [archiver release];
//    [data release];
    
    for(int i=0;i<4;i++)
    {
        NSString *fieldname=[[NSString alloc] initWithFormat:@"field%d",i];
        UITextField *textfield=[self valueForKey:fieldname];
        [fieldname release];
        NSString *update=[[NSString alloc] initWithFormat:@"INSERT OR REPLACE INTO FIELDS (ROW,FIELD_DATA) VALUES(%d,'%@');",i,textfield.text];
        
        char *errormessge;
        if(sqlite3_exec(database, [update UTF8String], NULL, NULL, &errormessge)!=SQLITE_OK)
        {
            NSAssert1(0, @"Error happen %@", errormessge);
            sqlite3_free(errormessge);
        }
    }
    sqlite3_close(database);
    
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    //NSString *filepath=[self datafilepath];
    //if([[NSFileManager defaultManager] fileExistsAtPath:filepath])
    //{
//        NSArray *array=[[NSArray alloc] initWithContentsOfFile:filepath];
//        field1.text=[array objectAtIndex:0];
//        field2.text=[array objectAtIndex:1];
//        field3.text=[array objectAtIndex:2];
//        field4.text=[array objectAtIndex:3];
//        [array release];
        
//        NSData *data=[[NSMutableData alloc] initWithContentsOfFile:[self datafilepath]];
//        NSKeyedUnarchiver *archiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        FourLines *fourline=[archiver decodeObjectForKey:kDatakey];
//        [archiver finishDecoding];
//        
//        field1.text=fourline.field1;
//        field2.text=fourline.field2;
//        field3.text=fourline.field3;
//        field4.text=fourline.field4;
//        
//        [archiver release];
//        [data release];
        
    //}
    
    if(sqlite3_open([[self datafilepath] UTF8String], &database)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"Fail to open the database",0);
    }
    
    UIApplication *application=[UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:application];
    

    [super viewDidLoad];
}


- (void)viewDidUnload
{
        [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc{
    [field1 release];
    [field2 release];
    [field3 release];
    [field4 release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
