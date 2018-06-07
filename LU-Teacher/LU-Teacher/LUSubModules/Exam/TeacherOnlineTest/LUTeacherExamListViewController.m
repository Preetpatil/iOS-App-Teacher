//
//  LUTeacherExamListViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherExamListViewController.h"
#import "LUTeacherCreateExamViewController.h"
#import "LUTeacherAddQuestionsViewController.h"
#import "LUHeader.h"

@interface LUTeacherExamListViewController ()

@end

@implementation LUTeacherExamListViewController
{
    NSArray *firstResponse;
    
    NSArray *resultArray ;
    NSDictionary *responseOne;
    NSDictionary *examListResponse;


    NSMutableArray  *Id, *subject, *testDate, *testStartTime, *testEndTime, *totalMarks;
    NSMutableArray *aryForQuestions;
    NSString *catchString;
    NSMutableArray *ClassId_login, *ClassName_login, *SectionData_login,*SectionId_login,*SectionName_login,*Subjectresult_login,*subjectnameResponse,*SubjectId_login,*SubjectName_login,*selectUnit,*selectUnitID;
    
    NSArray *classNamePickerTwo,*sectionArrayPickerTwo,*uniqClassIdLogin,*uniqSectionIdLogin;
    NSArray *sectionDataResponse;
    NSString *classRow, *sectionRow, *subjectRow, *pageTypeRow;
    NSDictionary *tempDict;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    resultArray = [[tempDict objectForKey:@"TestData"]
                   filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SubjectName contains[c] %@", searchText]];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText
                               scope:[[self.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchBar
                                                     selectedScopeButtonIndex]]];
}

- (void)reloadTableList
{
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"test");
     [self.tableView reloadData];
    ClassId_login = [[NSMutableArray alloc] init];
    ClassName_login = [[NSMutableArray alloc] init];
   // Id_login = [[NSMutableArray alloc] init];
    SectionId_login = [[NSMutableArray alloc] init];
    SectionName_login = [[NSMutableArray alloc] init];
    SubjectId_login = [[NSMutableArray alloc] init];
    SubjectName_login = [[NSMutableArray alloc] init];
    SectionData_login = [[NSMutableArray alloc] init];
    Subjectresult_login = [[NSMutableArray alloc] init];
    
    Id = [[NSMutableArray alloc]init];
    subject = [[NSMutableArray alloc]init];
    testDate = [[NSMutableArray alloc]init];
    testStartTime = [[NSMutableArray alloc]init];
    testEndTime = [[NSMutableArray alloc]init];
    totalMarks = [[NSMutableArray alloc]init];
    aryForQuestions = [[NSMutableArray alloc]init];
    
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton teacherExamList:ExamListTeacher_link];

    [self loadData];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) ExamList: (NSDictionary *) examlistDict
{
    tempDict = examlistDict;
    firstResponse = [examlistDict objectForKey:@"TestData"];
    for (int i=0; i<[firstResponse count]; i++)
    {
        examListResponse = [firstResponse objectAtIndex:i];
        [Id addObject:[examListResponse objectForKey:@"Id"]];
        [subject addObject:[examListResponse objectForKey:@"SubjectName"]];
        [testDate addObject:[examListResponse objectForKey:@"TestDate"]];
        [testStartTime addObject:[examListResponse objectForKey:@"TestStartTime"]];
        [testEndTime addObject:[examListResponse objectForKey:@"TestEndTime"]];
        [totalMarks addObject:[examListResponse objectForKey:@"TotalMarks"]];
        
        
        // NSLog(@"%@",examListResponse);
    }
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (resultArray.count>=1)
    {
        return [resultArray count];
    }
    else
    {
        return Id.count;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

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
    classRow =[uniqClassIdLogin objectAtIndex:0];
    sectionRow =[uniqSectionIdLogin objectAtIndex:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"examListCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    
    UILabel *lableForID = (UILabel *) [cell viewWithTag:1];
    UILabel *lableForSubject = (UILabel *) [cell viewWithTag:2];
    UILabel *lableForTestDate = (UILabel *) [cell viewWithTag:3];
    UILabel *lableForStartTime = (UILabel *) [cell viewWithTag:4];
    UILabel *lableForEndTime = (UILabel *) [cell viewWithTag:5];
    UILabel *lableForTotalMarks = (UILabel *) [cell viewWithTag:6];
    UIButton *editButton = (UIButton *) [cell viewWithTag:7];
    
    if (resultArray.count>=1)
    {
        lableForID.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"Id"];
        lableForSubject.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"SubjectName"];
        lableForTestDate.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"TestDate"];
        lableForStartTime.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"TestStartTime"];
        lableForEndTime.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"TestEndTime"];
        lableForTotalMarks.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"TotalMarks"];
    }
    else
    {
        
    lableForID.text = [Id objectAtIndex:indexPath.row];
    lableForSubject.text = [subject objectAtIndex:indexPath.row];
    lableForTestDate.text = [testDate objectAtIndex:indexPath.row];
    lableForStartTime.text = [testStartTime objectAtIndex:indexPath.row];
    lableForEndTime.text = [testEndTime objectAtIndex:indexPath.row];
    lableForTotalMarks.text = [totalMarks objectAtIndex:indexPath.row];
    
    }
        return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)editExam:(id)sender
{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    
    catchString = [Id objectAtIndex:indexPath.row];
    NSDictionary *editParameter = @{@"TestId":[Id objectAtIndex:indexPath.row]};
    
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton teacherEditExam:EditExamteacher_link body:editParameter ];

    //-(BOOL)teacherEditExam:(NSString *)url body:(NSDictionary *)body //For editing created exam


}

- (IBAction)addQuestions:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    
    catchString = [Id objectAtIndex:indexPath.row];
    NSDictionary *editParameter = @{@"test_id":[Id objectAtIndex:indexPath.row]};

    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton teacherAddQuestions:AddQuestionsTeacher_link body:editParameter ];

}

- (void) addQuestionsForExam: (NSDictionary *)getQuestionDetailsDict
{
    NSLog(@"%@",getQuestionDetailsDict);
    
    LUTeacherAddQuestionsViewController *pushToAddQuestions = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherAddQuestionsVC"];
    
    pushToAddQuestions.examDetailsPassDict = getQuestionDetailsDict;
    
    [self.navigationController pushViewController:pushToAddQuestions animated:YES];

}

- (void) createExam: (NSDictionary *)createExamDict
{
    NSArray *secondResponse = [createExamDict objectForKey:@"TestData"];
    NSDictionary *temp = [secondResponse objectAtIndex:0];
    
    NSArray *temp2 = [temp objectForKey:@"TestDetail"];
    for (int i=0; i<[temp2 count]; i++)
    {
        NSDictionary *temp3 =[temp2 objectAtIndex:i];
        [aryForQuestions addObject:[temp3 objectForKey:@"NoOfQuestions"]];
    }
    LUTeacherCreateExamViewController *pushToCreateExam = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherCreateExamVC"];
    pushToCreateExam.classIDString = [temp objectForKey:@"ClassId"];
    pushToCreateExam.sectionIDString = [temp objectForKey:@"SectionId"];
    pushToCreateExam.subjectIDString = [temp objectForKey:@"SubjectId"];
    pushToCreateExam.testDurationString = [temp objectForKey:@"TestDuration"];
    pushToCreateExam.testDateIDString = [temp objectForKey:@"TestDate"];
    pushToCreateExam.testStartIDString = [temp objectForKey:@"TestStartTime"];
    pushToCreateExam.totalMarksString = [temp objectForKey:@"TotalMarks"];
    if (temp2.count < 4)
    {
        NSLog(@"Wrong data inserted to : No of questions / Type of questions ");
        
    }
    else
    {
    pushToCreateExam.QuestionTypeId_01 = [aryForQuestions objectAtIndex:0];
    pushToCreateExam.QuestionTypeId_02 = [aryForQuestions objectAtIndex:1];
    pushToCreateExam.QuestionTypeId_03 = [aryForQuestions objectAtIndex:2];
    pushToCreateExam.QuestionTypeId_04 = [aryForQuestions objectAtIndex:3];
    pushToCreateExam.testIDString = catchString;
    }
    [self.navigationController pushViewController:pushToCreateExam animated:YES];
    [_tableView reloadData];
    NSLog(@"%@",createExamDict);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return classNamePickerTwo.count;
//    if (thePickerView.tag == 100)
//    {
//        return classNamePickerTwo.count;
//    }
//    else if (thePickerView.tag == 200)
//    {
//        return sectionArrayPickerTwo.count;
//    }
//    else
//    {
//        return 0;
//    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return classNamePickerTwo[row];
//    if (pickerView.tag == 100)
//    {
//        return classNamePickerTwo[row];
//    }
//    else if (pickerView.tag == 200)
//    {
//        return sectionArrayPickerTwo[row];
//    }
//    else
//    {
//        return nil;
//    }
}

//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
//      inComponent:(NSInteger)component
//{
//    //load table according to class data recieved from Login (returning class Id)
//    if (pickerView == _classSelect)
//    {
//
//
//        classRow =[uniqClassIdLogin objectAtIndex:row]; // [ClassId_login objectAtIndex:[ClassName_login indexOfObject:[ClassName_login objectAtIndex:row]]];
//        sendDict = @{
//                     @"ClassId":classRow,
//                     @"SectionId":sectionRow
//                     };
//        //sectionRow = [SectionId_login objectAtIndex:[SectionName_login indexOfObject:[SectionName_login objectAtIndex:0]]];
//
//
//        //        classRow = classNamePickerTwo;
//        //        [self.tableView reloadData];
//
//        [self populateDataAction:sendDict];
//    }
//
//    //load table according to section data recieved from Login (returning section Id)
//    else if (pickerView == _sectionSelect)
//    {
//        sectionRow =[uniqSectionIdLogin objectAtIndex:row]; // [SectionId_login objectAtIndex:[SectionName_login indexOfObject:[SectionName_login objectAtIndex:row]]];
//        sendDict = @{
//                     @"ClassId":classRow,
//                     @"SectionId":sectionRow
//                     };
//        //[self.tableView reloadData];
//        [self populateDataAction:sendDict];
//    }
//    else
//        NSLog(@"Other Picker View");
//}

@end
