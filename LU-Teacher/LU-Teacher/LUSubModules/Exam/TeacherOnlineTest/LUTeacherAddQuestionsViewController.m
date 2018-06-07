//
//  LUTeacherAddQuestionsViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherAddQuestionsViewController.h"
#import "LUTeacherCreateExamViewController.h"
#import "LUHeader.h"


@interface LUTeacherAddQuestionsViewController ()

@end

@implementation LUTeacherAddQuestionsViewController
{
    NSArray *userLoginList;
    NSArray *userLogoutList;
    NSString *token;
    NSMutableDictionary *catchDict;
    NSMutableDictionary *newDict;
    int noOfObjectiveQuestions, noOfDiscriptiveQuestions, noOfFillInQuestions, noOfMatchFollowingQuestions;
    NSMutableArray *noOfQuestionsArray, *questionTypeIdArray;
    NSString *ObjQuestion, *ObjOptionA, *ObjOptionB, *ObjOptionC, *ObjOptionD, *ObjAnswer;
    NSString *DescQuestion, *DescAnswer, *DescMarks;
    NSString *DescIsCompulsory;
    NSString *FillInTheBlanksQuestion, *FillInTheBlanksAnswer;
    NSString *MatchFollowingQuestion, *MatchFollowingOption, *MatchFollowingAnswer;
    NSString *testDetailId;
    NSMutableDictionary *catchDescDict, *catchObjectiveDict, *catchFillInDict, *catchMatchFollowingDict;
   
    
    NSMutableArray *ClassId_login, *ClassName_login, *SectionData_login,*SectionId_login,*SectionName_login,*Subjectresult_login,*subjectnameResponse,*SubjectId_login,*SubjectName_login,*selectUnit,*selectUnitID;
    
    NSArray *classNamePickerTwo,*sectionArrayPickerTwo,*uniqClassIdLogin,*uniqSectionIdLogin;
    NSArray *sectionDataResponse;
    NSString *classRow, *sectionRow, *subjectRow, *pageTypeRow;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", _examDetailsPassDict);
    [self callForQuestionDetails];
    
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
    catchDescDict = [[NSMutableDictionary alloc]init];
    catchObjectiveDict = [[NSMutableDictionary alloc]init];
    catchFillInDict = [[NSMutableDictionary alloc]init];
    catchMatchFollowingDict = [[NSMutableDictionary alloc]init];
    
    noOfQuestionsArray = [[NSMutableArray alloc]init];
    questionTypeIdArray = [[NSMutableArray alloc]init];
    DescIsCompulsory = @"0";
    [self.isCompulsorySwitch addTarget:self action:@selector(setCompulsory:) forControlEvents:UIControlEventValueChanged];
    [self loadData];

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
    
    
    NSLog(@"JSONArray = %@",userLoginList);
    
    classRow =[uniqClassIdLogin objectAtIndex:0];
    sectionRow =[uniqSectionIdLogin objectAtIndex:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) callForQuestionDetails
{
    NSArray *array1 = [_examDetailsPassDict objectForKey:@"QuestionData"];
    NSLog(@"%@",array1);
    _questionNoLabel.text=@"1";
    _questionNoLabel2.text=@"1";
    _questionNolabel3.text=@"1";
    _questionNoLabel4.text=@"1";
    for (int i=0; i<array1.count; i++)
    {
        
        NSDictionary *Dict1 = [array1 objectAtIndex:i];
        // NSLog(@"%@",Dict1);
        testDetailId = [Dict1 objectForKey:@"TestDetailsId"];
        if ([[Dict1 objectForKey:@"QuestionTypeId"] isEqualToString:@"1"])
        {
            noOfObjectiveQuestions = [[Dict1 objectForKey:@"NoOfQuestions"] intValue];
            NSLog(@"no of objective questions = %d",noOfObjectiveQuestions);
        }
        else if ([[Dict1 objectForKey:@"QuestionTypeId"] isEqualToString:@"2"])
        {
            noOfDiscriptiveQuestions =[[Dict1 objectForKey:@"NoOfQuestions"] intValue];
            NSLog(@"no of desc questions = %d",noOfDiscriptiveQuestions);
            
        }
        else if ([[Dict1 objectForKey:@"QuestionTypeId"] isEqualToString:@"3"])
        {
            noOfFillInQuestions =[[Dict1 objectForKey:@"NoOfQuestions"] intValue];
            NSLog(@"no of FIB questions = %d",noOfFillInQuestions);
        }
        else if ([[Dict1 objectForKey:@"QuestionTypeId"] isEqualToString:@"4"])
        {
            noOfMatchFollowingQuestions =[[Dict1 objectForKey:@"NoOfQuestions"] intValue];
            NSLog(@"no of MTF questions = %d",noOfMatchFollowingQuestions);
        }
        
        
    }
    
}

int typeOneTap = 0;
int typeTwoTap = 0;
int typeThreeTap = 0;
int typeFourTap = 0;
int countForObjQuest = 1;
int countForDescQuest = 1;
int countForFillInQuest = 1;
int countForMatchFollowinhQuest = 1;

//Add questions for Objective type questions
- (IBAction)addObjectiveQuestion:(id)sender
{
    typeOneTap++;
    
    if (typeOneTap < noOfObjectiveQuestions)
    {
        countForObjQuest++;
    }
    if (typeOneTap <= noOfObjectiveQuestions)
    {
        NSString *forTextBox = [NSString stringWithFormat:@"%d", countForObjQuest];
        _questionNoLabel.text = forTextBox;
        NSLog(@"Added %d",typeOneTap);
        ObjQuestion = _questionBox.text;
        ObjOptionA = _optionAbox.text;
        ObjOptionB = _optionBbox.text;
        ObjOptionC = _optionCbox.text;
        ObjOptionD = _optionDbox.text;
        ObjAnswer = _answerBox.text;
        _questionBox.text = @"";
        _optionAbox.text = @"";
        _optionBbox.text = @"";
        _optionCbox.text = @"";
        _optionDbox.text = @"";
        _answerBox.text = @"";
        
        [catchObjectiveDict setValue:@"" forKey:@"QuestionId"];
        [catchObjectiveDict setValue:testDetailId forKey:@"TestDetailId"];
        [catchObjectiveDict setValue:@"1" forKey:@"QuestionTypeId"];
        NSString *strFromInt = [NSString stringWithFormat:@"%d",typeOneTap];
        [catchObjectiveDict setValue:strFromInt forKey:@"QuestionNumber"];
        [catchObjectiveDict setValue:ObjQuestion forKey:@"Question"];
        [catchObjectiveDict setValue:@"1" forKey:@"Mark"];
        [catchObjectiveDict setValue:ObjOptionA forKey:@"Option1"];
        [catchObjectiveDict setValue:ObjOptionB forKey:@"Option2"];
        [catchObjectiveDict setValue:ObjOptionC forKey:@"Option3"];
        [catchObjectiveDict setValue:ObjOptionD forKey:@"Option4"];
        [catchObjectiveDict setValue:ObjAnswer forKey:@"Answer"];
        
        NSLog(@"Dict----------------------------------------------%@",catchObjectiveDict);
        if (typeOneTap == noOfObjectiveQuestions)
        {
            _objectiveAddButton.highlighted =NO;
            _questionBox.enabled = NO;
            _optionAbox.enabled  = NO;
            _optionBbox.enabled  = NO;
            _optionCbox.enabled  = NO;
            _optionDbox.enabled  = NO;
            _answerBox.enabled   = NO;
            _questionBox.text    = @"";
            _objectiveAddButton.enabled = NO;
        }
    }

    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton teacherAddQuestToQuestPaper:AddQuestToQuestPaper_link body:catchObjectiveDict ];
}

- (void) addQuestionsToQuestPaper: (NSDictionary *)questToQuestPaperDict
{
    NSLog(@"%@",questToQuestPaperDict);
    
}

//Add questions for Objective type questions
- (IBAction)addDescriptiveQuestion:(id)sender
{
    typeTwoTap++;
    
    if (typeTwoTap < noOfDiscriptiveQuestions)
    {
        countForDescQuest++;
    }
    
    if (typeTwoTap <= noOfDiscriptiveQuestions)
    {
        NSString *forTextBox = [NSString stringWithFormat:@"%d", countForDescQuest];
        _questionNoLabel2.text = forTextBox;
        NSLog(@"Added %d",typeTwoTap);
        DescQuestion = _questionBoxDesc.text;
        DescAnswer = _answerBoxDesc.text;
        DescMarks = _marksBoxDesc.text;
        
        _questionBoxDesc.text = @"";
        _answerBoxDesc.text = @"";
        _marksBoxDesc.text = @"";
        //DescIsCompulsory = @"0";
        [_isCompulsorySwitch setOn:NO];
        
        NSLog(@"%@",DescQuestion);
        NSLog(@"%@",DescAnswer);
        NSLog(@"%@",DescMarks);
        NSLog(@"%@",DescIsCompulsory);
        [catchDescDict setValue:@"" forKey:@"QuestionId"];
        [catchDescDict setValue:testDetailId forKey:@"TestDetailId"];
        [catchDescDict setValue:@"2" forKey:@"QuestionTypeId"];
        NSString *strFromInt = [NSString stringWithFormat:@"%d",typeTwoTap];
        [catchDescDict setValue:strFromInt forKey:@"QuestionNumber"];
        [catchDescDict setValue:DescQuestion forKey:@"Question"];
        [catchDescDict setValue:DescMarks forKey:@"Mark"];
        [catchDescDict setValue:DescIsCompulsory forKey:@"IsCompulsary"];
        [catchDescDict setValue:DescAnswer forKey:@"DescriptiveAnswer"];
        NSLog(@"Dict----------------------------------------------%@",catchDescDict);
        DescIsCompulsory = @"0";
        
        if (typeTwoTap == noOfDiscriptiveQuestions)
        {
            _questionBoxDesc.enabled = NO;
            _questionBoxDesc.text = @"";
            _answerBoxDesc.enabled = NO;
            _answerBoxDesc.text = @"";
            _marksBoxDesc.enabled = NO;
            _marksBoxDesc.text = @"";
            _descriptiveAddButton.enabled = NO;
            _isCompulsorySwitch.enabled = NO;
            [_isCompulsorySwitch setOn:NO];
        }

        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        [sharedSingleton teacherAddQuestToQuestPaper:AddQuestToQuestPaper_link body:catchDescDict ];

    }
}

- (void)setCompulsory:(id)sender
{
    BOOL state = [sender isOn];
    DescIsCompulsory = state == YES ? @"1" : @"0";
}

//Add questions for Fill in the blanks type questions
- (IBAction)addFillInBlanksQuestion:(id)sender
{

    typeThreeTap++;
    
    if (typeThreeTap < noOfFillInQuestions)
    {
        countForFillInQuest++;
    }
    
    if (typeThreeTap <= noOfFillInQuestions) {
        NSString *forTextBox = [NSString stringWithFormat:@"%d", countForFillInQuest];
        _questionNolabel3.text = forTextBox;
        NSLog(@"Added %d",typeThreeTap);
        FillInTheBlanksQuestion = _questionBoxFillInBlanks.text;
        FillInTheBlanksAnswer = _answerBoxFillIBlanks.text;
        _questionBoxFillInBlanks.text = @"";
        _answerBoxFillIBlanks.text = @"";
        
        [catchFillInDict setValue:@"" forKey:@"QuestionId"];
        [catchFillInDict setValue:testDetailId forKey:@"TestDetailId"];
        [catchFillInDict setValue:@"3" forKey:@"QuestionTypeId"];
        NSString *strFromInt = [NSString stringWithFormat:@"%d",typeThreeTap];
        [catchFillInDict setValue:strFromInt forKey:@"QuestionNumber"];
        [catchFillInDict setValue:FillInTheBlanksQuestion forKey:@"Question"];
        [catchFillInDict setValue:@"1" forKey:@"Mark"];
        [catchFillInDict setValue:FillInTheBlanksAnswer forKey:@"Answer"];
        
        NSLog(@"Dict----------------------------------------------%@",catchFillInDict);
        
        if (typeThreeTap == noOfFillInQuestions) {
            
            _questionBoxFillInBlanks.enabled = NO;
            _questionBoxFillInBlanks.text = @"";
            _answerBoxFillIBlanks.enabled = NO;
            _answerBoxFillIBlanks.text = @"";
            _fillInBlanksAddButton.enabled = NO;
        }
        
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        [sharedSingleton teacherAddQuestToQuestPaper:AddQuestToQuestPaper_link body:catchFillInDict ];

    }
}

//Add questions for Match the following type questions
- (IBAction)addMatchTheFollowingQuestion:(id)sender
{
    typeFourTap++;
    if (typeFourTap < noOfMatchFollowingQuestions)
    {
        countForMatchFollowinhQuest++;
    }
    
    if (typeFourTap <= noOfMatchFollowingQuestions)
    {
        NSString *forTextBox = [NSString stringWithFormat:@"%d", countForMatchFollowinhQuest];
        _questionNoLabel4.text = forTextBox;
        NSLog(@"Added %d",typeFourTap);
        MatchFollowingQuestion = _questionBoxMatchFollowing.text;
        MatchFollowingOption = _optionBoxMatchFollowing.text;
        MatchFollowingAnswer = _answerBoxMatchFollowing.text;
        _questionBoxMatchFollowing.text = @"";
        _optionBoxMatchFollowing.text = @"";
        _answerBoxMatchFollowing.text = @"";
        
        [catchMatchFollowingDict setValue:@"" forKey:@"QuestionId"];
        [catchMatchFollowingDict setValue:testDetailId forKey:@"TestDetailId"];
        [catchMatchFollowingDict setValue:@"4" forKey:@"QuestionTypeId"];
        NSString *strFromInt = [NSString stringWithFormat:@"%d",typeFourTap];
        [catchMatchFollowingDict setValue:strFromInt forKey:@"QuestionNumber"];
        [catchMatchFollowingDict setValue:MatchFollowingQuestion forKey:@"Question"];
        [catchMatchFollowingDict setValue:@"1" forKey:@"Mark"];
        [catchMatchFollowingDict setValue:MatchFollowingOption forKey:@"Option1"];
        [catchMatchFollowingDict setValue:MatchFollowingAnswer forKey:@"Answer"];
        
        NSLog(@"Dict----------------------------------------------%@",catchMatchFollowingDict);
        if (typeFourTap == noOfMatchFollowingQuestions)
        {
            _questionBoxMatchFollowing.enabled = NO;
            _questionBoxMatchFollowing.text = @"";
            _optionBoxMatchFollowing.enabled = NO;
            _optionBoxMatchFollowing.text = @"";
            _answerBoxMatchFollowing.enabled = NO;
            _answerBoxMatchFollowing.text = @"";
            _matchFollowingAddButton.enabled = NO;
        }
        
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        [sharedSingleton teacherAddQuestToQuestPaper:AddQuestToQuestPaper_link body:catchMatchFollowingDict ];

    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
