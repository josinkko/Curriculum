//
//  Request.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/26/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "Request.h"
#import "Admin.h"
#import "AdminService.h"
#import "Student.h"
#import "StudentService.h"
#import "Session.h"
#import "Course.h"

@implementation Request

- (void) getWithView: (NSString *) view completionHandler:(void(^)(NSArray *responseData)) callback
{
    
    NSMutableString *urlstring = [[NSMutableString alloc] init];
    [urlstring appendString:@"http://127.0.0.1:5984/curriculumlocal/_design/myapp/_list/getvalues/"];
    [urlstring appendString:view];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
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
    [urlstring appendString:@"http://127.0.0.1:5984/curriculumlocal/_design/myapp/_list/getvalues/"];
    [urlstring appendString:view];
    [urlstring appendString:@"?startkey=%22"];
    [urlstring appendString:key];
    [urlstring appendString:@"%22&endkey=%22"];
    [urlstring appendString:key];
    [urlstring appendString:@"%22"];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
        id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableArray *responseData = [[NSMutableArray alloc] init];
        for (int i = 0; i < [response count]; i++) {
            [responseData addObject:[response objectAtIndex:i]];
        }
        callback(responseData);
        
    }];
}

- (BOOL) postToDatabase: (NSDictionary *) postdata
{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:5984/curriculumlocal"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSData *requestdata = [NSJSONSerialization dataWithJSONObject:postdata options:0 error:nil];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:requestdata];
    NSURLResponse *resp;
    NSError *err;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    if (err == nil) {
        NSLog(@"saved data to Db.");
        return YES;
    }
    return NO;
}



@end
