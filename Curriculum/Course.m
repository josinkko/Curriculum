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
#import "Session.h"


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

- (NSDictionary *) courseToDict
{
    NSString *coursename = self.courseName;
    NSArray *componentsSeparatedByWhiteSpace = [coursename componentsSeparatedByString:@" "];
    if ([componentsSeparatedByWhiteSpace count] > 1) {
        NSLog(@"Error: No whitespaces allowed in coursename. Please correct and try again.");
        return NO;
    }
    
    NSMutableDictionary *stringAsJson = [[NSMutableDictionary alloc] init];
    stringAsJson[@"type"] = @"course";
    stringAsJson[@"startdate"] = self.startDate;
    stringAsJson[@"enddate"] = self.endDate;
    stringAsJson[@"students"] = [self students];
    stringAsJson[@"sessions"] = [self classes];
    stringAsJson[@"coursename"] = coursename;
    stringAsJson[@"teacher"] = self.teacher;
    
    return stringAsJson;
}

@end
