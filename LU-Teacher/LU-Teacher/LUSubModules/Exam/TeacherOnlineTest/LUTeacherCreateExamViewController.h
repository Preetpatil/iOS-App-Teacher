//
//  LUTeacherCreateExamViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"

//#define link @"http://setumbrella.in/luservice/controller/api/adminController.php?Action=GetTestListing"
//
//#define Login_link @"http://setumbrella.in/luservice/controller/api/adminController.php?Action=login"
//
//#define Logout_Link @"http://setumbrella.in/luservice/controller/api/adminController.php?Action=logOut"
//
//#define submit_link @"http://setumbrella.in/luservice/controller/api/teacherController.php?Action=AddTestDetails"

#define add_question_detail @"http://setumbrella.in/luservice/controller/api/teacherController.php?Action=AddQuestionDetail"

#define add_question @"http://setumbrella.in/luservice/controller/api/teacherController.php?Action=AddQuestion"


@interface LUTeacherCreateExamViewController : UIViewController<UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *questionTypePickerView;
//-------------------------------------------------------------------------------------------

@property (strong, nonatomic) NSArray *questionType;

@property (weak, nonatomic) IBOutlet UITextField *noOfQuestionsTextBox;

@property (weak, nonatomic) IBOutlet UILabel *noOfType1QuestionsLabel;

@property (weak, nonatomic) IBOutlet UILabel *noOfType2QuestionsLabel;

@property (weak, nonatomic) IBOutlet UILabel *noOfType3QuestionsLabel;

@property (weak, nonatomic) IBOutlet UILabel *noOfType4QuestionsLabel;

@property (weak, nonatomic) IBOutlet UIButton *addNoOfQuestionsButton;

@property (weak, nonatomic) IBOutlet UILabel *messageText;
//-------------------------------------------------------------------------------------------
- (IBAction)clearDataButton:(id)sender;

- (IBAction)addNoOfQuestions:(id)sender;

- (IBAction)loginAction:(id)sender;

- (IBAction)logoutAction:(id)sender;

- (IBAction)onlineExam:(id)sender;
//-------------------------------------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *classIdTextBox;

@property (weak, nonatomic) IBOutlet UITextField *sectionIdTextBox;

@property (weak, nonatomic) IBOutlet UITextField *subjectIdTextBox;

@property (weak, nonatomic) IBOutlet UITextField *testDurationTextBox;

@property (weak, nonatomic) IBOutlet UITextField *testDateTextBox;

@property (weak, nonatomic) IBOutlet UITextField *testStartTimeTextBox;

@property (weak, nonatomic) IBOutlet UITextField *totalMarksTextBox;

@property (weak, nonatomic) NSString *testIDString;


@property (weak, nonatomic) NSString *classIDString;
@property (weak, nonatomic) NSString *sectionIDString;
@property (weak, nonatomic) NSString *subjectIDString;
@property (weak, nonatomic) NSString *testDurationString;
@property (weak, nonatomic) NSString *testDateIDString;
@property (weak, nonatomic) NSString *testStartIDString;
@property (weak, nonatomic) NSString *totalMarksString;

@property (weak, nonatomic) NSString *QuestionTypeId_01;
@property (weak, nonatomic) NSString *QuestionTypeId_02;
@property (weak, nonatomic) NSString *QuestionTypeId_03;
@property (weak, nonatomic) NSString *QuestionTypeId_04;


//-------------------------------------------------------------------------------------------
- (IBAction)submitAction:(id)sender;
//-------------------------------------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;

- (IBAction)pushToAddQuestions:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *typeOneQuestionText;
@property (weak, nonatomic) IBOutlet UITextField *typeTwoQuestionText;
@property (weak, nonatomic) IBOutlet UITextField *typeThreeQuestionText;
@property (weak, nonatomic) IBOutlet UITextField *typeFourQuestionText;

@end
