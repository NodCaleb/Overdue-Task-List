//
//  EditTaskViewController.h
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol EditTaskProtocol <NSObject>

-(void)updateDetailedTask:(Task *)updatedTask;

@end

@interface EditTaskViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *taskEditTitleField;
@property (strong, nonatomic) IBOutlet UITextView *taskEditDetailsView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskEditDueDatePicker;
@property (strong, nonatomic) Task *editedTask;
@property (weak, nonatomic) id <EditTaskProtocol> delegate;

- (IBAction)saveTaskButtonPressed:(UIBarButtonItem *)sender;

@end
