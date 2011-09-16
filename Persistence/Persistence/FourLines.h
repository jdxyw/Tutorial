//
//  FourLines.h
//  Persistence
//
//  Created by jdxyw on 11-9-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kField1Key @"Field1"
#define kField2Key @"Field2"
#define kField3Key @"Field3"
#define kField4Key @"Field4"

@interface FourLines : NSObject
<NSCoding,NSCopying>{
    NSString *field1;
    NSString *field2;
    NSString *field3;
    NSString *field4;
}

@property (nonatomic,retain) NSString *field1;
@property (nonatomic,retain) NSString *field2;
@property (nonatomic,retain) NSString *field3;
@property (nonatomic,retain) NSString *field4;


@end
