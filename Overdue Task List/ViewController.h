//
//  ViewController.h
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "DetailTaskViewController.h"

@interface ViewController : UIViewController <AddTaskProtocol, UITableViewDelegate, UITableViewDataSource, ManageTaskProtocol>

- (IBAction)addNewTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)reorderTasksButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UITableView *tasksTable;
@property (strong,nonatomic) NSMutableArray *taskObjects;

@end

