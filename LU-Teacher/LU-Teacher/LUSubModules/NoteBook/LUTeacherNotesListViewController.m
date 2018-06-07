//
//  LUTeacherNotesListViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherNotesListViewController.h"

@interface LUTeacherNotesListViewController ()

@end

@implementation LUTeacherNotesListViewController
{
    NSUInteger idx;
    NSDictionary   *responseObject;
    NSArray *resultArray ;
    NSArray *userLoginList;
    NSArray *userLogoutList;
    NSString *token,*studentID;
    NSDictionary *sendDict;
    NSDictionary *studentList;
    NSMutableArray *Id, *AdmissionDate, *CityName, *ClassName, *CountryName, *DateOfBirth, *DocumentsImage, *EmergencyContactNumber, *Gender,
    *GradeCompleted, *PreviousSchool, *SectionName, *StateName, *StudentAddress, *StudentEmail, *StudentFirstName, *StudentLastName,
    *StudentMiddleName, *StudentMobileNumber, *StudentProfileImage, *StudentRollNumber, *StudentZipCode, *TelephoneNumber, *Transport, *Hostel;
    NSMutableArray *ClassId_login, *ClassName_login, *Id_login, *SectionId_login, *SectionName_login, *SubjectId_login,
    *SubjectName_login, *SectionData_login, *Subjectresult_login;
    NSArray *sectionDataResponse;
    NSArray *subjectnameResponse, *subjectStateArray;
    NSString *classRow, *sectionRow, *subjectRow, *pageTypeRow;
    NSMutableArray *classStdLst, *sectionStdLst;
    NSDictionary *responseOne;
    
    NSMutableDictionary *tempDict;
    
    NSMutableArray *classNamePicker;
    NSMutableArray *sectionNamePicker;
    NSMutableArray *subjectList,*unitList,*topicList;
    NSArray *classNamePickerTwo,*sectionArrayPickerTwo,*uniqClassIdLogin,*uniqSectionIdLogin, *selectionArrUnit,* topicdata;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialiser];
    self.classSelect.dataSource = self;
    self.classSelect.delegate = self;
    self.sectionSelect.dataSource = self;
    self.sectionSelect.delegate = self;
    _notesSubjectTable.hidden =YES;
    _topicTable.hidden =YES;
    _unitSelection.hidden = YES;
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)initialiser{
    classStdLst= [[NSMutableArray alloc]init];
    sectionStdLst= [[NSMutableArray alloc]init];
    
    classNamePicker = [[NSMutableArray alloc]init];
    sectionNamePicker = [[NSMutableArray alloc]init];
    Id= [[NSMutableArray alloc]init];
    AdmissionDate = [[NSMutableArray alloc]init];
    CityName = [[NSMutableArray alloc]init];
    ClassName = [[NSMutableArray alloc]init];
    CountryName = [[NSMutableArray alloc]init];
    DateOfBirth = [[NSMutableArray alloc]init];
    DocumentsImage = [[NSMutableArray alloc]init];
    EmergencyContactNumber = [[NSMutableArray alloc]init];
    Gender = [[NSMutableArray alloc]init];
    GradeCompleted = [[NSMutableArray alloc]init];
    PreviousSchool = [[NSMutableArray alloc]init];
    SectionName = [[NSMutableArray alloc]init];
    StateName = [[NSMutableArray alloc]init];
    StudentAddress = [[NSMutableArray alloc]init];
    StudentEmail = [[NSMutableArray alloc]init];
    StudentFirstName = [[NSMutableArray alloc]init];
    StudentLastName = [[NSMutableArray alloc]init];
    StudentMiddleName = [[NSMutableArray alloc]init];
    StudentMobileNumber = [[NSMutableArray alloc]init];
    StudentProfileImage = [[NSMutableArray alloc]init];
    StudentRollNumber = [[NSMutableArray alloc]init];
    StudentZipCode = [[NSMutableArray alloc]init];
    TelephoneNumber = [[NSMutableArray alloc]init];
    Hostel = [[NSMutableArray alloc]init];
    Transport = [[NSMutableArray alloc]init];
    
    ClassId_login = [[NSMutableArray alloc] init];
    ClassName_login = [[NSMutableArray alloc] init];
    Id_login = [[NSMutableArray alloc] init];
    SectionId_login = [[NSMutableArray alloc] init];
    SectionName_login = [[NSMutableArray alloc] init];
    SubjectId_login = [[NSMutableArray alloc] init];
    SubjectName_login = [[NSMutableArray alloc] init];
    SectionData_login = [[NSMutableArray alloc] init];
    Subjectresult_login = [[NSMutableArray alloc] init];
    
    unitList = [[NSMutableArray alloc] init];
    topicList = [[NSMutableArray alloc] init];
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    resultArray = [[responseOne objectForKey:@"StudentDetails"]
                   filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"StudentFirstName contains[c] %@", searchText]];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText
                               scope:[[self.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchBar
                                                     selectedScopeButtonIndex]]];
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
    
    classRow =[uniqClassIdLogin objectAtIndex:0];   // [ClassId_login objectAtIndex:[ClassName_login indexOfObject:[ClassName_login objectAtIndex:0]]];
    sectionRow =[uniqSectionIdLogin objectAtIndex:0]; // [SectionId_login objectAtIndex:[SectionName_login indexOfObject:[SectionName_login objectAtIndex:0]]];
    sendDict = @{
                 @"ClassId":classRow,
                 @"SectionId":sectionRow
                 };
    //subjectRow = [SubjectId_login objectAtIndex:[SubjectName_login indexOfObject:
    //[SubjectNameTruncated objectAtIndex:0]]];
    [_classSelect reloadAllComponents];
    [_sectionSelect reloadAllComponents];
    //[_subjectSelect reloadAllComponents];
    [self populateDataAction:sendDict];
    
}
//this method self called in loginAction()
- (IBAction)populateDataAction:(NSDictionary *)body
{
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton studentList:Student_details body:body];
    
}

- (void) dockStudentList: (NSDictionary *)studentListDict
{
    [self initialiser];
    responseOne = [studentListDict objectForKey:@"StudentData"];
    NSArray *responseTwo = [responseOne objectForKey:@"StudentDetails"];
    for (int i=0; i<[responseTwo count ]; i++)
    {
        NSDictionary *responseThree = [responseTwo objectAtIndex:i];
        [Id addObject:[responseThree objectForKey:@"Id"]];
        [ClassName addObject:[responseThree objectForKey:@"ClassName"]];
        [SectionName addObject:[responseThree objectForKey:@"SectionName"]];
        [sectionStdLst addObject:[responseThree objectForKey:@"SectionName"]];
        [StudentEmail addObject:[responseThree objectForKey:@"StudentEmail"]];
        [StudentFirstName addObject:[responseThree objectForKey:@"StudentFirstName"]];
        [StudentLastName addObject:[responseThree objectForKey:@"StudentLastName"]];
        [StudentProfileImage addObject:[responseThree objectForKey:@"StudentProfileImage"]];
       
    }
   
    [self.tableView reloadData];
}
- (void) notesSubjectList: (NSDictionary *) subjectlist
{

    subjectList = [[NSMutableArray alloc] init];
    NSArray *ar1 = [subjectlist objectForKey:@"Notes"];
    
    for (int i=0; i<ar1.count; i++)
    {
       [ subjectList addObject: [[[subjectlist objectForKey:@"Notes"] objectAtIndex:i] objectForKey:@"SubjectName"]];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
       NSMutableArray *temp1 = [[NSMutableArray alloc]init];
        
        for (int j=0; j<[[[[subjectlist objectForKey:@"Notes"] objectAtIndex:i] objectForKey:@"unitdata"] count]; j++)
        {
          [temp addObject: [[[[[subjectlist objectForKey:@"Notes"] objectAtIndex:i] objectForKey:@"unitdata"] objectAtIndex:j] objectForKey:@"UnitName"]];
          [temp1 addObject: [[[[[subjectlist objectForKey:@"Notes"] objectAtIndex:i] objectForKey:@"unitdata"] objectAtIndex:j] objectForKey:@"notesdata"]];
            
  
        }
        [ topicList addObject:temp1];
        [unitList addObject:temp];
    }
    
    
    [_notesSubjectTable reloadData];
    
}
//- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
//{
//
//    if(indexPath.row % 2 == 0)
//    cell.backgroundColor = [UIColor colorWithRed:0.85 green:0.82 blue:0.91 alpha:1.0];
//    else
//    cell.backgroundColor = [UIColor whiteColor];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    if (tableView == _tableView) {
        
        
        
        static NSString *cellIdentifier = @"cellId";
        
        LUTeacherNotesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[LUTeacherNotesListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (resultArray.count>=1)
        {
            _notesSubjectTable.hidden = YES;
            _unitSelection.hidden = YES;
            _topicTable.hidden = YES;
            cell.sName.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentFirstName"];
            
            cell.sClass.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"ClassName"];
            
            
            cell.sImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:
                                                                                      [[resultArray objectAtIndex:indexPath.row]objectForKey:@"StudentProfileImage"]]]];
            cell.sImage.layer.cornerRadius = 25;
            
            cell.sImage.layer.masksToBounds = YES;
            
            
        }
        
        else
        {
            
            cell.sName.text = [StudentFirstName objectAtIndex:indexPath.row];
            
            cell.sClass.text = [ClassName objectAtIndex:indexPath.row];
            
            
            cell.sImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[StudentProfileImage  objectAtIndex:indexPath.row] ]]];
            
            cell.sImage.layer.cornerRadius = 25;
            
            cell.sImage.layer.masksToBounds = YES;
            
            
        }
         return cell;
    }else if (tableView == _notesSubjectTable)
    {
        static NSString *cellIdentifier = @"subId";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        UILabel *sublbl = (UILabel *)[cell viewWithTag:104];
        sublbl.text = [subjectList objectAtIndex:indexPath.row];
        return cell;
    }
    else if(tableView == _topicTable)
    {
    //topicCell
        static NSString *cellIdentifier = @"topicCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        UIImageView *coverimg = (UIImageView *)[cell viewWithTag:200];
        
        coverimg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[topicdata objectAtIndex:indexPath.row] objectForKey:@"CategoryThumbinal"]]]];
        
        UILabel *sublbl = (UILabel *)[cell viewWithTag:201];
        sublbl.text = [[topicdata objectAtIndex:indexPath.row] objectForKey:@"TopicName"];
        return cell;
        
        
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger retVal;
   if (tableView == _tableView) {
    if (resultArray.count>=1)
    {
        retVal = [resultArray count];
    } else
    {
        retVal = [StudentFirstName count];
    }
   }else if (tableView == _notesSubjectTable)
   {
       retVal= [subjectList count];
   }else if(tableView == _topicTable)
   {
     retVal = [topicdata count];
   }
    return retVal;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger retVal;
    if (tableView == _tableView) {
       
            retVal =100;
      
    }else if (tableView == _notesSubjectTable)
    {
        retVal= 100;
    }else if(tableView == _topicTable)
    {
        retVal= 350;
    }
    return retVal;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        _unitSelection.hidden = YES;
        _notesSubjectTable.hidden =NO;
        _topicTable.hidden = YES;
        NSLog(@"%@",[Id objectAtIndex:indexPath.row]);
        
        //NotesSubjectList
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        [sharedSingleton notesSubjectList:NotesSubjectList body:@{@"StudentId":[Id objectAtIndex:indexPath.row]}];
        studentID = [Id objectAtIndex:indexPath.row];
        
    }else if (tableView == _notesSubjectTable)
    {
        _unitSelection.hidden = YES;
        _topicTable.hidden = YES;
        
        selectionArrUnit = [unitList objectAtIndex:indexPath.row];
        if (selectionArrUnit.count >0)
        {
            idx = indexPath.row;
            _unitSelection.hidden = NO;
            sectionRow =[selectionArrUnit objectAtIndex:0];
            self.unitSelection.delegate = self;
            self.unitSelection.dataSource = self;
            [_unitSelection  reloadAllComponents];
        }else
        {
            _unitSelection.hidden = YES;
            _topicTable.hidden = YES;
        }
        
    }else if(tableView == _topicTable)
    {
        [[topicdata objectAtIndex:indexPath.row] objectForKey:@"TopicName"];
        LUWriteNotesViewController *pushToWrite = [self.storyboard instantiateViewControllerWithIdentifier:@"LUStudentWriteNotesVC"];
        NSCharacterSet *notAllowedChars  =  [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
        
        NSString* filteredUnitName  =  [[[[topicdata objectAtIndex:indexPath.row] objectForKey:@"TopicName"] componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        //pushToWrite.FlashCoverImage = [cellData objectForKey:@"CategoryThumbinal"];
        //pushToWrite.FlashSubjectName = [cellData objectForKey:@"subject_name"];
        pushToWrite.FlashUniteNo = @"";
        pushToWrite.FlashUniteName = filteredUnitName;
        pushToWrite.FlashPageType = @"";
        pushToWrite.moduleName = @"Notes";
        pushToWrite.isTeacherAssignment = NO;
        pushToWrite.isTeacherNotes = YES;
        pushToWrite.studentId = studentID;
        pushToWrite.subjectCategoryId = [[topicdata objectAtIndex:indexPath.row] objectForKey:@"UnitTopicId"];
//        pushToWrite.studentClassId = [[_studList objectAtIndex:indexPath.row ] objectForKey:@"ClassId"];
//        pushToWrite.studentSectionId = [[_studList objectAtIndex:indexPath.row ] objectForKey:@"SectionId"];
        
        BOOL success  =  NO;
        success  =  [[LUNotesMainDataManager getSharedInstance]createDB:filteredUnitName];
        NSLog(success ? @"Yes Notes created" : @"No notes created");
        [self.navigationController pushViewController:pushToWrite animated:YES];
        
        
        
        
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (thePickerView.tag == 100)
    {
        return classNamePickerTwo.count;
    }
    else if (thePickerView.tag == 200)
    {
        return sectionArrayPickerTwo.count;
    }
    else if (thePickerView.tag == 300)
    {
        
        return selectionArrUnit.count;
    }else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 100)
    {
        return classNamePickerTwo[row];
    }
    else if (pickerView.tag == 200)
    {
        return sectionArrayPickerTwo[row];
    }
    else if (pickerView.tag == 300)
    {
        return selectionArrUnit[row];
    }else
    {
        return nil;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    //load table according to class data recieved from Login (returning class Id)
    if (pickerView == _classSelect)
    {
        _notesSubjectTable.hidden = YES;
        _unitSelection.hidden = YES;
        _topicTable.hidden = YES;
        
        classRow =[uniqClassIdLogin objectAtIndex:row]; // [ClassId_login objectAtIndex:[ClassName_login indexOfObject:[ClassName_login objectAtIndex:row]]];
        sendDict = @{
                     @"ClassId":classRow,
                     @"SectionId":sectionRow
                     };
        //sectionRow = [SectionId_login objectAtIndex:[SectionName_login indexOfObject:[SectionName_login objectAtIndex:0]]];
        
        
        //        classRow = classNamePickerTwo;
        //        [self.tableView reloadData];
        
        [self populateDataAction:sendDict];
    }
    
    //load table according to section data recieved from Login (returning section Id)
    else if (pickerView == _sectionSelect)
    {
        _notesSubjectTable.hidden = YES;
        _unitSelection.hidden = YES;
        _topicTable.hidden = YES;
        sectionRow =[uniqSectionIdLogin objectAtIndex:row]; // [SectionId_login objectAtIndex:[SectionName_login indexOfObject:[SectionName_login objectAtIndex:row]]];
        sendDict = @{
                     @"ClassId":classRow,
                     @"SectionId":sectionRow
                     };
        //[self.tableView reloadData];
        [self populateDataAction:sendDict];
    }else if (pickerView == _unitSelection)
    {
       
        sectionRow =[selectionArrUnit objectAtIndex:row];
          topicdata = [[topicList objectAtIndex:idx] objectAtIndex: [selectionArrUnit indexOfObject:sectionRow] ];
        if (topicList.count>0)
        {
           
            _topicTable.hidden = NO;
            
            
            [_topicTable reloadData];
        }
        else
        {
            _topicTable.hidden = YES;
            //alert
        }
    }
    else
    NSLog(@"Other Picker View");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
