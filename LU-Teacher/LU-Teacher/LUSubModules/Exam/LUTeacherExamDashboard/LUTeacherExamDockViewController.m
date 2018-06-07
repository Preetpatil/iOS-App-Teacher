//
//  LUTeacherExamDockViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherExamDockViewController.h"

@interface LUTeacherExamDockViewController ()

@end

@implementation LUTeacherExamDockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushToExamList:(id)sender {
    LUTeacherExamListViewController *pushToExamList = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherExamListVC"];
    [self.navigationController pushViewController:pushToExamList animated:YES];
    
}

- (IBAction)pushTocreateExam:(id)sender {
    
    LUTeacherCreateExamViewController *pushToCreateExam = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherCreateExamVC"];
    [self.navigationController pushViewController:pushToCreateExam animated:YES];
    
}

- (IBAction)pushToStudentMarks:(id)sender {
    LUTeacherReviewListViewController *ReviewListView = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherReviewListVC"];
    [self.navigationController pushViewController:ReviewListView animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
