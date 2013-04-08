//
//  AdminService.h
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Admin.h"
#import "Student.h"
#import "Course.h"
#import "Session.h"

@class Session;

@interface AdminService : NSObject

- (BOOL) addAdministrator:(Admin *) admin;
- (BOOL) saveCourseToDb: (Course *) course;
- (BOOL) saveSessionToDb: (Session *) session;
- (BOOL) addStudent: (Student*) student toCourse: (Course *) course;
- (BOOL) addClass: (NSMutableDictionary *) Class toCourse: (Course *) course;
@end
