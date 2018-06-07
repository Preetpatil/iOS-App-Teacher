//
//  LUTeacherProfileTeacherInfoCell.h
//  //  LUTeacher
//
//  Created by Lucas on 12/04/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUTeacherProfileTeacherInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teacherProfile;
@property (weak, nonatomic) IBOutlet UILabel *teacherDesignation;
@property (weak, nonatomic) IBOutlet UILabel *teacherClassInfo;
@property (weak, nonatomic) IBOutlet UILabel *teacherDob;
@property (weak, nonatomic) IBOutlet UILabel *teacherGender;
@property (weak, nonatomic) IBOutlet UILabel *teacherEmail;
@property (weak, nonatomic) IBOutlet UILabel *teacherPhone;
@property (weak, nonatomic) IBOutlet UILabel *teacherAddress;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameInfo;

@end
