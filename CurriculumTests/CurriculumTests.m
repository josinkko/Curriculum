//
//  CurriculumTests.m
//  CurriculumTests
//
//  Created by Johanna Sinkkonen on 4/22/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "CurriculumTests.h"
#import "Student.h"
#import "StudentService.h"
#import "Admin.h"
#import "AdminService.h"
#import "Course.h"
#import "Session.h"

@implementation CurriculumTests
{
    Student *student1;
    Student *student2;
    Admin *admin1;
    StudentService *studentService1;
    AdminService *adminService1;
    Course *course1;
    Course *course2;
    Session *session1;
    Session *session2;
    Session *session3;
    Session *session4;
}

- (void)setUp
{
    student1 = [[Student alloc] initWithFirstName:@"johanna" LastName:@"sinkkonen" Age:24];
    student2 = [[Student alloc] initWithFirstName:@"gustaf" LastName:@"elbander" Age:27];
    admin1 = [[Admin alloc] initWithFirstName:@"bengan" LastName:@"håkansson"];
    studentService1 = [[StudentService alloc] init];
    adminService1 = [[AdminService alloc] init];
    course1 = [[Course alloc] initWithName:@"math1" andStartDate:@"5/15/2013 9:15 AM" andEndDate:@"6/15/2013 3:15 PM" andTeacher:@"goran"];
    course2 = [[Course alloc] initWithName:@"math2" andStartDate:@"9/15/2013 9:15 AM" andEndDate:@"12/15/2013 3:15 PM" andTeacher:@"berta"];
    session1 = [[Session alloc] initWithCourse:course1 andTime:@"4/21/2013 2:15 PM" andBooks:@"hästboken"];
    session2 = [[Session alloc] initWithCourse:course1 andTime:@"4/23/2013 2:15 PM" andBooks:@"hästboken"];
    session3 = [[Session alloc] initWithCourse:course2 andTime:@"4/25/2013 1:15 PM" andBooks:@"matteboken"];
    session4 = [[Session alloc] initWithCourse:course2 andTime:@"4/27/2013 1:15 PM" andBooks:@"matteboken"];
}

- (void)tearDown
{
    student1 = nil;
    student2 = nil;
    admin1 = nil;
    studentService1 = nil;
    adminService1 = nil;
    course1 = nil;
    course2 = nil;
    session1 = nil;
    session2 = nil;
    session3 = nil;
    session4 = nil;
}

- (void)testSaveStudentToDb
{
    BOOL result = [studentService1 saveStudentToDb:student1];
    STAssertEquals(result, YES, @"result should be equal to YES, true");
}

- (void) testViewTodaysSchedule
{
    //check if callback data exists?
}

@end
