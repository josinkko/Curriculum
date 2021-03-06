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
#import "AdminService.h"
#import "Couch.h"
#include "math.h"


@implementation StudentService

- (void) viewTodaysSchedule: (Student *) student forCourse: (Course *) course completionHandler:(void(^)(NSArray *responseData)) callback
{


    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/curriculumlocal/_design/myapp/_list/getvalues/sessions"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Application"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
 
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"M/dd/yyyy H:mm a"];
    
        NSDate *now = [[NSDate alloc] init];
        NSString *todaysDate = [formatter stringFromDate:now];
        
        NSMutableArray *todaysSessions = [[NSMutableArray alloc] init];
   
       for (int i = 0; i < [response count]; i++) {
            if ([[[response objectAtIndex:i] valueForKey:@"course"] isEqualToString:course.courseName]) {
               NSArray *listItems = [[[response objectAtIndex: i] valueForKeyPath:@"time"] componentsSeparatedByString:@" "];
               NSArray *todaysDateSplitted = [todaysDate componentsSeparatedByString:@" "];
                if ([[todaysDateSplitted objectAtIndex:0] isEqualTo:[listItems objectAtIndex:0]]) {
                    [todaysSessions addObject:[response objectAtIndex:i]];
                    
                }
            }
        }
        callback(todaysSessions);
    }];
    
    
}

- (void) viewScheduleForWeek: (Student *) student forCourse: (Course *) course completionHandler:(void(^)(NSArray *responseData)) callback
{
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/curriculumlocal/_design/myapp/_list/getvalues/sessions"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"M/dd/yyyy H:mm a"];
        
        NSDate *now = [[NSDate alloc] init];
        NSString *todaysDate = [formatter stringFromDate:now];
        
        NSDate *day2 = [now dateByAddingTimeInterval:60*60*24];
        NSString *day2withformat = [formatter stringFromDate:day2];
        NSDate *day3 = [day2 dateByAddingTimeInterval:60*60*24];
        NSString *day3withformat = [formatter stringFromDate:day3];
        NSDate *day4 = [day3 dateByAddingTimeInterval:60*60*24];
        NSString *day4withformat = [formatter stringFromDate:day4];
        NSDate *day5 = [day4 dateByAddingTimeInterval:60*60*24];
        NSString *day5withformat = [formatter stringFromDate:day5];
        NSDate *day6 = [day5 dateByAddingTimeInterval:60*60*24];
        NSString *day6withformat = [formatter stringFromDate:day6];
        NSDate *day7 = [day6 dateByAddingTimeInterval:60*60*24];
        NSString *day7withformat = [formatter stringFromDate:day7];
        
        NSMutableArray *week = [[NSMutableArray alloc] init];
        [week addObject:todaysDate];
        [week addObject:day2withformat];
        [week addObject:day3withformat];
        [week addObject:day4withformat];
        [week addObject:day5withformat];
        [week addObject:day6withformat];
        [week addObject:day7withformat];
        
        NSMutableArray *oneWeekSessions = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [response count]; i++) {
            if ([[[response objectAtIndex:i] valueForKey:@"course"] isEqualToString:course.courseName]) {
                NSArray *listItems = [[[response objectAtIndex: i] valueForKeyPath:@"time"] componentsSeparatedByString:@" "];
                for (int i = 0; i < [week count]; i++) {
                    NSArray *todaysDateSplitted = [[week objectAtIndex:i] componentsSeparatedByString:@" "];
                    if ([[todaysDateSplitted objectAtIndex:0] isEqualTo:[listItems objectAtIndex:0]]) {
                        [oneWeekSessions addObject:[response objectAtIndex:i]];
                    }
                    
                }
            }
        }
        callback(oneWeekSessions);
        
    }];
    
}
/*- (NSMutableArray *) readMessageForStudent: (Student *) student
{
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    Request *req = [[Request alloc] init];
    [req getWithView:@"messages" andKey:[student firstName] completionHandler:^(NSArray *response) {
        for (id message in response) {
            [messages addObject:message];
        }
    }];
    
}*/


@end
