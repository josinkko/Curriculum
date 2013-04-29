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

@interface Request : NSObject
- (BOOL) postToDatabase: (NSDictionary *) postdata;
- (void) getWithView: (NSString *) view completionHandler:(void(^)(NSArray *response)) response;


@end
