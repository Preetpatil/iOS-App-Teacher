//
//  LUTeacherTodayCell.h
//  LUTeacher
//
//  Created by Lucas on 24/04/18.
//  Copyright © 2017 SETINFOTECH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUTeacherTodayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *subjectName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

@end
