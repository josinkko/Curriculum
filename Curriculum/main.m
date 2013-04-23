//
//  main.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Admin.h"
#import "StudentService.h"
#import "Course.h"
#import "AdminService.h"
#import "Session.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Creating new students and studenservice-object
        StudentService *new = [[StudentService alloc] init];
        Student *s1 = [[Student alloc] initWithFirstName:@"johanna" LastName:@"sinkko" Age:24];
        Student *s2 = [[Student alloc] initWithFirstName:@"kerstin" LastName:@"elbander" Age:0];
        Student *s3 = [[Student alloc] initWithFirstName:@"mamma" LastName:@"eklund" Age:47];
        Student *s4 = [[Student alloc] initWithFirstName:@"jonis" LastName:@"eklund" Age:11];
        
        // Creating one new admin
        Admin *a1 = [[Admin alloc] initWithFirstName:@"gustaf" LastName:@"elbander"];
        AdminService *newadminservice = [[AdminService alloc] init];
        [newadminservice addAdministrator:a1];
        
        NSString *startdate = @"5/15/2013 9:15 AM";
        NSString *enddate = @"6/15/2013 3:15 PM";

        // Creating a few courses.
        Course *math = [[Course alloc] initWithName:@"math 1" andStartDate:startdate andEndDate:enddate andTeacher:@"goran"];
        Course *english = [[Course alloc] initWithName:@"english1" andStartDate:startdate andEndDate:enddate andTeacher:@"hästen göran"];

        // Saving students to Db
        [new saveStudentToDb:s1];
        [new saveStudentToDb:s2];
       [new saveStudentToDb:s3];
        [new saveStudentToDb:s4];
        
        // Admin adding students to courses
        [newadminservice addStudent:s4 toCourse:math];
        [newadminservice addStudent:s3 toCourse:english];
        [newadminservice addStudent:s1 toCourse:english];
        [newadminservice addStudent:s4 toCourse:english];

        // Creating a few sessions
        Session *ses1 = [[Session alloc] initWithCourse:math andTime:@"6/23/2013 3:15 PM" andBooks:@"hejsanboken"];
        Session *ses2 = [[Session alloc] initWithCourse:math andTime:@"6/27/2013 1:15 PM" andBooks:@"matteboken"];
        Session *ses3 = [[Session alloc] initWithCourse:math andTime:@"6/30/2013 2:15 PM" andBooks:@"jössesboken"];
        
        Session *ses4 = [[Session alloc] initWithCourse:english andTime:@"4/19/2013 3:15 PM" andBooks:@"engboken"];
        Session *ses5 = [[Session alloc] initWithCourse:english andTime:@"4/23/2013 1:15 PM" andBooks:@"trollboken"];
        Session *ses6 = [[Session alloc] initWithCourse:english andTime:@"4/21/2013 2:15 PM" andBooks:@"hästboken"];
        
        //[newadminservice saveSessionToDb:ses1]; -- saves session to Db
        [newadminservice addSession:ses1 toCourse:math]; // -- adding session to course
        
       // [newadminservice saveSessionToDb:ses2];
        [newadminservice addSession:ses2 toCourse:math];
        
        //[newadminservice saveSessionToDb:ses3];
        [newadminservice addSession:ses3 toCourse:math];
        
        //[newadminservice saveSessionToDb:ses4];
        [newadminservice addSession:ses4 toCourse:english];
        
        //[newadminservice saveSessionToDb:ses5];
        [newadminservice addSession:ses5 toCourse:english];
        
       // [newadminservice saveSessionToDb:ses6];
        [newadminservice addSession:ses6 toCourse:english];
        
        [newadminservice saveCourseToDb:english withHttpMethod:@"POST"]; // -- saving course to Db using POST
        [newadminservice saveCourseToDb:math withHttpMethod:@"POST"];

        
        // To view either schedule for today or schedule for one week starting today
       /* [new viewTodaysSchedule:s1 forCourse:english completionHandler:^(NSArray *responseData) {
            for (id session in responseData) {
                NSLog(@"time: %@", [session valueForKeyPath:@"time"]);
                NSLog(@"book to read: %@", [session valueForKeyPath:@"books"]);
            }
            NSLog(@"callbackblock viewtodaysschedule completed.");
        }];
        
        [new viewScheduleForWeek:s1 forCourse:english completionHandler:^(NSArray *responseData) {
            for (id session in responseData) {
                NSLog(@"time: %@", [session valueForKeyPath:@"time"]);
                NSLog(@"book to read: %@", [session valueForKeyPath:@"books"]);
            }
            NSLog(@"callbackblock viewscheduleforweek completed.");
        }];*/
        
        
        // To modify student or session-array - "ADD" to add, "REMOVE" to, guess what, remove.
      //  [newadminservice updateCourseInDb:english withStudent:s3 andSession:nil usingHttpMethod:@"PUT" removeOrAdd:@"ADD"];
        
        // Send a message to one student -- for the moment only one message
        [newadminservice sendMessage:@"Hej gulligullgull" ToStudent:s1];
        
        // Send a message to all students in particular course
        [newadminservice sendMessageToAllStudents:@"hej alla studenter" inCourse:english];
    
        
        
        
        
        
    }
    [[NSRunLoop currentRunLoop] run];
    return 0;
}

