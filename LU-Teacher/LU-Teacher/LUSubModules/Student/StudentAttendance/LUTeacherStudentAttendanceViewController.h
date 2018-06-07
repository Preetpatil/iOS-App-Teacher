//
//  LUTeacherStudentAttendanceViewController.h
//  //  LUTeacher
//
//  Created by Lucas on 11/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LUHeader.h"

//#define Login_link @"http://setumbrella.in/luservice/controller/api/adminController.php?Action=login"
//
//#define Student_attendance_details @"http://setumbrella.in/luservice/controller/api/studentController.php?Action=AttendanceList"
//
//#define Send_attendance @"http://setumbrella.in/luservice/controller/api/studentController.php?Action=AttendanceStatus"

@interface LUTeacherStudentAttendanceViewController : UIViewController<UITableViewDataSource,UITabBarDelegate,LUDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)loginAction:(id)sender;

- (IBAction)populateDataAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *messageText;

@property (weak, nonatomic) IBOutlet UILabel *responseLabel;

- (IBAction)submitAttendance:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *absentLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentAttendanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *printButton;
@property (weak, nonatomic) IBOutlet UIView *detailsBarOne;
@property (weak, nonatomic) IBOutlet UIImageView *teacherProfile;

@property (weak, nonatomic) IBOutlet UIPickerView *classSelection;
@property (weak, nonatomic) IBOutlet UIPickerView *sectionSelection;


@property (weak, nonatomic) IBOutlet UISwitch *absentSwitchControl;




@end
