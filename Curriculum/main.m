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
#import "Couch.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // ---------- Creating new students and studenservice-object ----------
        
        //StudentService *new = [[StudentService alloc] init];
        //Student *s1 = [[Student alloc] initWithFirstName:@"johanna" LastName:@"sinkko" Age:24];
        //Student *s2 = [[Student alloc] initWithFirstName:@"kerstin" LastName:@"elbander" Age:0];
        //Student *s3 = [[Student alloc] initWithFirstName:@"mamma" LastName:@"eklund" Age:47];
        //Student *s4 = [[Student alloc] initWithFirstName:@"jonis" LastName:@"eklund" Age:11];
        
        // ---------- Creating one new admin and adminservice ----------
        
        //Admin *a1 = [[Admin alloc] initWithFirstName:@"gustaf" LastName:@"elbander" andPassWord:@"gurra"];
        //AdminService *newadminservice = [[AdminService alloc] initWithAdmin:a1];

        // ---------- Creating a few course objects ----------
        
        //Course *math = [[Course alloc] initWithName:@"math1" andStartDate:@"5/3/2013 9:15 AM" andEndDate:@"6/15/2013 3:15 PM" andTeacher:@"goran"];
        //Course *english = [[Course alloc] initWithName:@"english1" andStartDate:@"5/3/2013 1:15 PM" andEndDate:@"6/15/2013 3:15 PM" andTeacher:@"hästen göran"];

        // ---------- Creating a Couch-object for making requests to database and catching responses ---------
        
        //Couch *req = [[Couch alloc] init];
        
        // ---------- Posting to Db with a Nsdict object as a parametre, completionhandler gives you the response from Db
        
        /*[req postToDatabase:[s1 toDictionary] completionHandler:^(NSMutableDictionary *resp) {
            NSLog(@"%@", resp);
        }];
        
        
        [req postToDatabase:[s2 toDictionary] completionHandler:^(NSMutableDictionary *resp) {

        }];
        
        [req postToDatabase:[s3 toDictionary] completionHandler:^(NSMutableDictionary *resp) {

        }];
        
        [req postToDatabase:[s4 toDictionary] completionHandler:^(NSMutableDictionary *resp) {

        }];*/

        
        // ---------- Admin adding students to courses ----------
        
        /*[newadminservice addStudent:s4 toCourse:math];
        [newadminservice addStudent:s3 toCourse:english];
        [newadminservice addStudent:s1 toCourse:math];
        [newadminservice addStudent:s2 toCourse:english];*/

        // ---------- Creating a few session objects ----------
        
        //Session *ses1 = [[Session alloc] initWithCourse:math andTime:@"5/02/2013 3:15 PM" andBooks:@"matteboken chap 1-2"];
        //Session *ses2 = [[Session alloc] initWithCourse:math andTime:@"5/06/2013 1:15 PM" andBooks:@"matteboken chap 3-5"];
        //Session *ses3 = [[Session alloc] initWithCourse:math andTime:@"5/08/2013 2:15 PM" andBooks:@"matteboken chap 6-9"];
        
        //Session *ses4 = [[Session alloc] initWithCourse:english andTime:@"5/04/2013 3:15 PM" andBooks:@"engboken chap 1-3"];
        //Session *ses5 = [[Session alloc] initWithCourse:english andTime:@"5/07/2013 1:15 PM" andBooks:@"engboken chap 4-5"];
        //Session *ses6 = [[Session alloc] initWithCourse:english andTime:@"5/09/2013 2:15 PM" andBooks:@"engboken chap 6-9"];
        
        
        // ---------- Saving session to Db ----------
        
        /*[req postToDatabase:[ses1 toDictionary] completionHandler:^(NSMutableDictionary *resp) {
            
         }];
        
         [req postToDatabase:[ses2 toDictionary] completionHandler:^(NSMutableDictionary *resp) {
         
         }];
         
         [req postToDatabase:[ses3 toDictionary] completionHandler:^(NSMutableDictionary *resp) {
         
         }];
         
         [req postToDatabase:[ses4 toDictionary] completionHandler:^(NSMutableDictionary *resp) {
         
         }];
         
         [req postToDatabase:[ses5 toDictionary] completionHandler:^(NSMutableDictionary *resp) {
         
         }];
         
         [req postToDatabase:[ses6 toDictionary] completionHandler:^(NSMutableDictionary *resp) {
         
         }];*/
        
        // ---------- Adding sessions to local course objects ----------
        //[newadminservice addSession:ses1 toCourse:math];
        //[newadminservice addSession:ses2 toCourse:math];
        //[newadminservice addSession:ses3 toCourse:math];
        //[newadminservice addSession:ses4 toCourse:english];
        //[newadminservice addSession:ses5 toCourse:english];
        //[newadminservice addSession:ses6 toCourse:english];

        // ---------- Saving course to Db ----------

        /*[req postToDatabase:[math toDictionary] completionHandler:^(NSMutableDictionary *resp) {
            
        }];
        
        [req postToDatabase:[english toDictionary] completionHandler:^(NSMutableDictionary *resp) {
            
        }];*/
        
        // ---------- To view either schedule and reading instructions for today or for one week starting today ----------
        
        /*[new viewTodaysSchedule:s1 forCourse:math completionHandler:^(NSArray *responseData) {
            //NSLog(@"kkkkk %@", [responseData objectAtIndex:0]);
            for (id session in responseData) {
                NSLog(@"TODAY: time: %@ reading instructions: %@", [session valueForKeyPath:@"time"], [session valueForKeyPath:@"books"]);
                
            }
        }];
        
        [new viewScheduleForWeek:s1 forCourse:english completionHandler:^(NSArray *responseData) {
            for (id session in responseData) {
                NSLog(@"time: %@ reading instructions: %@", [session valueForKeyPath:@"time"], [session valueForKeyPath:@"books"]);
            }
        }];*/
        
        // ---------- For admin to update course in db - modify student or session-array, "ADD" to add, "REMOVE" to remove. ----------
        
        //[newadminservice updateCourseInDb:english withStudent:s3 andSession:nil removeOrAdd:@"ADD"];
        
        // ---------- Send a message to one student ----------
        
        // ---------- Putting message on a property called "messages" on the given student document.
        //[newadminservice sendMessage:@"this is a message for student s1" ToStudent:s1];
        //[newadminservice sendMessage:@"this is a message for student s2" ToStudent:s2];
        
        
        // ---------- Sending a message to all students ----------
        
        //[newadminservice sendMessageToAllStudents:@"message to all students! study hard or else you die"];
   
        
        // ---------- Reading message of one student ----------
        
        /*[req getWithView:@"messages" andKey:[s1 firstName] completionHandler:^(NSArray *response) {
            for (id message in response) {
                NSLog(@"message for student: %@, message: %@", [s1 firstName], message);
            }
        }];*/
        
        
        // ---------- Send a message to all students in particular course
        // ---------- Putting message on a property called "messages" on the given student document.
        
        //[newadminservice sendMessageToAllStudents:@"hej alla studenter" inCourse:english];

    
    }
    [[NSRunLoop currentRunLoop] run];
    return 0;
}

