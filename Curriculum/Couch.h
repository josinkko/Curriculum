//
//  Request.h
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/26/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Admin.h"
#import "AdminService.h"
#import "Student.h"
#import "StudentService.h"
#import "Session.h"
#import "Course.h"

@interface Couch : NSObject

@property NSString *url;
@property NSOperationQueue *queue;
@property BOOL result;

- (void) postToDatabase: (NSDictionary *) postdata completionHandler:(void(^)(NSMutableDictionary *resp)) response;
- (void) getWithView: (NSString *) view andKey: (NSString *) key completionHandler:(void(^)(NSArray *response)) response;
- (void) getWithView: (NSString *) view completionHandler:(void(^)(NSArray *response)) response;
- (Student *) jsonToStudent: (NSDictionary *) studentAsDict;
- (Session *) jsonToSession: (NSDictionary *) sessionAsDict;
- (Course *) jsonToCourse: (NSDictionary *) courseAsDict;

@end
