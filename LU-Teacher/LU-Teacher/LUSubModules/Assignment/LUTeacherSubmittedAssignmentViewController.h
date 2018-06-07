//
//  LUTeacherSubmittedAssignmentViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUOperation.h"
#import "LUHeader.h"
@interface LUTeacherSubmittedAssignmentViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,LUDelegate>

@property (weak, nonatomic) IBOutlet UITableView *submitTableView;
@property (weak, nonatomic) IBOutlet UITableView *studentSubmittedList;


@property (weak, nonatomic) IBOutlet UIView *composeView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UIView *submittedList;

@property (weak, nonatomic) IBOutlet UILabel *AssignmentTitle;

- (IBAction)composeAssignmentAction:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *assignmentDuedateTextBox;

@property (weak, nonatomic) IBOutlet UITextField *assignmentMarkTextBox;

@property (weak, nonatomic) IBOutlet UITextField *assignmentDescTextBox;

@property (weak, nonatomic) IBOutlet UITextField *assignmentAttatchmentTextBox;
@property (weak, nonatomic) IBOutlet UITextField *assignmentTitleTextBox;

@property NSString *editAssignmentId, *editAssignmentTypeTextBox, *editClassNameTextBox, *editSectionNameTextBox,
*editSubjectName, *editAssignmentDuedateTextBox, *editAssignmentSubjectTextBox,
*editAssignmentMarkTextBox, *editAssignmentDescTextBox, *editAssignmentAttatchmentTextBox;


@property (weak, nonatomic) IBOutlet UISegmentedControl *assignmentTypeSegment;

@property (strong, nonatomic) NSArray *pageTypes;

@property (weak, nonatomic) IBOutlet UIPickerView *pageTypeSelect;

@property (weak, nonatomic) IBOutlet UIPickerView *classSelect;

@property (weak, nonatomic) IBOutlet UIPickerView *sectionSelect;

@property (weak, nonatomic) IBOutlet UIPickerView *subjectSelect;


@end
