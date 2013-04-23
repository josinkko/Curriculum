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
    
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:stringAsJson options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postdata];
    NSURLResponse *resp;
    NSError *err;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if (err == nil) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) addStudent: (Student*) student toCourse: (Course *) course
{
    
    NSMutableDictionary *studentAsDict = [[NSMutableDictionary alloc] init];
    studentAsDict[@"type"] = student.type;
    studentAsDict[@"firstname"] = student.firstName;
    studentAsDict[@"lastname"] = student.lastName;
    studentAsDict[@"studentID"] = student.studentId;
    studentAsDict[@"messages"] = [student messages];
    [studentAsDict setObject:[NSNumber numberWithFloat:student.age] forKey:@"age"];
    
    [[student courses] addObject:course.courseName];
    [[course students] addObject:studentAsDict];

    for (int i = 0; i < [[course students] count]; i++) {
        if ([[[[course students] objectAtIndex:i] valueForKeyPath:@"firstname"] isEqualToString:[student firstName]]) {
            return YES;
        } else {
            return NO;
        }
    }
}

- (BOOL) addSession: (Session*) session toCourse: (Course *) course
{
    NSMutableDictionary *classAsDict = [[NSMutableDictionary alloc] init];
    classAsDict[@"type"] = session.type;
    classAsDict[@"coursename"] = session.course;
    classAsDict[@"time"] = session.time;
    classAsDict[@"books"] = session.books;
    
    [[course classes] addObject:classAsDict];
    
    if ([[course classes] containsObject:classAsDict]) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL) saveCourseToDb: (Course *) course
{
    NSString *coursename = course.courseName;
    NSArray *componentsSeparatedByWhiteSpace = [coursename componentsSeparatedByString:@" "];
    if ([componentsSeparatedByWhiteSpace count] > 1) {
        NSLog(@"Error in saving course to DB: No whitespaces allowed in coursename. Please correct and try again.");
        return NO;
    }
    
    NSMutableDictionary *stringAsJson = [[NSMutableDictionary alloc] init];
    stringAsJson[@"type"] = @"course";
    stringAsJson[@"startdate"] = course.startDate;
    stringAsJson[@"enddate"] = course.endDate;
    stringAsJson[@"students"] = [course students];
    stringAsJson[@"sessions"] = [course classes];
    stringAsJson[@"coursename"] = coursename;
    stringAsJson[@"teacher"] = course.teacher;
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/curriculumlocal"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:stringAsJson options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postdata];
    NSURLResponse *resp;
    NSError *err;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if (err == nil) {
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
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:stringAsJson options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postdata];
    NSURLResponse *resp;
    NSError *err;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if (err == nil) {
        return YES;
    } else {
        return NO;
    }
}
- (void) updateCourseInDb: (Course *) course withStudent: (Student *) student andSession: (Session *) session usingHttpMethod: (NSString*) httpMethod removeOrAdd: (NSString *) removeoradd
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
        
        if ([removeoradd isEqualToString:@"REMOVE"]) {
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
        
        if ([removeoradd isEqualToString:@"ADD"]) {
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

        [request2 setHTTPMethod:httpMethod];
        [request2 setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        [request2 setHTTPBody:responseAsJSON];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request2 queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
            id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"response: %@", response);
            
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
            NSLog(@"new message for student: %@. message: %@", student.firstName, message);
            
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
        NSString *firstname = [[[course students] objectAtIndex:i] valueForKeyPath:@"firstname"];
        NSString *lastname = [[[course students] objectAtIndex:i] valueForKeyPath:@"lastname"];
        Student *s = [[Student alloc] initWithFirstName:firstname LastName:lastname Age:0];
        s.type = [[[course students] objectAtIndex:i] valueForKeyPath:@"type"];
        s.messages = [[[course students] objectAtIndex:i] valueForKeyPath:@"messages"];
        [self sendMessage:message ToStudent:s];
    }
    return YES;
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
