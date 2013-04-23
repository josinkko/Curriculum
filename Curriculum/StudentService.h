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


- (BOOL) saveStudentToDb:(Student *) student;
- (void) viewTodaysSchedule: (Student *) student forCourse: (Course *) course completionHandler:(void(^)(NSArray *jobsByString)) matchingJobs;
- (void) viewScheduleForWeek: (Student *) student forCourse: (Course *) course completionHandler:(void(^)(NSArray *jobsByString)) matchingJobs;

@end
