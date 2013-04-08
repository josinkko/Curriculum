//
//  StudentService.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "StudentService.h"
#import "Student.h"
#import "Admin.h"
#import "Course.h"

@implementation StudentService
- (NSArray *) getAllStudents
{
    return nil;
}
- (BOOL) addStudent:(Student *) student oncompletion:(OnCompletion) callback
{
   
    NSMutableDictionary *stringAsJson = [[NSMutableDictionary alloc] init];
    stringAsJson[@"type"] = student.type;
    stringAsJson[@"firstname"] = student.firstName;
    stringAsJson[@"lastname"] = student.lastName;
    stringAsJson[@"studentID"] = student.studentId;
    [stringAsJson setObject:[NSNumber numberWithFloat:student.age] forKey:@"age"];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/curriculumlocal"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
   // NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:stringAsJson options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postdata];
    
    NSURLResponse *resp;
    NSError *err;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    if (err == nil) {
        NSLog(@"added student succesfully");
        return YES;
    } else {
        return NO;
    }
    
 
}


@end
