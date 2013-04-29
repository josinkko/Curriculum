//
//  Session.h
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/8/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Admin.h"
#import "Course.h"
#import "Student.h"
#import "AdminService.h"

@interface Session : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *course;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *books;

- (id) initWithCourse: (Course *) Course andTime: (NSString *) Time andBooks: (NSString *) Books;
- (NSDictionary *) sessionToDict;
@end
