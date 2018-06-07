//
//  LUTeacherSubmittedAssignmentViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherSubmittedAssignmentViewController.h"
#import "LUTeacherSubmittedAssignmentDetailViewCell.h"


@interface LUTeacherSubmittedAssignmentViewController ()

@end

@implementation LUTeacherSubmittedAssignmentViewController
{
    NSDictionary   *responseObjectForSubmit;
    NSString *jsonString;
    NSArray *userLoginList;
    NSArray *userLogoutList;
    NSString *token,*assignmentName;
    NSMutableArray *idArray, *className, *subjectName, *assignmentSubject, *dueDate, *type , *listOfSubmittedStudent, *submittedPages ;
    NSMutableDictionary *dict1;
   
    NSString *temp;
    NSMutableDictionary *catchDict;
    NSMutableArray *ClassId, *ClassName, *Id, *SectionId, *SectionName, *SubjectId, *SubjectName, *SectionData, *Subjectresult;
    NSMutableArray *pageTypeId, *pageTypeName;
    NSArray *sectionDataResponse;
    NSArray *subjectnameResponse, *subjectStateArray;
    NSSet *subjectStates, *subjectNoStates;
    NSString *classRow, *sectionRow, *subjectRow, *pageTypeRow;
    NSArray *SubjectNameTruncated, *SubjectNoTruncated;
    NSString *subjectNameSubmit,*assgnmentTypeSubmit,*assignmentIdSubmit;
    UIDatePicker *datePicker;
    NSInteger submitCount;
}

-(void)initializeData
{
    submitCount = 0;
    idArray = [[NSMutableArray alloc] init];
    className = [[NSMutableArray alloc] init];
    subjectName = [[NSMutableArray alloc] init];
    assignmentSubject = [[NSMutableArray alloc] init];
    dueDate = [[NSMutableArray alloc] init];
    type = [[NSMutableArray alloc] init];
   
   // _assignmentId.text = _editAssignmentId;
  //  _assignmentTypeTextBox.text = _editAssignmentTypeTextBox;
  //  _classNameTextBox.text = _editClassNameTextBox;
 //   _sectionNameTextBox.text = _editSectionNameTextBox;
  //  _subjectNameTextBox.text = _editSubjectName;
    _assignmentDuedateTextBox.text = _editAssignmentDuedateTextBox;
  //  _assignmentSubjectTextBox.text = _editAssignmentSubjectTextBox;
    _assignmentMarkTextBox.text = _editAssignmentMarkTextBox;
    _assignmentDescTextBox.text = _editAssignmentDescTextBox;
    _assignmentAttatchmentTextBox.text = _editAssignmentAttatchmentTextBox;
    dict1 = [[NSMutableDictionary alloc]init];
    catchDict = [[NSMutableDictionary alloc]init];
    _pageTypes = @[@"Ruled", @"Unruled", @"Dotted", @"Blank"];
    
    self.pageTypeSelect.dataSource = self;
    self.pageTypeSelect.delegate = self;
    self.classSelect.dataSource = self;
    self.classSelect.delegate = self;
    self.sectionSelect.dataSource = self;
    self.sectionSelect.delegate = self;
    self.subjectSelect.dataSource = self;
    self.subjectSelect.delegate = self;
    
    
    ClassId = [[NSMutableArray alloc] init];
    ClassName = [[NSMutableArray alloc] init];
    Id = [[NSMutableArray alloc] init];
    SectionId = [[NSMutableArray alloc] init];
    SectionName = [[NSMutableArray alloc] init];
    SubjectId = [[NSMutableArray alloc] init];
    SubjectName = [[NSMutableArray alloc] init];
    SectionData = [[NSMutableArray alloc] init];
    Subjectresult = [[NSMutableArray alloc] init];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    
    [self listingMethod];
    _composeView.hidden = YES;
    _submittedList.hidden = YES;
}
-(void)listingMethod
{
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton LUTeacherAssignmentList:Listing_link ];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    
    return  [idArray count];
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        // _submitTableView.allowsSelection=NO;
        static NSString *cellIdentifier = @"cellIdForSubmit";
        LUTeacherSubmittedAssignmentDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        //id submitDetailObject = [[responseObjectForSubmit objectForKey:@"Student Submitted"] objectAtIndex:indexPath.row];
        if (cell==nil)
        {
            cell=[[LUTeacherSubmittedAssignmentDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.sl_no.text = [idArray objectAtIndex:indexPath.row];
        cell.class_name.text = [className objectAtIndex:indexPath.row];
        cell.subject_name.text = [subjectName objectAtIndex:indexPath.row];
        cell.AssignmentTitle.text = [assignmentSubject objectAtIndex:indexPath.row];
        cell.due_date.text = [dueDate objectAtIndex:indexPath.row];
        cell.assignment_type.text = [type objectAtIndex:indexPath.row];
        return cell;
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"%@",  [idArray objectAtIndex:indexPath.row]);
    
    NSDictionary *asID = @{@"AssignmentId":[idArray objectAtIndex:indexPath.row]};
    assignmentName = [assignmentSubject objectAtIndex:indexPath.row];
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton LUTeacherAssignmentGetDetails:getAssignmentDetails body:asID];
    
    
}
-(void)fetchAssignmentDetails:(NSDictionary *)asID
{
    
    if ([[asID objectForKey:@"message"] isEqualToString:@"Record not found"])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Ooops"
                                     message:@"No students submitted this assignment"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
       
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                       
                                        
                                        
                                    }];
        
       
        [alert addAction:yesButton];
       
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
    listOfSubmittedStudent = [[NSMutableArray alloc] init];
    submittedPages  = [[NSMutableArray alloc] init];
    NSArray *temp = [asID objectForKey:@"Assignments"];
    for (int i=0; i<temp.count; i++)
    {
        for (int j=0; j<[[temp objectAtIndex:i] count] ; j++)
        {
           NSLog(@"%@", [[temp objectAtIndex:i] objectForKey:@"SubmittedAssignmentsCount"]);
            NSLog(@"%@", [[temp objectAtIndex:i] objectForKey:@"RejectedAssignmentsCount"]);
            NSLog(@"%@", [[temp objectAtIndex:i] objectForKey:@"RedoAssignmentsCount"]);
            NSLog(@"%@", [[temp objectAtIndex:i] objectForKey:@"ApprovedAssignmentsCount"]);
            
            
            NSArray * arr = [[temp objectAtIndex:i] objectForKey:@"StudentSubmittedAssignments"];
            
                
//important
            submitCount = [arr count];
            for (int i=0; i<arr.count;i++)
            {
                NSDictionary *dict = [arr objectAtIndex:i];
            
                [listOfSubmittedStudent addObject:[dict objectForKey:@"AssignmentDetail"]];
                [submittedPages addObject:[dict objectForKey:@"Pages"]];
             
            }
            
    }
        
        LUTeacherAssignmentSubmitListController *pushToTeacherAssignmentSubmit = [self.storyboard instantiateViewControllerWithIdentifier:@"LUSubmitListController"];
        
        pushToTeacherAssignmentSubmit.submitted =  [[temp objectAtIndex:i] objectForKey:@"SubmittedAssignmentsCount"];
        pushToTeacherAssignmentSubmit.approved = [[temp objectAtIndex:i] objectForKey:@"ApprovedAssignmentsCount"];
        pushToTeacherAssignmentSubmit.redo = [[temp objectAtIndex:i] objectForKey:@"RedoAssignmentsCount"];
        pushToTeacherAssignmentSubmit.rejected = [[temp objectAtIndex:i] objectForKey:@"RejectedAssignmentsCount"];
        
        pushToTeacherAssignmentSubmit.assingmentName = assignmentName;
        pushToTeacherAssignmentSubmit.studList = listOfSubmittedStudent;
        pushToTeacherAssignmentSubmit.pageList= submittedPages;
        [self.navigationController pushViewController:pushToTeacherAssignmentSubmit animated:YES];
}

  
    }
}

-(void) teacherAssignmentList: (NSDictionary*) teacherAssignmentListDict
{
    [self initializeData];
    
                                                           NSArray *testArray = [teacherAssignmentListDict objectForKey:@"Assignments"];
                                                           NSLog(@"%@",testArray);
                                                           for (int i=0; i<[testArray count]; i++)
                                                           {
                                                               NSDictionary *secondDict = [testArray objectAtIndex:i];
                                                               [idArray addObject:[secondDict objectForKey:@"Id"]];
                                                               [className addObject:[secondDict objectForKey:@"ClassName"]];
                                                               [subjectName addObject:[secondDict objectForKey:@"SubjectName"]];
                                                               [assignmentSubject addObject:[secondDict objectForKey:@"AssignmentSubject"]];
                                                               [dueDate addObject:[secondDict objectForKey:@"AssignmentDueDate"]];
                                                               [type addObject:[secondDict objectForKey:@"AssignmentType"]];
                                                           }
                                                           [_submitTableView reloadData];
}


-(void)editAssignment:(NSDictionary *)editData
{
    NSLog(@"%@",editData);
    _composeView.hidden = NO;
    _pageTypeSelect.hidden=YES;
    [self getDetails];
    assignmentIdSubmit = [editData objectForKey:@"Id"];
    
    _assignmentDuedateTextBox.text = [editData objectForKey:@"AssignmentDueDate"];
    _assignmentMarkTextBox.text = [editData objectForKey:@"AssignmentMark"];
    _assignmentAttatchmentTextBox.text = [editData objectForKey:@"AssignmentAttachment"];
    _assignmentDescTextBox.text = [editData objectForKey:@"AssignmentDescription"];
  
}

- (IBAction)submitAssignmentAction:(id)sender
{
    if (assignmentIdSubmit != nil)
    {
        [catchDict setValue:assignmentIdSubmit forKey:@"AssignmentId"];
    }
    [catchDict setValue:assgnmentTypeSubmit forKey:@"AssignmentTypeId"];
    
    [catchDict setValue:pageTypeRow forKey:@"PageTypeId"];
    
    [catchDict setValue:classRow forKey:@"ClassId"];
    
    [catchDict setValue:sectionRow forKey:@"SectionId"];
    
    [catchDict setValue:subjectRow forKey:@"SubjectId"];
    
    if (_assignmentDuedateTextBox.text.length == 0 || _assignmentTitleTextBox.text.length == 0 || _assignmentMarkTextBox.text.length == 0 || _assignmentDescTextBox.text.length == 0 )
    {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Missing"
                                     message:@"Field Missing"
                                     preferredStyle:UIAlertControllerStyleAlert];
     
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                       
                                    }];
        
     
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else
    {
        [catchDict setValue:_assignmentDuedateTextBox.text forKey:@"AssignmentDueDate"];
        
        [catchDict setValue:_assignmentTitleTextBox.text forKey:@"AssignmentSubject"];
        
        [catchDict setValue:_assignmentMarkTextBox.text forKey:@"AssignmentMark"];
        
        [catchDict setValue:_assignmentDescTextBox.text forKey:@"AssignmentDescription"];
        
        [catchDict setValue:_assignmentAttatchmentTextBox.text forKey:@"AssignmentAttachment"];
        
        
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        [sharedSingleton LUTeacherAssignmentSubmit:Add_assignment body:catchDict];
    }
}

- (IBAction)deleteAction:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_submitTableView];
    NSIndexPath *indexPath = [_submitTableView indexPathForRowAtPoint:buttonPosition];
    NSDictionary *deleteParameter = @{@"AssignmentId":[idArray objectAtIndex:indexPath.row]};
    NSLog(@"%@",deleteParameter);
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton LUTeacherAssignmentDelete:Delete_link body:deleteParameter];
}

-(void)deleteAssignment: (NSDictionary *)deleteAssignment
{
    [self initializeData];
    
    [self listingMethod];
}
- (IBAction)editAction:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_submitTableView];
    NSIndexPath *indexPath = [_submitTableView indexPathForRowAtPoint:buttonPosition];
   
    NSDictionary *editParameter = @{@"AssignmentId":[idArray objectAtIndex:indexPath.row]};
    
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton LUTeacherAssignmentEdit:Edit_link body:editParameter ];
    
   
}


-(void)dismissMe
{
    [self listingMethod];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)composeAssignmentAction:(id)sender
{
    _composeView.hidden = NO;
    _pageTypeSelect.hidden=YES;
    datePicker = [[UIDatePicker alloc]init];
    CGRect frame = datePicker.frame;
    frame.size.width = 300;
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.assignmentDuedateTextBox setInputView:datePicker];
    [self getDetails];

}
-(void)updateTextField:(id)sender
{
    self.assignmentDuedateTextBox.text = [NSString stringWithFormat:@"%@",datePicker.date];
    datePicker.minimumDate=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.assignmentDuedateTextBox.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.assignmentDuedateTextBox resignFirstResponder];
}
- (void)getDetails
{
    NSDictionary *base =  [LUOperation getSharedInstance].userProfileDetails;
    
    NSDictionary *secondResponse = [base objectForKey:@"item"];
    NSArray *classSubjectDataResponse = [secondResponse objectForKey:@"ClassSubjectData"];
    NSLog(@"%@",classSubjectDataResponse);
    //NSArray *a1 = [classSubjectDataResponse objectAtIndex:0];
    
    for (int i=0; i<classSubjectDataResponse.count; i++)
    {
        
        
        NSDictionary *responseOne = [classSubjectDataResponse objectAtIndex:i];
        
        
        [ClassId addObject:[responseOne objectForKey:@"ClassId"]];
        [ClassName addObject:[responseOne objectForKey:@"ClassName"]];
        [SectionData addObject:[responseOne objectForKey:@"sectiondata"]];
        
        
        sectionDataResponse = [SectionData objectAtIndex:i];
        
        for (int i=0; i<[sectionDataResponse count]; i++)
        {
            NSDictionary *subjectResultResponse = [sectionDataResponse objectAtIndex:i];
            NSLog(@"%@",subjectResultResponse);
            [SectionId addObject:[subjectResultResponse objectForKey:@"SectionId"]];
            [SectionName addObject:[subjectResultResponse objectForKey:@"SectionName"]];
            [Subjectresult addObject:[subjectResultResponse objectForKey:@"subjectresult"]];
        }
        
        for (int j=0; j<[Subjectresult count]; j++)
        {
            subjectnameResponse = [Subjectresult objectAtIndex:j];
            for (int i=0; i<[subjectnameResponse count]; i++)
            {
                NSDictionary *subjectnameResponseTwo = [subjectnameResponse objectAtIndex:i];
                NSLog(@"%@",subjectnameResponseTwo);
                [SubjectId addObject:[subjectnameResponseTwo objectForKey:@"SubjectId"]];
                [SubjectName addObject:[subjectnameResponseTwo objectForKey:@"SubjectName"]];
            }
        }
    }
    subjectStates = [NSSet setWithArray:SubjectName];
    subjectNoStates = [NSSet setWithArray:SubjectId];
    SubjectNameTruncated = [subjectStates allObjects];
    SubjectNoTruncated = [subjectNoStates allObjects];
    
    
    NSLog(@"JSONArray = %@",userLoginList);
    classRow = [ClassId objectAtIndex:[ClassName indexOfObject:[ClassName objectAtIndex:0]]];
    sectionRow = [SectionId objectAtIndex:[SectionName indexOfObject:[SectionName objectAtIndex:0]]];
    subjectRow = [SubjectId objectAtIndex:[SubjectName indexOfObject:[SubjectNameTruncated objectAtIndex:0]]];
    
    [_classSelect reloadAllComponents];
    [_sectionSelect reloadAllComponents];
    [_subjectSelect reloadAllComponents];
}


- (void)setSegmentsForAssignmentType:(NSArray *)segments
{
    [_assignmentTypeSegment removeAllSegments];
    
    for (NSString *segment in segments)
    {
        [_assignmentTypeSegment insertSegmentWithTitle:segment atIndex:_assignmentTypeSegment.numberOfSegments animated:NO];
    }
}

- (IBAction)assignmentTypeSegTapped:(id)sender
{
    if (_assignmentTypeSegment.selectedSegmentIndex==0)
    {
        
        pageTypeRow = @"10";
        assgnmentTypeSubmit=@"1";
       // _assignmentTypeTextBox.text = @"1";
        _pageTypeSelect.hidden=YES;
    }
    else if (_assignmentTypeSegment.selectedSegmentIndex==1)
    {
        
     //   _assignmentTypeTextBox.text = @"2";
        assgnmentTypeSubmit=@"2";
        _pageTypeSelect.hidden=NO;
        NSLog(@"WRITE TAPPED");
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        [sharedSingleton LUTeacherAssignmentPageType:Page_type_link ];

   }
}
-(void)getPagetype:(NSDictionary *)pageType
{
    NSArray *response = [pageType objectForKey:@"TestData"];
    pageTypeId = [[NSMutableArray alloc] init];
    pageTypeName = [[NSMutableArray alloc] init];
    for (int i=0; i<response.count; i++)
    {
        NSDictionary *responseTwo = [response objectAtIndex:i];
        
        [pageTypeId addObject:[responseTwo objectForKey:@"Id"]];
        [pageTypeName addObject:[responseTwo objectForKey:@"PageTypeName"]];
    }
    
    NSArray *testArray = [pageType objectForKey:@"Assignments"];
    NSLog(@"%@",testArray);
    [_pageTypeSelect reloadAllComponents];
    pageTypeRow = [pageTypeId objectAtIndex:[pageTypeName indexOfObject:[pageTypeName objectAtIndex:0]]];
}




// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 100)
    {
        return ClassName[row];
    }
    else if (pickerView.tag == 200)
    {
        return SectionName[row];
    }
    else if (pickerView.tag == 300)
    {
        return SubjectNameTruncated[row];
    }
    else if (pickerView.tag == 400)
    {
        return pageTypeName[row];
    }
    else
    {
        NSLog(@"Not selected");
        return nil;
    }
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 100)
    {
        return ClassName.count;
    }
    else if (pickerView.tag == 200)
    {
        return SectionName.count;
    }
    else if (pickerView.tag == 300)
    {
        return SubjectNameTruncated.count;
    }
    else if (pickerView.tag == 400)
    {
        return pageTypeName.count;
    }
    else
    {
        NSLog(@"Not selected");
        return 0;
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == _classSelect)
    {
        classRow = [ClassId objectAtIndex:[ClassName indexOfObject:[ClassName objectAtIndex:row]]];
    }
    else if (pickerView == _sectionSelect)
    {
        sectionRow = [SectionId objectAtIndex:[SectionName indexOfObject:[SectionName objectAtIndex:row]]];
    }
    else if (pickerView == _subjectSelect)
    {
        subjectRow = [SubjectId objectAtIndex:[SubjectName indexOfObject:[SubjectNameTruncated objectAtIndex:row]]];
        subjectNameSubmit = [SubjectNameTruncated objectAtIndex:row];
    }
    else if (pickerView == _pageTypeSelect)
    {
        pageTypeRow = [pageTypeId objectAtIndex:[pageTypeName indexOfObject:[pageTypeName objectAtIndex:row]]];
    }
}
- (IBAction)cancelCompose:(id)sender {
    _composeView.hidden = YES;
    [self dismissMe];
}

@end
