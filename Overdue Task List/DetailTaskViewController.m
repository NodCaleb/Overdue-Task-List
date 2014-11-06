//
//  DetailTaskViewController.m
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskTitleLabel.text = self.detailedTask.taskTitle;
    self.taskDetailsLabel.text = self.detailedTask.taskDetails;
    NSDateFormatter *dueDateFormatter = [[NSDateFormatter alloc] init];
    [dueDateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    self.taskDueDateLabel.text = [dueDateFormatter stringFromDate:self.detailedTask.taskDueDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    EditTaskViewController *newEditTaskVC = segue.destinationViewController;
    newEditTaskVC.editedTask = self.detailedTask;
    newEditTaskVC.delegate = self;
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"goEditTask" sender:sender];
}

#pragma mark — EditTaskProtocol methods

-(void)updateDetailedTask:(Task *)updatedTask
{
    self.detailedTask = updatedTask;
    
    self.taskTitleLabel.text = self.detailedTask.taskTitle;
    self.taskDetailsLabel.text = self.detailedTask.taskDetails;
    NSDateFormatter *dueDateFormatter = [[NSDateFormatter alloc] init];
    [dueDateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    self.taskDueDateLabel.text = [dueDateFormatter stringFromDate:self.detailedTask.taskDueDate];
    
    [self.delegate saveAllTasks];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
