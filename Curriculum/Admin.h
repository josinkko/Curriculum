//
//  Admin.h
//  Curriculum
//
//  Created by Johanna Sinkkonen on 4/7/13.
//  Copyright (c) 2013 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Admin : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic) NSString *adminId;

- (id) initWithFirstName: (NSString*) firstname LastName: (NSString*) lastname;
@end
