//
//  LUTeacherSubmittedAssignmentDetailViewCell.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface LUTeacherSubmittedAssignmentDetailViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sl_no;

@property (weak, nonatomic) IBOutlet UILabel *class_name;

@property (weak, nonatomic) IBOutlet UILabel *subject_name;


@property (weak, nonatomic) IBOutlet UILabel *AssignmentTitle;
@property (weak, nonatomic) IBOutlet UILabel *due_date;

@property (weak, nonatomic) IBOutlet UILabel *assignment_type;
//--------------------------------------------------------------------------------------------
- (IBAction)deleteAction:(id)sender;

- (IBAction)editAction:(id)sender;



@end
