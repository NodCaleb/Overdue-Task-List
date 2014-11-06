//
//  EditTaskViewController.m
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskEditTitleField.text = self.editedTask.taskTitle;
    self.taskEditDetailsView.text = self.editedTask.taskDetails;
    self.taskEditDueDatePicker.date = self.editedTask.taskDueDate;
    
    self.taskEditDetailsView.delegate = self;
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

- (IBAction)saveTaskButtonPressed:(UIBarButtonItem *)sender
{
    self.editedTask.taskTitle = self.taskEditTitleField.text;
    self.editedTask.taskDetails = self.taskEditDetailsView.text;
    self.editedTask.taskDueDate = self.taskEditDueDatePicker.date;
    
    [self.delegate updateDetailedTask:self.editedTask];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.taskEditDetailsView resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
