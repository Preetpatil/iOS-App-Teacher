//
//  LUTeacherStudentDetailController.m
//  //  LUTeacher
//
//  Created by Lucas on 10/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import "LUTeacherStudentDetailController.h"

@interface LUTeacherStudentDetailController ()

@end

@implementation LUTeacherStudentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _instantIdView.text = _studentIdForPopUp;
    _instantNameView.text = _studentNameForPopUp;
    _instantClassView.text = _studentClassForPopUp;
    _instantEmailView.text = _studentEmailForPopUp;
    _instantContactView.text = _studentContactForPopUp;
    _instantAddressView.text = _studentAddressForPopUp;
    

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)dismissButton:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
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

@end
