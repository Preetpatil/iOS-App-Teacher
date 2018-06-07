//
//  LUTeacherStudentMarksTableViewCell.h
//  //  LUTeacher
//
//  Created by Lucas on 11/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUTeacherStudentMarksTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *studentId;

@property (weak, nonatomic) IBOutlet UIImageView *studentProfile;

@property (weak, nonatomic) IBOutlet UILabel *studentClass;

@property (weak, nonatomic) IBOutlet UILabel *studentName;

@property (weak, nonatomic) IBOutlet UISegmentedControl *subjectsSegmentControl;
@end
