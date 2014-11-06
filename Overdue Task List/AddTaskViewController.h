//
//  AddTaskViewController.h
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskProtocol <NSObject>

@required

-(void)didCancel;
-(void)didAddTask:(Task *)task;

@end

@interface AddTaskViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *taskTitleField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDueDatePicker;
@property (weak,nonatomic) id delegate;

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

@end
