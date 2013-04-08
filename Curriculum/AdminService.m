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
    
    [[course students] addObject:student];
    
    if ([course.students containsObject:student]) {
        NSLog(@"succesfully added student to course.");
        return YES;
    } else {
        NSLog(@"error in adding student to course.");
        return NO;
    }
}

- (BOOL) addClass: (NSMutableDictionary *) Class toCourse: (Course *) course
{
    [[course classes] addObject:Class];
    if ([course.classes containsObject:Class]) {
        NSLog(@"successfully added class to course.");
        return YES;
    } else {
        NSLog(@"error in adding class to course.");
        return NO;
    }
}
@end
