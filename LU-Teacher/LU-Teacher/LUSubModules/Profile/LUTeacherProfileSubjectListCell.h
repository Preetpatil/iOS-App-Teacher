//
//  LUTeacherProfileSubjectListCell.h
//  //  LUTeacher
//
//  Created by Lucas on 11/04/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface LUTeacherProfileSubjectListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *teacherId;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;
@property (weak, nonatomic) IBOutlet UILabel *teacherCode;
@property (weak, nonatomic) IBOutlet UILabel *teacherClass;

@property (weak, nonatomic) IBOutlet UILabel *subjectName;
@property (weak, nonatomic) IBOutlet UILabel *subjectCode;


@end


