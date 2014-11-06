//
//  AddTaskViewController.m
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskDescriptionTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate didAddTask:[self assembleTask]];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate didCancel];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.taskDescriptionTextView resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark — Helper methods

- (Task *)assembleTask
{
    NSDictionary *newTaskDictiionary = @{TASK_TITLE : self.taskTitleField.text, TASK_DETAILS : self.taskDescriptionTextView.text, TASK_DUE_DATE : self.taskDueDatePicker.date, TASK_COMPLETED : @NO};
    return [[Task alloc] initWithData:newTaskDictiionary];
}

@end
