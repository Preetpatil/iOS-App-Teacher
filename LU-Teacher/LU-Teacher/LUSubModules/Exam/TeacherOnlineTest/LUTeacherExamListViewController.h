//
//  LUTeacherExamListViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LUHeader.h"

@interface LUTeacherExamListViewController : UIViewController<UITableViewDataSource, UIPickerViewDataSource,LUDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)editExam:(id)sender;

- (IBAction)addQuestions:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *classSelection;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (void) reloadTableList ;

@end
