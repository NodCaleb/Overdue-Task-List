//
//  DetailTaskViewController.h
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTaskViewController.h"
#import "Task.h"

@protocol ManageTaskProtocol <NSObject>

-(void)saveAllTasks;

@end

@interface DetailTaskViewController : UIViewController <EditTaskProtocol>
@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDueDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDetailsLabel;
@property (strong, nonatomic) Task *detailedTask;
@property (weak, nonatomic) id <ManageTaskProtocol> delegate;

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@end
