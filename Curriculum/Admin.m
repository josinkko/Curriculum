//
//  Admin.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "Admin.h"

@implementation Admin
@synthesize firstName, lastName, adminId, type;
- (id) initWithFirstName: (NSString*) firstname LastName: (NSString*) lastname
{
    self = [super init];
    if (self) {
        self.firstName = firstname;
        self.lastName = lastname;
        self.adminId = [[NSUUID UUID] UUIDString];
        self.type = @"admin";
    }
    return self;
}
@end
