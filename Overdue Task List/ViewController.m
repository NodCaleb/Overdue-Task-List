//
//  ViewController.m
//  Overdue Task List
//
//  Created by Eugene Rozhkov on 05.11.14.
//  Copyright (c) 2014 nordPoint. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize taskObjects = _taskObjects;

- (NSMutableArray *)taskObjects
{
    if (!_taskObjects)
    {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *persistedTasksArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST_STORAGE] mutableCopy];
    
    for (NSDictionary *taskDataDictionary in persistedTasksArray)
    {
        Task *newTask = [self dictionary2Task:taskDataDictionary];
        [self.taskObjects addObject:newTask];
    }
    
    self.tasksTable.delegate = self;
    self.tasksTable.dataSource = self;
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewTaskButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"goAddNewTask" sender:sender];
}

- (IBAction)reorderTasksButtonPressed:(UIBarButtonItem *)sender
{
    if (self.tasksTable.editing)
    {
        [self.tasksTable setEditing:NO];
        [self.tasksTable reloadData];
    }
    else
    {
        [self.tasksTable setEditing:YES];
        [self.tasksTable reloadData];
    }
}

#pragma mark — Table methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [self.taskObjects count];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    
    Task *taskForNewCell = [self.taskObjects objectAtIndex:indexPath.row];
    NSDateFormatter *dueDateFormatter = [[NSDateFormatter alloc] init];
    [dueDateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    newCell.textLabel.text = taskForNewCell.taskTitle;
    newCell.detailTextLabel.text = [dueDateFormatter stringFromDate:taskForNewCell.taskDueDate];
    
    if (taskForNewCell.taskCompleted)
    {
        newCell.backgroundColor = [UIColor greenColor];
    }
    else if ([self isTheDate:[NSDate date] greaterThan:taskForNewCell.taskDueDate])
    {
        newCell.backgroundColor = [UIColor redColor];
    }
    else
    {
        newCell.backgroundColor = [UIColor yellowColor];
    }
    
    if (tableView.editing) newCell.showsReorderControl = YES;
    
    return newCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Task *completedTask = [self.taskObjects objectAtIndex:indexPath.row];
    
    [self updateTaskCompletion:completedTask forIndexPath:indexPath];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self deleteTaskForIndexPath:indexPath];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"goSeeTaskDetails" sender:indexPath];
//    NSLog(@"%i", self.detailidTaskIndex);
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Task *movingTask = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:movingTask atIndex:destinationIndexPath.row];
    [self saveAllTasks];
}

#pragma mark — AddTaskProtocol methods

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)didAddTask:(Task *)task
{
    [self.taskObjects addObject:task];
    
    NSMutableArray *persistedTasksArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST_STORAGE] mutableCopy];
    if (!persistedTasksArray) persistedTasksArray = [[NSMutableArray alloc] init];
    [persistedTasksArray addObject:[self task2Dictionary:task]];
    [[NSUserDefaults standardUserDefaults] setObject:persistedTasksArray forKey:TASK_LIST_STORAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tasksTable reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark — Helper methods

-(NSDictionary *)task2Dictionary:(Task *)task
{
    NSDictionary *taskDictionary = @{TASK_TITLE : task.taskTitle, TASK_DETAILS : task.taskDetails, TASK_DUE_DATE : task.taskDueDate, TASK_COMPLETED : [NSNumber numberWithBool:task.taskCompleted]};
    return taskDictionary;
}
-(Task *)dictionary2Task:(NSDictionary *)dictionary
{
    Task *newTask = [[Task alloc] initWithData:dictionary];
    return newTask;
}
-(BOOL)isTheDate:(NSDate *)date greaterThan:(NSDate *)deadline
{
    if ([date timeIntervalSince1970] > [deadline timeIntervalSince1970]) return YES;
    return NO;
}
-(void)updateTaskCompletion:(Task *)completedTask forIndexPath:(NSIndexPath *)indexPath
{
    completedTask.taskCompleted = YES;
    
    NSMutableArray *persistedTasksArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST_STORAGE] mutableCopy];
    if (!persistedTasksArray) persistedTasksArray = [[NSMutableArray alloc] init];
    [persistedTasksArray removeObjectAtIndex:indexPath.row];
    [persistedTasksArray insertObject:[self task2Dictionary:completedTask] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:persistedTasksArray forKey:TASK_LIST_STORAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    [self.taskObjects insertObject:completedTask atIndex:indexPath.row];
    [self.tasksTable reloadData];
}
-(void)deleteTaskForIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *persistedTasksArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST_STORAGE] mutableCopy];
    if (!persistedTasksArray) persistedTasksArray = [[NSMutableArray alloc] init];
    [persistedTasksArray removeObjectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:persistedTasksArray forKey:TASK_LIST_STORAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    [self.tasksTable reloadData];
}
-(void)saveAllTasks
{
    NSMutableArray *allTasksArray = [[NSMutableArray alloc] init];
    
    for (Task *currentTask in self.taskObjects)
    {
        [allTasksArray addObject:[self task2Dictionary:currentTask]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:allTasksArray forKey:TASK_LIST_STORAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]])
    {
        AddTaskViewController *newTaskVC = segue.destinationViewController;
        newTaskVC.delegate = self;
    }
    else if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]])
    {
        DetailTaskViewController *newDetailTaskVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        Task *detailedTask = self.taskObjects[indexPath.row];
        newDetailTaskVC.detailedTask = detailedTask;
        newDetailTaskVC.delegate = self;
    }
}


@end
