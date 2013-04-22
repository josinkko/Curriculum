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
typedef void(^OnCompletion)(id result, NSError *error);

- (BOOL) addStudent:(Student *) student oncompletion:(OnCompletion) callback;
- (void) viewTodaysSchedule: (Student *) student forCourse: (Course *) course completionHandler:(void(^)(NSArray *jobsByString)) matchingJobs;
- (void) viewScheduleForWeek: (Student *) student forCourse: (Course *) course completionHandler:(void(^)(NSArray *jobsByString)) matchingJobs;

@end
