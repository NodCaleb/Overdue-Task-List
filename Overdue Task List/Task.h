//
//  Task.h
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong,nonatomic) NSString *taskTitle;
@property (strong,nonatomic) NSString *taskDetails;
@property (strong,nonatomic) NSDate *taskDueDate;
@property (nonatomic) BOOL taskCompleted;

-(id)initWithData:(NSDictionary *)data;

@end
