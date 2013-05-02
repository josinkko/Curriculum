//
//  Student.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "Student.h"
#import "AdminService.h"

@implementation Student
@synthesize firstName, lastName, age, studentId, type;

-(id) initWithFirstName: (NSString *) firstname LastName: (NSString *) lastname Age: (float) Age
{
    int digits = (int) ceil(log10(age));
    if (digits > 2) {
        NSLog(@"Age can only contain two characters maximum. Please correct and try again.");
        return NO;
    }
    
    AdminService *admin = [[AdminService alloc] init];
    BOOL firstnameValidation = [admin validateString:firstname];
    BOOL lastnameValidation = [admin validateString:lastname];
    
    if (!firstnameValidation) {
        return NO;
    }
    if (!lastnameValidation) {
        return NO;
    }
    
    self = [super init];
    if (self) {
        self.firstName = firstname;
        self.lastName = lastname;
        self.age = Age;
        self->studentId = [[NSUUID UUID] UUIDString];
        self.type = @"student";
        self.messages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSDictionary *) toDictionary;
{
    NSMutableDictionary *studentAsJson = [[NSMutableDictionary alloc] init];
    
    studentAsJson[@"type"] = self.type;
    studentAsJson[@"firstname"] = self.firstName;
    studentAsJson[@"lastname"] = self.lastName;
    studentAsJson[@"studentId"] = self.studentId;
    [studentAsJson setObject:[NSNumber numberWithFloat:self.age] forKey:@"age"];
    studentAsJson[@"messages"] = [self messages];
    
    return studentAsJson;
}



@end
