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

@property NSMutableArray *allStudents;
@property Admin *admin;

- (id) initWithAdmin: (Admin *) administrator;
- (BOOL) addStudent: (Student*) student toCourse: (Course *) course;
- (BOOL) addSession: (Session*) session toCourse: (Course *) course;
- (void) updateCourseInDb: (Course *) course withStudent: (Student *) student andSession: (Session *) session removeOrAdd: (NSString *) removeOrAdd;
- (BOOL) sendMessage: (NSString *) message ToStudent: (Student *) student;
- (BOOL) sendMessageToAllStudents: (NSString *) message inCourse: (Course *) course;
- (BOOL) sendMessageToAllStudents: (NSString *) message;
- (BOOL) validateString: (NSString *) string;
@end
