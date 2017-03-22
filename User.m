//
//  User.m
//  SevenSegment
//
//  Created by harry bloch on 2/9/16.
//  Copyright © 2016 harry bloch. All rights reserved.
//

#import "User.h"

@implementation User

-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:[NSNumber numberWithLong:self.userTimeZone] forKey:@"userTimeZone"];
}
-(id)initWithCoder:(NSCoder *) coder{
    self.userTimeZone = [[coder decodeObjectForKey:@"userTimeZone"]integerValue];
    return self;
}
@end
