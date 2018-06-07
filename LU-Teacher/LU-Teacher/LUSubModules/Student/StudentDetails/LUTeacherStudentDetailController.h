//
//  LUTeacherStudentDetailController.h
//  //  LUTeacher
//
//  Created by Lucas on 10/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUTeacherStudentDetailController : UIViewController
@property (strong, nonatomic) NSString *studentIdForPopUp;

@property (strong, nonatomic) NSString *studentNameForPopUp;

@property (strong, nonatomic) NSString *studentClassForPopUp;

@property (strong, nonatomic) NSString *studentEmailForPopUp;

@property (strong, nonatomic) NSString *studentContactForPopUp;

@property (strong, nonatomic) NSString *studentAddressForPopUp;


@property (weak, nonatomic) IBOutlet UILabel *instantIdView;

@property (weak, nonatomic) IBOutlet UILabel *instantNameView;

@property (weak, nonatomic) IBOutlet UILabel *instantClassView;

@property (weak, nonatomic) IBOutlet UILabel *instantEmailView;

@property (weak, nonatomic) IBOutlet UILabel *instantContactView;

@property (weak, nonatomic) IBOutlet UILabel *instantAddressView;

- (IBAction)dismissButton:(id)sender;

@end
