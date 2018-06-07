//
//  LUTeacherExamStudentSubmittedListViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"

@interface LUTeacherExamStudentSubmittedListViewController : UIViewController<LUDelegate, UITableViewDataSource>

@property (weak, nonatomic) NSArray *studentIDString;
@property (weak, nonatomic) NSArray *studentNameString;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
