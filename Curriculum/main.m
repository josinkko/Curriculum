//
//  main.m
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Admin.h"
#import "StudentService.h"
#import "Course.h"
#import "AdminService.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        
        Student *s1 = [[Student alloc] initWithFirstName:@"johanna" LastName:@"sinkko" Age:24];
        StudentService *new = [[StudentService alloc] init];
        [new addStudent:s1 oncompletion:nil];
        Student *s2 = [[Student alloc] initWithFirstName:@"kerstin" LastName:@"elbander" Age:0];
        [new addStudent:s2 oncompletion:nil];
        
        Admin *a1 = [[Admin alloc] initWithFirstName:@"gustaf" LastName:@"elbander"];
        AdminService *newadminservice = [[AdminService alloc] init];
        [newadminservice addAdministrator:a1];
        
        NSString *startdate = @"5/15/2013 9:15 AM";
        NSString *enddate = @"6/15/2013 3:15 PM";
        NSMutableDictionary *class1 = [[NSMutableDictionary alloc] init];
        [class1 setObject:@"5/15/2013 9:15 AM" forKey:@"time"];
        [class1 setObject:@"matteboken" forKey:@"books"];
        
        NSMutableDictionary *class2 = [[NSMutableDictionary alloc] init];
        [class2 setObject:@"5/17/2013 10:15 AM" forKey:@"time"];
        [class2 setObject:@"matteboken 2" forKey:@"books"];
        

        
        Course *math = [[Course alloc] initWithName:@"math 1" andStartDate:startdate andEndDate:enddate andTeacher:@"goran"];
        [newadminservice addClass:class1 toCourse:math];
        [newadminservice addClass:class2 toCourse:math];
        [newadminservice addStudent:s1 toCourse:math];
        [newadminservice addStudent:s2 toCourse:math];

        NSLog(@"------%@", [[[math classes] objectAtIndex:0] objectForKey:@"time"]); //får ut tiden för en visst lektionstollfälle, class
        for (int i = 0; i < [[math classes] count]; i++) {
            NSLog(@"%@", [[[math classes] objectAtIndex:i] objectForKey:@"books"]);
        }
        
        for (int i = 0; i < [[math students] count]; i++) {
            NSLog(@"%@", [[[math students] objectAtIndex:i]firstName]);
        }
        

        
        
    }
    [[NSRunLoop currentRunLoop] run];
    return 0;
}

