//
//  Task.m
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import "Task.h"

@implementation Task

-(id)initWithData:(NSDictionary *)data
{
    Task *newTask = [[Task alloc] init];
    
    newTask.taskTitle = data[TASK_TITLE];
    newTask.taskDetails = data[TASK_DETAILS];
    newTask.taskDueDate = data[TASK_DUE_DATE];    
    [newTask setValue:data[TASK_COMPLETED] forKey:@"taskCompleted"];
    
    return newTask;
}

@end
