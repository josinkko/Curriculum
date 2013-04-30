//
//  StudentService.h
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Admin.h"
#import "Course.h"

@interface StudentService : NSObject

- (void) viewTodaysSchedule: (Student *) student forCourse: (Course *) course completionHandler:(void(^)(NSArray *sessionsToday)) sessions;
- (void) viewScheduleForWeek: (Student *) student forCourse: (Course *) course completionHandler:(void(^)(NSArray *sessionThisWeek)) sessions;
//- (NSMutableArray *) readMessageForStudent: (Student *) student;


@end
