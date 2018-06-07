//
//  LUTeacherProfileViewController.h
//  //  LUTeacher
//
//  Created by Preeti Patil on 16/04/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#ifndef LUTeacherProfileViewController_h
#define LUTeacherProfileViewController_h


#endif /* LUTeacherProfileViewController_h */

#import <UIKit/UIKit.h>
#import "LUHeader.h"


@interface LUTeacherProfileViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *subjectListTableView;
@property (weak, nonatomic) IBOutlet UITableView *awardsTableView;
//@property (weak, nonatomic) IBOutlet UITableView *teacherInfoTableView;

@property (weak, nonatomic) IBOutlet UILabel *teacherFirstName;
@property (weak, nonatomic) IBOutlet UILabel *teacherLastName;
@property (weak, nonatomic) IBOutlet UIImageView *teacherProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *teacherDOB;
@property (weak, nonatomic) IBOutlet UILabel *teacherDesignation;
@property (weak, nonatomic) IBOutlet UILabel *teacherGender;
@property (weak, nonatomic) IBOutlet UILabel *teacherEmail;
@property (weak, nonatomic) IBOutlet UILabel *teacherPhone;
@property (weak, nonatomic) IBOutlet UILabel *teacherAddress;

@end
