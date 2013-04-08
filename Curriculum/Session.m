//
//  Session.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/8/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import "Session.h"

@implementation Session
@synthesize course, books, time, type;
- (id) initWithCourse: (Course *) Course andTime: (NSString *) Time andBooks: (NSString *) Books
{
    self = [super init];
    if (self) {
        self.course = Course.courseName;
        self.type = @"session";
        self.time = Time;
        self.books = Books;
        
    }
    return self;
}
@end
