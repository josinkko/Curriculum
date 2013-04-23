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
    Admin *admin1;
    StudentService *studentService1;
    AdminService *adminService1;
    Course *course1;
    Session *session1;
    Session *session2;

}
- (void)setUp
{
    student1 = [[Student alloc] initWithFirstName:@"johanna" LastName:@"sinkkonen" Age:24];
    admin1 = [[Admin alloc] initWithFirstName:@"bengan" LastName:@"håkansson"];
    studentService1 = [[StudentService alloc] init];
    adminService1 = [[AdminService alloc] init];
    course1 = [[Course alloc] initWithName:@"math1" andStartDate:@"5/15/2013 9:15 AM" andEndDate:@"6/15/2013 3:15 PM" andTeacher:@"goran"];
    session1 = [[Session alloc] initWithCourse:course1 andTime:@"4/21/2013 2:15 PM" andBooks:@"hästboken"];
    session2 = [[Session alloc] initWithCourse:course1 andTime:@"4/23/2013 2:15 PM" andBooks:@"hästboken"];

}

- (void)tearDown
{
    student1 = nil;
    admin1 = nil;
    studentService1 = nil;
    adminService1 = nil;
    course1 = nil;
    session1 = nil;
    session2 = nil;
}

- (void)testSaveStudentToDb
{
    BOOL result = [studentService1 saveStudentToDb:student1];
    STAssertEquals(result, YES, @"result should be equal to YES, true");
}

- (void) testSaveCourseToDb
{
    BOOL result = [adminService1 saveCourseToDb:course1];
    STAssertTrue(result, @"result should be true if succesfully saved to DB.");
}

- (void) testSaveSessionToDb
{
    BOOL result = [adminService1 saveSessionToDb:session1];
    STAssertTrue(result, @"result should be true if succesfully saved to DB.");
}

- (void) testValidateString
{
    BOOL result = [adminService1 validateString:@"gurra86"];
    STAssertFalse(result, @"result should be equal to false.");
}

@end
