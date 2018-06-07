//
//  LUTeacherCreateExamViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherCreateExamViewController.h"
#import "LUTeacherAddQuestionsViewController.h"
#import "LUTeacherExamListViewController.h"


@interface LUTeacherCreateExamViewController ()

@end

@implementation LUTeacherCreateExamViewController
{
    NSString *noOfType1Questions, *noOfType2Questions,
    *noOfType3Questions, *noOfType4Questions,*selectedRow;
    NSDictionary *responseObject;
    NSString *jsonString;
    NSArray *userLoginList;
    NSArray *userLogoutList;
    NSString *token;
    NSMutableDictionary *catchDict;
    NSMutableDictionary *catchTypeOneQuest,*catchTypeTwoQuest,*catchTypeThreeQuest,*catchTypeOFourQuest;
    NSMutableDictionary *questionOne, *questionTwo, *questionThree, *questionFour;
    NSMutableArray *questionDetailFinal;
    NSMutableArray *questionDetail;
    NSMutableArray *ClassId_login, *ClassName_login, *SectionData_login,*SectionId_login,*SectionName_login,*Subjectresult_login,*subjectnameResponse,*SubjectId_login,*SubjectName_login,*selectUnit,*selectUnitID;
   
    NSArray *classNamePickerTwo,*sectionArrayPickerTwo,*uniqClassIdLogin,*uniqSectionIdLogin;
    NSArray *sectionDataResponse;
    NSString *classRow, *sectionRow, *subjectRow, *pageTypeRow;
    UIDatePicker *datePicker, *datePickerForTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    // _testIDString=@"";
    
    questionDetailFinal = [[NSMutableArray alloc]init];

    
    questionOne= [[NSMutableDictionary alloc]init];
    questionTwo= [[NSMutableDictionary alloc]init];
    questionThree= [[NSMutableDictionary alloc]init];
    questionFour= [[NSMutableDictionary alloc]init];

    ClassId_login = [[NSMutableArray alloc]init];
    ClassName_login = [[NSMutableArray alloc]init];
    SectionData_login = [[NSMutableArray alloc]init];
    SectionId_login = [[NSMutableArray alloc]init];
    
    SectionName_login = [[NSMutableArray alloc]init];
    
    Subjectresult_login = [[NSMutableArray alloc]init];
    subjectnameResponse = [[NSMutableArray alloc]init];
    SubjectId_login = [[NSMutableArray alloc]init];
    SubjectName_login = [[NSMutableArray alloc]init];
    
    catchDict = [[NSMutableDictionary alloc]init];
    catchTypeOneQuest = [[NSMutableDictionary alloc]init];
    catchTypeTwoQuest = [[NSMutableDictionary alloc]init];
    catchTypeThreeQuest = [[NSMutableDictionary alloc]init];
    catchTypeOFourQuest = [[NSMutableDictionary alloc]init];
    
    questionDetail = [[NSMutableArray alloc]init];

    [self loadData];

    
    datePicker = [[UIDatePicker alloc]init];
    CGRect frame = datePicker.frame;
    frame.size.width = 300;
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.testDateTextBox setInputView:datePicker];

    datePickerForTime = [[UIDatePicker alloc]init];
    frame = datePickerForTime.frame;
    frame.size.width = 300;
    [datePickerForTime setDate:[NSDate date]];
    datePickerForTime.datePickerMode = UIDatePickerModeTime;
    [datePickerForTime addTarget:self action:@selector(updateTextFieldTime:) forControlEvents:UIControlEventValueChanged];
    [self.testStartTimeTextBox setInputView:datePickerForTime];

    
    
    //      _classNames = @[@"Class 1", @"Class 2",@"Class 3", @"Class 4", @"Class 5",
    //                   @"Class 6", @"Class 7",@"Class 8", @"Class 9", @"Class 10"];
    //      _testType = @[@"Objective", @"Descriptive"];
    _questionType = @[@"Scroll for Question Type",@"Objective",@"Descriptive",
                      @"Fill in the blanks",@"Match the following"];
    
    noOfType1Questions = @"00";
    noOfType2Questions = @"00";
    noOfType3Questions = @"00";
    _messageText.text = @"User";

    _classIdTextBox.text = _classIDString;
    _sectionIdTextBox.text = _sectionIDString;
    _subjectIdTextBox.text = _subjectIDString;
    _testDurationTextBox.text = _testDurationString;
    _testDateTextBox.text = _testDateIDString;
    _testStartTimeTextBox.text = _testStartIDString;
    _totalMarksTextBox.text = _totalMarksString;
    
//    _noOfType1QuestionsLabel.text = _QuestionTypeId_01;
//    _noOfType2QuestionsLabel.text = _QuestionTypeId_02;
//    _noOfType3QuestionsLabel.text = _QuestionTypeId_03;
//    _noOfType4QuestionsLabel.text = _QuestionTypeId_04;
    
    _typeOneQuestionText.text = _QuestionTypeId_01;
    _typeTwoQuestionText.text = _QuestionTypeId_02;
    _typeThreeQuestionText.text = _QuestionTypeId_03;
    _typeFourQuestionText.text = _QuestionTypeId_04;
    


}

-(void)updateTextFieldTime:(id)sender
{
    
    
    //datePicker = (UIDatePicker*)self.expireAt.inputView;
    self.testStartTimeTextBox.text = [NSString stringWithFormat:@"%@",datePickerForTime.date];
    //datePickerForTime.minimumDate=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm"];
    
    
    self.testStartTimeTextBox.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePickerForTime.date]];
    [self.testStartTimeTextBox resignFirstResponder];
}

-(void)updateTextField:(id)sender
{
    
    
    //datePicker = (UIDatePicker*)self.expireAt.inputView;
    self.testDateTextBox.text = [NSString stringWithFormat:@"%@",datePicker.date];
    datePicker.minimumDate=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.testDateTextBox.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.testDateTextBox resignFirstResponder];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)loadData
{
    
    NSDictionary *mainResponse = [LUOperation getSharedInstance].userProfileDetails;
    
    NSDictionary *secondResponse = [mainResponse objectForKey:@"item"];
    
    NSString *temp = [secondResponse objectForKey:@"UserFirstName"];
    NSLog(@"%@",temp);
    
    
    NSArray *classSubjectDataResponse = [secondResponse objectForKey:@"ClassSubjectData"];
    NSLog(@"%@",classSubjectDataResponse);
    
    for (int i=0; i<classSubjectDataResponse.count; i++)
    {
        NSDictionary *responseOne_login = [classSubjectDataResponse objectAtIndex:i];
         for (int i=0; i<[classSubjectDataResponse count]; i++)
        {
            [ClassId_login addObject:[responseOne_login objectForKey:@"ClassId"]];
            [ClassName_login addObject:[responseOne_login objectForKey:@"ClassName"]];
            [SectionData_login addObject:[responseOne_login objectForKey:@"sectiondata"]];
        }
        
        
        sectionDataResponse = [SectionData_login objectAtIndex:0];
        for (int i=0; i<[sectionDataResponse count]; i++)
        {
            NSDictionary *subjectResultResponse = [sectionDataResponse objectAtIndex:i];
            NSLog(@"%@",subjectResultResponse);
            [SectionId_login addObject:[subjectResultResponse objectForKey:@"SectionId"]];
            [SectionName_login addObject:[subjectResultResponse objectForKey:@"SectionName"]];
            [Subjectresult_login addObject:[subjectResultResponse objectForKey:@"subjectresult"]];
        }
        
        for (int j=0; j<[Subjectresult_login count]; j++)
        {
            subjectnameResponse = [Subjectresult_login objectAtIndex:j];
            for (int i=0; i<[subjectnameResponse count]; i++)
            {
                NSDictionary *subjectnameResponseTwo = [subjectnameResponse objectAtIndex:i];
                NSLog(@"%@",subjectnameResponseTwo);
                [SubjectId_login addObject:[subjectnameResponseTwo objectForKey:@"SubjectId"]];
                [SubjectName_login addObject:[subjectnameResponseTwo objectForKey:@"SubjectName"]];
            }
        }
        classNamePickerTwo = [[NSSet setWithArray:ClassName_login] allObjects];
        sectionArrayPickerTwo = [[NSSet setWithArray:SectionName_login] allObjects];
        
        NSLog(@"%@,%@",classNamePickerTwo,sectionArrayPickerTwo);
        
    }
    
    uniqClassIdLogin = [[NSSet setWithArray:ClassId_login] allObjects];
    uniqSectionIdLogin = [[NSSet setWithArray:SectionId_login] allObjects];
    
    
    _messageText.text = @"User Logged In";
    NSLog(@"JSONArray = %@",userLoginList);
    
    classRow =[uniqClassIdLogin objectAtIndex:0];
    sectionRow =[uniqSectionIdLogin objectAtIndex:0];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    //    if (thePickerView.tag == 100)
    //    {
    //        return _testType.count;
    //    }
    //    else if (thePickerView.tag == 200)
    //    {
    //        return _classNames.count;
    //    }
    //    else
    //    {
    //        return _questionType.count;
    //    }
    return _questionType.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //    if (pickerView.tag == 100)
    //    {
    //        return _testType[row];
    //    }
    //    else if (pickerView.tag == 200)
    //    {
    //        return _classNames[row];
    //    }
    //    else
    //    {
    //        return _questionType[row];
    //    }
    return _questionType[row];
}

- (IBAction)clearDataButton:(id)sender
{
    [questionDetail removeAllObjects];
    [catchTypeOneQuest removeAllObjects];
    [catchTypeTwoQuest removeAllObjects];
    [catchTypeThreeQuest removeAllObjects];
    [catchTypeOFourQuest removeAllObjects];
    
    noOfType1Questions = @"00";
    noOfType2Questions = @"00";
    noOfType3Questions = @"00";
    noOfType4Questions = @"00";
    
    _noOfType1QuestionsLabel.text = noOfType1Questions;
    _noOfType2QuestionsLabel.text = noOfType2Questions;
    _noOfType3QuestionsLabel.text = noOfType3Questions;
    _noOfType4QuestionsLabel.text = noOfType4Questions;
}



- (void)addQuestionfromTextBox
{
//    NSDictionary *testDetailsDict;
//    [testDetailsDict setValue:@"1" forKey:@"NoOfQuestions"];
//    [testDetailsDict setValue:@"1" forKey:@"QuestionTypeId"];
//    NSDictionary *testDetailsDict2;
//    [testDetailsDict2 setValue:@"2" forKey:@"NoOfQuestions"];
//    [testDetailsDict2 setValue:@"2" forKey:@"NoOfQuestions"];
//    
//    NSArray *tempArray;

    //=-=-=-=-=
    
    
    [questionOne setObject:_typeOneQuestionText.text forKey:@"NoQuestion"];
    [questionOne setObject:@"1" forKey:@"QuestionType"];
    [questionDetailFinal addObject:questionOne];
    
    [questionTwo setObject:_typeTwoQuestionText.text forKey:@"NoQuestion"];
    [questionTwo setObject:@"2" forKey:@"QuestionType"];
    [questionDetailFinal addObject:questionTwo];
    
    [questionThree setObject:_typeThreeQuestionText.text forKey:@"NoQuestion"];
    [questionThree setObject:@"3" forKey:@"QuestionType"];
    [questionDetailFinal addObject:questionThree];
    
    [questionFour setObject:_typeFourQuestionText.text forKey:@"NoQuestion"];
    [questionFour setObject:@"4" forKey:@"QuestionType"];
    [questionDetailFinal addObject:questionFour];
    
    NSLog(@"%@",questionDetailFinal);

}









- (IBAction)addNoOfQuestions:(id)sender
{
//    NSDictionary *testDetailsDict;
//
//    [testDetailsDict setValue:textbox forKey:@"NoOfQuestions"]
//    [testDetailsDict setValue:@"1" forKey:@"QuestionTypeId"];
//
//
  
    
    noOfType1Questions = _noOfQuestionsTextBox.text;
    
    if (!(_noOfQuestionsTextBox.text.length==0)) {
        
        if ([selectedRow isEqualToString:@"1"])
        {
            _noOfType1QuestionsLabel.text = noOfType1Questions;
            NSString *questType = @"1";
            
            [catchTypeOneQuest setObject:noOfType1Questions forKey:@"NoQuestion"];
            [catchTypeOneQuest setObject:questType forKey:@"QuestionType"];
            [questionDetail addObject:catchTypeOneQuest];
            
        }
        else if ([selectedRow isEqualToString:@"2"])
        {
            _noOfType2QuestionsLabel.text = noOfType1Questions;
            NSString *questType = @"2";
            
            [catchTypeTwoQuest setObject:noOfType1Questions forKey:@"NoQuestion"];
            [catchTypeTwoQuest setObject:questType forKey:@"QuestionType"];
            [questionDetail addObject:catchTypeTwoQuest];
            
        }
        else if ([selectedRow isEqualToString:@"3"])
        {
            _noOfType3QuestionsLabel.text = noOfType1Questions;
            [catchTypeThreeQuest setObject:noOfType1Questions forKey:@"NoQuestion"];
            [catchTypeThreeQuest setObject:@"3" forKey:@"QuestionType"];
            [questionDetail addObject:catchTypeThreeQuest];
        }
        else if ([selectedRow isEqualToString:@"4"])
        {
            _noOfType4QuestionsLabel.text = noOfType1Questions;
            [catchTypeOFourQuest setObject:noOfType1Questions forKey:@"NoQuestion"];
            [catchTypeOFourQuest setObject:@"4" forKey:@"QuestionType"];
            [questionDetail addObject:catchTypeOFourQuest];
        }
    }
    _noOfQuestionsTextBox.text = @"";
}

//create exam

- (IBAction)submitAction:(id)sender
{
    [self addQuestionfromTextBox];
    
    
    if (_testIDString == nil) {
        _testIDString =@"";
    }
  
    
    [catchDict setValue:_testIDString forKey:@"TestId"];
    [catchDict setValue:_classIdTextBox.text forKey:@"ClassId"];
    [catchDict setValue:_sectionIdTextBox.text forKey:@"SectionId"];
    [catchDict setValue:_subjectIdTextBox.text forKey:@"SubjectId"];
    [catchDict setValue:_totalMarksTextBox.text forKey:@"TotalMarks"];
    [catchDict setValue:_testDateTextBox.text forKey:@"TestDate"];
    [catchDict setValue:_testDurationTextBox.text forKey:@"TestDuration"];
    [catchDict setValue:_testStartTimeTextBox.text forKey:@"TestStartTime"];
    
   // [catchDict setValue:questionDetail forKey:@"TestDetail"];
   
    [catchDict setValue:questionDetailFinal forKey:@"TestDetail"];

    
    NSLog(@"Dict----------------------------------------------%@",catchDict);

    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton teacherCreateExam:CreateExamTeacher_link body:catchDict];
    
//    NSError *error;
//    // 1
//    NSURL *url = [NSURL URLWithString:CreateExamTeacher_link];
//    // 2
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    request.HTTPMethod = @"POST";
//    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
//    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:catchDict options:0 error:&error];
//    [request setHTTPBody:postData];
//    //3
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
//                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//                                  { dispatch_async(dispatch_get_main_queue(),
//                                                   ^{
//                                                       if (!error)
//                                                       {
//                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
//                                                           NSLog(@"data = %@", data);
//                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
//                                                           NSArray *onlineTest = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                                           NSLog(@"JSONArray = %@",onlineTest);
//                                                          // _messageText.text = @"Add data Test";
//
//                                                         //  _responseLabel.text = [ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
//                                                       }
//                                                       else
//                                                       {
//                                                           NSLog(@"Error: %@", error.localizedDescription);
//                                                       }
//                                                   });
//                                  }];
//
//    [task resume];
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (pickerView == _questionTypePickerView)
    {
        if (row != 0)
        {
            _noOfQuestionsTextBox.hidden = NO;
            _addNoOfQuestionsButton.hidden = NO;
            
        }
        else
        {
            _noOfQuestionsTextBox.hidden = YES;
            _addNoOfQuestionsButton.hidden = YES;
        }
        selectedRow = [NSString stringWithFormat:@"%ld",row];
    }
    //
    //    else if (pickerView ==_testTypePickerView)
    //    {
    //        NSLog(@"TEst type picker view tapped");
    //    }
    //
    //    else if (pickerView == _classNamePickerView)
    //    {
    //        NSLog(@"Class name picker view tapped");
    //    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)pushToAddQuestions:(id)sender
{
    LUTeacherAddQuestionsViewController *pushToAddQuestions = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherAddQuestionsVC"];
    [self.navigationController pushViewController:pushToAddQuestions animated:YES];
}
@end
