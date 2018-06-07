//
//  LUTeacherStudentDockViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherStudentDockViewController.h"
#import "LUTeacherStudentAttendanceViewController.h"
#import "LUTeacherStudentListViewController.h"

@interface LUTeacherStudentDockViewController ()

@end

@implementation LUTeacherStudentDockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)pushToStudentAttendance:(id)sender {
    
    LUTeacherStudentAttendanceViewController
    
    *pushToStudentAttendance = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherStudentAttendanceVC"];
    [self.navigationController pushViewController:pushToStudentAttendance animated:YES];
}

- (IBAction)pushToStudentList:(id)sender {
    LUTeacherStudentListViewController
    
    *pushToStudentList = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherStudentListVC"];
    [self.navigationController pushViewController:pushToStudentList animated:YES];

    
}
@end
