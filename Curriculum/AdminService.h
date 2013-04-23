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
- (BOOL) saveCourseToDb: (Course *) course withHttpMethod: (NSString*) httpMethod;
- (BOOL) saveSessionToDb: (Session *) session;
- (BOOL) addStudent: (Student*) student toCourse: (Course *) course;
- (BOOL) addSession: (Session*) session toCourse: (Course *) course;
- (void) updateCourseInDb: (Course *) course withStudent: (Student *) student andSession: (Session *) session usingHttpMethod: (NSString*) httpMethod removeOrAdd: (NSString *) removeoradd;
- (BOOL) sendMessage: (NSString *) message ToStudent: (Student *) student;
- (BOOL) sendMessageToAllStudents: (NSString *) message inCourse: (Course *) course;
@end
