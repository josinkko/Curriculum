//
//  Request.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/26/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "Couch.h"
#import "Admin.h"
#import "AdminService.h"
#import "Student.h"
#import "StudentService.h"
#import "Session.h"
#import "Course.h"

@implementation Couch

@synthesize url, queue;

- (id) init
{
    self = [super init];
    if (self) {
        self.url = @"http://127.0.0.1:5984/curriculumlocal";
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
}
- (void) getWithView: (NSString *) view completionHandler:(void(^)(NSArray *responseData)) callback
{
    
    NSMutableString *urlstring = [[NSMutableString alloc] init];
    [urlstring appendString:[self url]];
    [urlstring appendString:@"/_design/myapp/_list/getvalues/"];
    [urlstring appendString:view];
    
    NSURL *url1 = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url1];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[self queue] completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        NSMutableArray *responseData = [[NSMutableArray alloc] init];
        for (int i = 0; i < [response count]; i++) {
            [responseData addObject:[response objectAtIndex:i]];
        }
        callback(responseData);
        
    }];
    
}

- (void) getWithView: (NSString *) view andKey: (NSString *) key completionHandler:(void(^)(NSArray *responseData)) callback
{
    NSMutableString *urlstring = [[NSMutableString alloc] init];
    [urlstring appendString:[self url]];
    [urlstring appendString:@"/_design/myapp/_list/getvalues/"];
    [urlstring appendString:view];
    [urlstring appendString:@"?startkey=%22"];
    [urlstring appendString:key];
    [urlstring appendString:@"%22&endkey=%22"];
    [urlstring appendString:key];
    [urlstring appendString:@"%22"];
    
    NSURL *url1 = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url1];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];

    
    [NSURLConnection sendAsynchronousRequest:request queue:[self queue] completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableArray *responseData = [[NSMutableArray alloc] init];
        for (int i = 0; i < [response count]; i++) {
            [responseData addObject:[response objectAtIndex:i]];
        }
        callback(responseData);
        
    }];
}

- (void) postToDatabase: (NSDictionary *) postdata completionHandler:(void(^)(NSMutableDictionary *resp)) callback;
{
    NSURL *url1 = [NSURL URLWithString:[self url]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url1];
    NSData *requestdata = [NSJSONSerialization dataWithJSONObject:postdata options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:requestdata];

    [NSURLConnection sendAsynchronousRequest:request queue:[self queue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSMutableDictionary *resAsJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        callback(resAsJSON);
    }];
    
}

- (Student *) jsonToStudent: (NSDictionary *) studentAsDict;
{
    Student *student = [[Student alloc] init];
    student.firstName = [studentAsDict valueForKeyPath:@"firstname"];
    student.lastName = [studentAsDict valueForKeyPath:@"lastname"];
    student.type = [studentAsDict valueForKeyPath:@"type"];
    student.studentId = [studentAsDict valueForKeyPath:@"studentId"];
    student.age = [[studentAsDict valueForKeyPath:@"age"] floatValue];
    student.messages = [[NSMutableArray alloc] init];
    return student;
}

- (Session *) jsonToSession: (NSDictionary *) sessionAsDict
{
    Session *session = [[Session alloc] init];
    session.type = [sessionAsDict valueForKeyPath:@"type"];
    session.time = [sessionAsDict valueForKeyPath:@"time"];
    session.books = [sessionAsDict valueForKeyPath:@"books"];
    session.course = [sessionAsDict valueForKeyPath:@"course"];
    return session;
}

- (Course *) jsonToCourse: (NSDictionary *) courseAsDict
{
    NSString *courseName = [courseAsDict valueForKeyPath:@"coursename"];
    NSString *startDate = [courseAsDict valueForKeyPath:@"startdate"];
    NSString *endDate = [courseAsDict valueForKeyPath:@"enddate"];
    NSString *teacher = [courseAsDict valueForKeyPath:@"teacher"];
    NSMutableArray *studentsInCourse = [courseAsDict valueForKeyPath:@"students"];
    NSMutableArray *sessionsInCourse = [courseAsDict valueForKeyPath:@"sessions"];
    
    Course *course = [[Course alloc] initWithName:courseName andStartDate:startDate andEndDate:endDate andTeacher:teacher];
    course.classes = sessionsInCourse;
    course.students = studentsInCourse;
    
    return course;
    
}
@end
