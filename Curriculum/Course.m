//
//  Course.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "Course.h"
#import "Student.h"
#import "Admin.h"


@implementation Course
@synthesize startDate, endDate, teacher, courseName;

- (id) initWithName: (NSString *) coursename andStartDate: (NSString *) startdate andEndDate: (NSString *) enddate andTeacher: (NSString *) Teacher 
{
    self = [super init];
    if (self) {
        self.startDate = startdate;
        self.endDate = enddate;
        self.teacher = Teacher;
        self.courseName = coursename;
        self.students = [[NSMutableArray alloc] init];
        self.classes = [[NSMutableArray alloc] init];
    }
    return self;
}



@end
