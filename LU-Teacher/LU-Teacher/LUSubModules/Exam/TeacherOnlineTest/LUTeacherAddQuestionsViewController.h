//
//  LUTeacherAddQuestionsViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUTeacherAddQuestionsViewController : UIViewController
- (IBAction)loginAction:(id)sender;

- (IBAction)logoutAction:(id)sender;

- (IBAction)testAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel     *messageLabel;

@property (weak, nonatomic) IBOutlet UITextField *tempTextBox;


- (IBAction)addObjectiveQuestion:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel     *questionNoLabel;

@property (weak, nonatomic) IBOutlet UIButton    *objectiveAddButton;


- (IBAction)addDescriptiveQuestion:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel     *questionNoLabel2;

@property (weak, nonatomic) IBOutlet UIButton    *descriptiveAddButton;


- (IBAction)addFillInBlanksQuestion:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel     *questionNolabel3;

@property (weak, nonatomic) IBOutlet UIButton    *fillInBlanksAddButton;


- (IBAction)addMatchTheFollowingQuestion:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel     *questionNoLabel4;

@property (weak, nonatomic) IBOutlet UIButton    *matchFollowingAddButton;

//-------------------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *questionBox;
@property (weak, nonatomic) IBOutlet UITextField *optionAbox;
@property (weak, nonatomic) IBOutlet UITextField *optionBbox;
@property (weak, nonatomic) IBOutlet UITextField *optionCbox;
@property (weak, nonatomic) IBOutlet UITextField *optionDbox;
@property (weak, nonatomic) IBOutlet UITextField *answerBox;
//-------------------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *questionBoxDesc;
@property (weak, nonatomic) IBOutlet UITextField *answerBoxDesc;
@property (weak, nonatomic) IBOutlet UITextField *marksBoxDesc;
@property (weak, nonatomic) IBOutlet UISwitch    *isCompulsorySwitch;
//-------------------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *questionBoxFillInBlanks;
@property (weak, nonatomic) IBOutlet UITextField *answerBoxFillIBlanks;
//-------------------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *questionBoxMatchFollowing;
@property (weak, nonatomic) IBOutlet UITextField *optionBoxMatchFollowing;
@property (weak, nonatomic) IBOutlet UITextField *answerBoxMatchFollowing;

@property (weak, nonatomic) NSDictionary *examDetailsPassDict;

@end
