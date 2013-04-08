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

@end
