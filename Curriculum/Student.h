//
//  Student.h
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
{
    NSMutableArray *courses;
}

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic) float age;
@property (nonatomic, copy, readonly) NSString *studentId;


-(id) initWithFirstName: (NSString *) firstName LastName: (NSString *) lastName Age: (float) age;

@end
