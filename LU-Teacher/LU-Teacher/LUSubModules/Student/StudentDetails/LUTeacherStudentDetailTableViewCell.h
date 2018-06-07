//
//  LUTeacherStudentDetailTableViewCell.h
//  //  LUTeacher
//
//  Created by Lucas on 10/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUTeacherStudentDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stdId;
@property (weak, nonatomic) IBOutlet UILabel *stdName;
@property (weak, nonatomic) IBOutlet UILabel *stdClass;
@property (weak, nonatomic) IBOutlet UILabel *stdEmail;
@property (weak, nonatomic) IBOutlet UILabel *stdContact;
@property (weak, nonatomic) IBOutlet UILabel *stdAddress;
@property (weak, nonatomic) IBOutlet UIImageView *stdProfile;





@property (weak, nonatomic) IBOutlet UIImageView *stayStatusImage;
@property (weak, nonatomic) IBOutlet UIImageView *transportStatusImage;
@end
