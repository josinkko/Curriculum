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

- (BOOL) addStudent: (Student*) student toCourse: (Course *) course
{
    NSDictionary *studentAsDict = [student studentToDict];
    [[course students] addObject:studentAsDict];
    if ([[course students] containsObject:studentAsDict]) {
        return YES;
    }
    return NO;
}

- (BOOL) addSession: (Session*) session toCourse: (Course *) course
{
    NSDictionary *sessionAsDict = [session sessionToDict];
    [[course classes] addObject:sessionAsDict];
    
    if ([[course classes] containsObject:sessionAsDict]) {
        return YES;
    }
    return NO;
}

- (void) updateCourseInDb: (Course *) course withStudent: (Student *) student andSession: (Session *) session removeOrAdd: (NSString *) removeOrAdd
{
    
    NSMutableString *urlstring = [[NSMutableString alloc] init];
    [urlstring appendString:@"http://127.0.0.1:5984/curriculumlocal/_design/myapp/_list/getvalues/courses?startkey=%22"];
    NSString *coursename = course.courseName;
    [urlstring appendString:coursename];
    [urlstring appendString:@"%22&endkey=%22"];
    [urlstring appendString:coursename];
    [urlstring appendString:@"%22"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

        NSString *ID = [[response objectAtIndex:0] valueForKeyPath:@"_id"];
        NSString *revisionNumber = [[response objectAtIndex:0] valueForKeyPath:@"_rev"];

        NSMutableString *urlstring2 = [[NSMutableString alloc] init];
        [urlstring2 appendString:@"http://127.0.0.1:5984/curriculumlocal/"];
        [urlstring2 appendString:ID];
        [urlstring2 appendString:@"?rev="];
        [urlstring2 appendString:revisionNumber];

        NSURL *url = [NSURL URLWithString:urlstring2];
        NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc]initWithURL:url];
        
        if ([removeOrAdd isEqualToString:@"REMOVE"]) {
            for (int i = 0; i < [[course students] count]; i++) {
                if ([[[[course students] objectAtIndex:i] valueForKeyPath:@"firstname"] isEqualToString:[student firstName]]) {
                    [[course students] removeObject:[[course students] objectAtIndex:i]];
                }
            }
            for (int i = 0; i < [[course classes] count]; i++) {
                if ([[[[course classes] objectAtIndex:i] valueForKeyPath:@"time"] isEqualToString:[session time]]) {
                    [[course classes] removeObject:[[course classes] objectAtIndex:i]];
                }
            }
        }
        
        if ([removeOrAdd isEqualToString:@"ADD"]) {
            if ([[course students] containsObject:student] != YES && student != nil) {
                [self addStudent:student toCourse:course];
                
            } 
            if ([[course classes] containsObject:session] != YES && session != nil) {
                [self addSession:session toCourse:course];
            }
        }

        NSMutableDictionary *stringAsJson = [[NSMutableDictionary alloc] init];
        stringAsJson[@"type"] = @"course";
        stringAsJson[@"startdate"] = [[response objectAtIndex:0] valueForKeyPath:@"startdate"];
        stringAsJson[@"enddate"] = [[response objectAtIndex:0] valueForKeyPath:@"enddate"];
        stringAsJson[@"students"] = [course students];
        stringAsJson[@"sessions"] = [course classes];
        stringAsJson[@"coursename"] = [[response objectAtIndex:0] valueForKeyPath:@"coursename"];
        stringAsJson[@"teacher"] = [[response objectAtIndex:0] valueForKeyPath:@"teacher"];
        
        NSData *responseAsJSON = [NSJSONSerialization dataWithJSONObject:stringAsJson options:NSJSONWritingPrettyPrinted error:nil];

        [request2 setHTTPMethod:@"PUT"];
        [request2 setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        [request2 setHTTPBody:responseAsJSON];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request2 queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
            
        }];
    }];
}

- (BOOL) sendMessage: (NSString *) message ToStudent: (Student *) student
{

    NSMutableString *urlstring = [[NSMutableString alloc] init];
    [urlstring appendString:@"http://127.0.0.1:5984/curriculumlocal/_design/myapp/_list/getvalues/students?startkey=%22"];
    NSString *studentName = student.firstName;
    [urlstring appendString:studentName];
    [urlstring appendString:@"%22&endkey=%22"];
    [urlstring appendString:studentName];
    [urlstring appendString:@"%22"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSString *ID = [[response objectAtIndex:0] valueForKeyPath:@"_id"];
        NSString *revisionNumber = [[response objectAtIndex:0] valueForKeyPath:@"_rev"];
        
        NSMutableString *urlstring2 = [[NSMutableString alloc] init];
        [urlstring2 appendString:@"http://127.0.0.1:5984/curriculumlocal/"];
        [urlstring2 appendString:ID];
        [urlstring2 appendString:@"?rev="];
        [urlstring2 appendString:revisionNumber];
        
        NSURL *url = [NSURL URLWithString:urlstring2];
        NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc]initWithURL:url];

        [[student messages] addObject:message];
        
        NSMutableDictionary *stringAsJson = [[NSMutableDictionary alloc] init];
        stringAsJson[@"type"] = @"student";
        stringAsJson[@"firstname"] = [[response objectAtIndex:0] valueForKeyPath:@"firstname"];
        stringAsJson[@"lastname"] = [[response objectAtIndex:0] valueForKeyPath:@"lastname"];
        stringAsJson[@"messages"] = [student messages];
        stringAsJson[@"studentId"] = [student studentId];
        [stringAsJson setObject:[NSNumber numberWithFloat:student.age] forKey:@"age"];
        
        NSData *responseAsJSON = [NSJSONSerialization dataWithJSONObject:stringAsJson options:NSJSONWritingPrettyPrinted error:nil];
        
        [request2 setHTTPMethod:@"PUT"];
        [request2 setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        [request2 setHTTPBody:responseAsJSON];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request2 queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
            
        }];
    }];
    
    if ([[student messages] containsObject:message]) {
        return YES;
    } else {
        return NO;
    }
    
}

- (BOOL) sendMessageToAllStudents: (NSString *) message inCourse: (Course *) course
{
    for (int i = 0; i < [[course students] count]; i++) {
        NSString *firstname = [[[course students] objectAtIndex:i] firstName];
        NSString *lastname = [[[course students] objectAtIndex:i] lastName];
        float studentAge = [[[course students] objectAtIndex:i] age];
        Student *student = [[Student alloc] initWithFirstName:firstname LastName:lastname Age:studentAge];
        student.type = [[[course students] objectAtIndex:i] type];
        student.messages = [[[course students] objectAtIndex:i] messages];
        BOOL result = [self sendMessage:message ToStudent:student];
        
        if (result) {
            return YES;
        }
    }
    return NO;
}

- (BOOL) validateString: (NSString *) string
{
    
    NSString *detectedNumbers;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&detectedNumbers];
    
    long number = [detectedNumbers integerValue];
    if (number) {
        NSLog(@"No numbers are allowed in strings. Please correct");
        return NO;
    } else {
        return YES;
    }
}
@end
