//
//  LUTeacherNotesListViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"
@interface LUTeacherNotesListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate,LUDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *classSelect;
@property (weak, nonatomic) IBOutlet UIPickerView *sectionSelect;
@property (weak, nonatomic) IBOutlet UIPickerView *unitSelection;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *notesSubjectTable;
@property (weak, nonatomic) IBOutlet UITableView *topicTable;
@end
