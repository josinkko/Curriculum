//
//  Student.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "Student.h"

@implementation Student
@synthesize firstName, lastName, age, studentId, type;

-(id) initWithFirstName: (NSString *) firstname LastName: (NSString *) lastname Age: (float) Age
{
    self = [super init];
    if (self) {
        self.firstName = firstname;
        self.lastName = lastname;
        self.age = Age;
        self->studentId = [[NSUUID UUID] UUIDString];
        self.type = @"student";
        self.courses = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
