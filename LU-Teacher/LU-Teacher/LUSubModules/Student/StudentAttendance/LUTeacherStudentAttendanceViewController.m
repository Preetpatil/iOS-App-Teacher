//
//  LUTeacherStudentAttendanceViewController.m
//  //  LUTeacher
//
//  Created by Lucas on 11/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import "LUTeacherStudentAttendanceViewController.h"

@interface LUTeacherStudentAttendanceViewController ()

@end

@implementation LUTeacherStudentAttendanceViewController
{
    NSDictionary *responseObject;
    // NSMutableDictionary *catchAbsent;
    NSMutableArray *body;
    //NSDictionary *searchResults;
    NSArray *resultArray ;
    NSArray *userLoginList;
    NSArray *userLogoutList;
    NSString *token;
    NSDictionary *sendDict;
    NSMutableArray *ClassName, *Id, *StudentAddress, *StudentEmail, *StudentFirstName, *StudentLastName, *StudentMiddleName,
    *StudentMobileNumber,* StudentProfileImage,* StudentRollNumber;
    NSArray *attendanceResponse;
    NSDictionary *studentList;
    NSDictionary *searchAtten,*attndncResponse;
    NSString *teacherName;
    NSString *teacherProfile;
    NSArray *classNamePickerTwo,*sectionArrayPickerTwo,*uniqClassIdLogin,*uniqSectionIdLogin;
    NSArray *sectionDataResponse;
    NSArray *subjectnameResponse, *subjectStateArray;
    NSString *classRow, *sectionRow, *subjectRow, *pageTypeRow;
    NSMutableArray *ClassId_login, *ClassName_login, *Id_login, *SectionId_login, *SectionName_login, *SubjectId_login,
    *SubjectName_login, *SectionData_login, *Subjectresult_login;
    NSString *theDate;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self initilise];
    [self loadData];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *now = [[NSDate alloc] init];
    theDate = [dateFormat stringFromDate:now];

    
    
    sendDict = @{
                 @"AttendanceDate":theDate,
                 @"ClassId":@"1",
                 @"SectionId":@"1"
                 };
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton studentAttendance:Student_attendance_details body:sendDict];
}

//- (IBAction)populateDataAction:(NSDictionary *)body
//{
//    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
//    sharedSingleton.LUDelegateCall=self;
//    [sharedSingleton studentList:Student_details body:body];
//
//}

- (void) populateDataAttendance:(NSDictionary *)body
{
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton studentAttendance:Student_attendance_details body:sendDict];
}

- (void) studentAttendanceResponse: (NSDictionary *) attendanceDetails
{
    [self initilise];
    
    attndncResponse =  attendanceDetails;
    NSLog(@"JSONArray = %@",attendanceDetails);
    
    _messageText.text = @"populate table";
    attendanceResponse = [attendanceDetails objectForKey:@"Attendance"];
    // searchAtten = [studentList objectForKey:@"Attendance"];
    for (int i=0; i< [attendanceResponse count]; i++)
    {
        NSDictionary *firstResponse = [attendanceResponse objectAtIndex:i];
        [ClassName addObject:[firstResponse objectForKey:@"ClassName"]];
        [Id addObject:[firstResponse objectForKey:@"Id"]];
        [StudentAddress addObject:[firstResponse objectForKey:@"StudentAddress"]];
        [StudentEmail addObject:[firstResponse objectForKey:@"StudentEmail"]];
        [StudentFirstName addObject:[firstResponse objectForKey:@"StudentFirstName"]];
        [StudentLastName addObject:[firstResponse objectForKey:@"StudentLastName"]];
        [StudentMiddleName addObject:[firstResponse objectForKey:@"StudentMiddleName"]];
        [StudentMobileNumber addObject:[firstResponse objectForKey:@"StudentMobileNumber"]];
        [StudentProfileImage addObject:[firstResponse objectForKey:@"StudentProfileImage"]];
        [StudentRollNumber addObject:[firstResponse objectForKey:@"StudentRollNumber"]];
    }
    [self.tableView reloadData];

}
-(void)initilise
{
    
    ClassId_login = [[NSMutableArray alloc] init];
    ClassName_login = [[NSMutableArray alloc] init];
    Id_login = [[NSMutableArray alloc] init];
    SectionId_login = [[NSMutableArray alloc] init];
    SectionName_login = [[NSMutableArray alloc] init];
    SubjectId_login = [[NSMutableArray alloc] init];
    SubjectName_login = [[NSMutableArray alloc] init];
    SectionData_login = [[NSMutableArray alloc] init];
    Subjectresult_login = [[NSMutableArray alloc] init];

    ClassName = [[NSMutableArray alloc]init];
    Id = [[NSMutableArray alloc]init];
    StudentAddress = [[NSMutableArray alloc]init];
    StudentEmail = [[NSMutableArray alloc]init];
    StudentFirstName = [[NSMutableArray alloc]init];
    StudentLastName = [[NSMutableArray alloc]init];
    StudentMiddleName = [[NSMutableArray alloc]init];
    StudentMobileNumber = [[NSMutableArray alloc]init];
    StudentProfileImage = [[NSMutableArray alloc]init];
    StudentRollNumber = [[NSMutableArray alloc]init];
    body = [[NSMutableArray alloc]init];
    
    _searchBar.layer.cornerRadius = 20;
    _searchBar.clipsToBounds = YES;
    [_searchBar.layer setBorderWidth:1];
    [_searchBar.layer setBorderColor:[UIColor grayColor].CGColor];
    
    [_numberLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_nameLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_absentLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_emailLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_contactLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_addressLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_studentAttendanceLabel setFont:[UIFont boldSystemFontOfSize:25]];
    
    _teacherNameLabel.layer.masksToBounds = YES;
    _teacherNameLabel.layer.cornerRadius = 10;
    [_teacherNameLabel.layer setBorderWidth:1];
    [_teacherNameLabel.layer setBorderColor:[UIColor grayColor].CGColor];
    
    //    _teacherNameLabel.layer.shadowColor = [_teacherNameLabel.textColor CGColor];
    //    _teacherNameLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    //    _teacherNameLabel.layer.shadowRadius = 2;
    //    _teacherNameLabel.layer.shadowOpacity = 0.25;
    //    _teacherNameLabel.layer.masksToBounds = NO;
    //    _teacherNameLabel.layer.shouldRasterize = YES;
    
    _detailsBarOne.layer.cornerRadius = 5;
    
    // [self.tableView setSeparatorColor:[UIColor colorWithRed:0.40 green:0.31 blue:0.65 alpha:1.0]];

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
    
    
    
//    classRow =[uniqClassIdLogin objectAtIndex:0];   // [ClassId_login objectAtIndex:[ClassName_login indexOfObject:[ClassName_login objectAtIndex:0]]];
//    sectionRow =[uniqSectionIdLogin objectAtIndex:0]; // [SectionId_login objectAtIndex:[SectionName_login indexOfObject:[SectionName_login objectAtIndex:0]]];
//    sendDict = @{
//                 @"ClassId":classRow,
//                 @"SectionId":sectionRow
//                 };
//    //subjectRow = [SubjectId_login objectAtIndex:[SubjectName_login indexOfObject:
    //[SubjectNameTruncated objectAtIndex:0]]];
    [_classSelection reloadAllComponents];
    [_sectionSelection reloadAllComponents];
    //[_subjectSelect reloadAllComponents];
    //[self populateDataAction:sendDict];
    
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    resultArray = [[attndncResponse objectForKey:@"Attendance"]
                   filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"StudentFirstName contains[c] %@", searchText]];
    NSLog(@"%@",resultArray);
    [self.tableView reloadData];}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self filterContentForSearchText:searchText
                               scope:[[self.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchBar
                                                     selectedScopeButtonIndex]]];
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = [UIColor colorWithRed:0.85 green:0.82 blue:0.91 alpha:1.0];
    else
        cell.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // id studentDetailObject = [[responseObject objectForKey:@"Student Details"] objectAtIndex:indexPath.row];
    tableView.allowsSelection = NO;
    
    static NSString *cellIdentifier = @"cellId";
    
    LUTeacherStudentAttendanceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell==nil)
    {
        cell=[[LUTeacherStudentAttendanceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.absentSwitch setOn:NO];
    cell.absentSwitch.tag = indexPath.row;
    
    [cell.absentSwitch addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
    
    //Loading table with search result data
    if (resultArray.count>=1)
    {
        cell.studentId.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"Id"];
        
        cell.studentName.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentFirstName"];
        
        cell.studentClass.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"ClassName"];
        
        cell.studentEmail.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentEmail"];
        
        cell.studentContact.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentMobileNumber"];
        
        cell.studentAddress.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentAddress"];
        
        cell.studentProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:
                                                                                          [[resultArray objectAtIndex:indexPath.row]objectForKey:@"StudentProfileImage"]]]];
        cell.studentProfile.layer.cornerRadius = 30;
        
        cell.studentProfile.layer.masksToBounds = YES;
        
        cell.layer.cornerRadius = 5;
        
    }
    
    //Loading table with all the data
    else
    {
        cell.studentId.text = [Id objectAtIndex:indexPath.row];
        
        NSMutableDictionary  *absentDict = [[NSMutableDictionary alloc]init];
        
        [absentDict setObject:[Id objectAtIndex:indexPath.row] forKey:@"StudentId"];
        
        [absentDict setObject:@"0" forKey:@"Status"];
        
        [body addObject:absentDict];
        
        cell.studentName.text = [StudentFirstName objectAtIndex:indexPath.row];
        
        cell.studentClass.text = [ClassName objectAtIndex:indexPath.row];
        
        cell.studentEmail.text = [StudentEmail objectAtIndex:indexPath.row];
        
        cell.studentContact.text = [StudentMobileNumber objectAtIndex:indexPath.row];
        
        cell.studentAddress.text = [StudentAddress objectAtIndex:indexPath.row];
        
        cell.studentProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                            [NSURL URLWithString:[StudentProfileImage objectAtIndex:indexPath.row]]]];
        cell.studentProfile.layer.cornerRadius = 30;
        
        cell.studentProfile.layer.masksToBounds = YES;
        
        cell.layer.cornerRadius = 5;
        
    }
    return cell;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (thePickerView.tag == 10)
    {
        return classNamePickerTwo.count;
    }
    else if (thePickerView.tag == 20)
    {
        return sectionArrayPickerTwo.count;
    }
    else
    {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 10)
    {
        return classNamePickerTwo[row];
    }
    else if (pickerView.tag == 20)
    {
        return sectionArrayPickerTwo[row];
    }
    else
    {
        return nil;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    //load table according to class data recieved from Login (returning class Id)
    if (pickerView == _classSelection)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Change Class"
                                     message:@"Are you sure you want to change the class"
                                     preferredStyle:UIAlertControllerStyleAlert];
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        //[self clearAllData];
                                    
                                        classRow =[uniqClassIdLogin objectAtIndex:row];
                                        sendDict = @{
                                                     @"AttendanceDate":theDate,
                                                     @"ClassId":classRow,
                                                     @"SectionId":sectionRow
                                                     };
                                        [self populateDataAttendance:sendDict];
                                    
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   
                                       [_classSelection reloadAllComponents];
                                       [_sectionSelection reloadAllComponents];
                                   
                                   }];
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
        

    }
    
    //load table according to section data recieved from Login (returning section Id)
    else if (pickerView == _sectionSelection)
    {
       
        
        
        
        
        
        
        
        
        
        
        sectionRow =[uniqSectionIdLogin objectAtIndex:row];
        sendDict = @{
                     @"AttendanceDate":theDate,
                     @"ClassId":classRow,
                     @"SectionId":sectionRow
                     };
        [self populateDataAttendance:sendDict];

    }
    else
        NSLog(@"Other Picker View");
}

- (void)setState:(id)sender
{
    NSString *sId = [Id objectAtIndex: (long)[sender tag]];
    BOOL state = [sender isOn];
    NSString *PorA = state == NO ? @"0" : @"1";
    
    for (int i=0; i<body.count; i++)
    {
        NSDictionary *absentStatus = [body objectAtIndex:i];
        if ([[absentStatus objectForKey:@"StudentId"] isEqualToString:sId])
        {
            [body removeObjectAtIndex:i];
            NSMutableDictionary  *newValue = [[NSMutableDictionary alloc]init];
            [newValue setObject:sId forKey:@"StudentId"];
            [newValue setObject:PorA forKey:@"Status"];
            [body addObject:newValue];
        }
    }
    NSLog(@"%@",body);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
