//
//  FourLines.m
//  Persistence
//
//  Created by jdxyw on 11-9-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FourLines.h"

@implementation FourLines

@synthesize field1;
@synthesize field2;
@synthesize field3;
@synthesize field4;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:field1 forKey:kField1Key];
    [aCoder encodeObject:field2 forKey:kField2Key];
    [aCoder encodeObject:field3 forKey:kField3Key];
    [aCoder encodeObject:field4 forKey:kField4Key];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.field1=[aDecoder decodeObjectForKey:kField1Key];
        self.field2=[aDecoder decodeObjectForKey:kField2Key];
        self.field3=[aDecoder decodeObjectForKey:kField3Key];
        self.field4=[aDecoder decodeObjectForKey:kField4Key];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    FourLines *copy=[[[self class] allocWithZone:zone] init];
    copy.field1=[self.field1 copy];
    copy.field2=[self.field2 copy];
    copy.field3=[self.field3 copy];
    copy.field4=[self.field4 copy];
    return copy;
}

@end
