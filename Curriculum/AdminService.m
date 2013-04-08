//
//  AdminService.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "AdminService.h"
#import "Admin.h"
#import "Student.h"
#import "Course.h"

@implementation AdminService

- (BOOL) addAdministrator:(Admin *) admin
{
    NSMutableDictionary *stringAsJson = [[NSMutableDictionary alloc] init];
    stringAsJson[@"type"] = admin.type;
    stringAsJson[@"firstname"] = admin.firstName;
    stringAsJson[@"lastname"] = admin.lastName;
    stringAsJson[@"adminID"] = admin.adminId;
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/curriculumlocal"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
  //  NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:stringAsJson options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postdata];
    NSURLResponse *resp;
    NSError *err;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if (err == nil) {
        NSLog(@"added admin succesfully.");
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) addStudent: (Student*) student toCourse: (Course *) course
{
    NSUInteger len = [[course students] count];
    NSString *index = [NSString stringWithFormat:@"%lu", len + 1];
    [[course students] setObject:student forKey:index];
    
    if ([[course students] objectForKey:index] != nil) {
        NSLog(@"succesfully added student to nsdict of a course.");
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) addClass: (NSMutableDictionary *) Class toCourse: (Course *) course
{
    NSUInteger len = [[course classes] count];
    NSString *index = [NSString stringWithFormat:@"%lu", len + 1];
    [[course classes] setObject:Class forKey:index];
    
    if ([[course classes] objectForKey:index] != nil) {
        NSLog(@"succesfully added class to nsdict of a course.");
        return YES;
    } else {
        return NO;
    }
}
- (BOOL) saveCourseToDb: (Course *) course

{

   
    NSMutableDictionary *stringAsJson = [[NSMutableDictionary alloc] init];
    stringAsJson[@"type"] = @"course";
    stringAsJson[@"startdate"] = course.startDate;
    stringAsJson[@"enddate"] = course.endDate;
   // stringAsJson[@"students"] = course.students;
    stringAsJson[@"coursename"] = course.courseName;
    stringAsJson[@"teacher"] = course.teacher;
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/curriculumlocal"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    //NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:stringAsJson options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postdata];
    NSURLResponse *resp;
    NSError *err;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if (err == nil) {
        NSLog(@"saved course succesfully to db.");
        return YES;
    } else {
        return NO;
    }
    
}
- (BOOL) saveSessionToDb: (Session *) session
{
    NSMutableDictionary *stringAsJson = [[NSMutableDictionary alloc] init];
    stringAsJson[@"type"] = session.type;
    stringAsJson[@"time"] = session.time;
    stringAsJson[@"books"] = session.books;
    stringAsJson[@"course"] = session.course;

    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/curriculumlocal"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    //NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:stringAsJson options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postdata];
    NSURLResponse *resp;
    NSError *err;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if (err == nil) {
        NSLog(@"saved session succesfully to db.");
        return YES;
    } else {
        return NO;
    }
}
@end
