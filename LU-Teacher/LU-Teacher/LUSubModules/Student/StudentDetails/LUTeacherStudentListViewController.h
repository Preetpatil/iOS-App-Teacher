//
//  LUTeacherStudentListViewController.h
//  //  LUTeacher
//
//  Created by Lucas on 10/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"
@interface LUTeacherStudentListViewController : UIViewController<UITableViewDataSource, UIPickerViewDataSource,LUDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIPickerView *classSelect;

@property (weak, nonatomic) IBOutlet UIPickerView *sectionSelect;


@property (strong, nonatomic) NSString *popUpId;

@property (strong, nonatomic) NSString *popUpName;

@property (strong, nonatomic) NSString *popUpClass;

@property (strong, nonatomic) NSString *popUpEmail;

@property (strong, nonatomic) NSString *popUpContact;

@property (strong, nonatomic) NSString *popUpAddress;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property  BOOL isNotes;
- (IBAction)popUpButton:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *messageText;


@end
