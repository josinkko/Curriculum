//
//  Student.h
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property NSMutableArray *messages;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic) float age;
@property (nonatomic, copy) NSString *studentId;


-(id) initWithFirstName: (NSString *) firstName LastName: (NSString *) lastName Age: (float) age;
- (NSDictionary *) toDictionary;

@end
