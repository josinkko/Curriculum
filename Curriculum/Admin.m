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
- (id) initWithFirstName: (NSString*) firstname LastName: (NSString*) lastname andPassWord: (NSString *) pass
{
    self = [super init];
    if (self) {
        self.password = pass;
        self.firstName = firstname;
        self.lastName = lastname;
        self.adminId = [[NSUUID UUID] UUIDString];
        self.type = @"admin";
        
    }
    return self;
}
- (NSDictionary *) adminToDict
{
    NSMutableDictionary *adminAsJson = [[NSMutableDictionary alloc] init];
    adminAsJson[@"type"] = self.type;
    adminAsJson[@"firstname"] = self.firstName;
    adminAsJson[@"lastname"] = self.lastName;
    adminAsJson[@"adminID"] = self.adminId;
    
    return adminAsJson;
}
@end
