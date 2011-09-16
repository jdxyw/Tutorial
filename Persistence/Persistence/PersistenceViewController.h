//
//  PersistenceViewController.h
//  Persistence
//
//  Created by jdxyw on 11-9-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

//#define kFilename @"data.plist"
#define kFilename @"data.sqlite3"

@interface PersistenceViewController : UIViewController{
    IBOutlet UITextField *field1;
    IBOutlet UITextField *field2;
    IBOutlet UITextField *field3;
    IBOutlet UITextField *field4;
    
    sqlite3 *database;
}

@property (nonatomic,retain) IBOutlet UITextField *field1;
@property (nonatomic,retain) IBOutlet UITextField *field2;
@property (nonatomic,retain) IBOutlet UITextField *field3;
@property (nonatomic,retain) IBOutlet UITextField *field4;

-(NSString *)datafilepath;
-(void)applicationWillterminate:(NSNotification *)notification;

@end
