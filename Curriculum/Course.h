//
//  Course.h
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Admin.h"

@interface Course : NSObject

@property NSMutableArray *students;
@property NSMutableArray *classes;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *courseName;

- (id) initWithName: (NSString *) coursename andStartDate: (NSString *) startdate andEndDate: (NSString *) enddate andTeacher: (NSString *) Teacher;



@end
