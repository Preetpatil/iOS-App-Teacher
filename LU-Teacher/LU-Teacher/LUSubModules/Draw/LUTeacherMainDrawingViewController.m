//
//  LUTeacherMainDrawingViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUTeacherMainDrawingViewController.h"
#import "LUTeacherDrawingDetailTableViewCell.h"
#import "LUTeacherCategoryDetailTableViewCell.h"

@implementation LUTeacherMainDrawingViewController
{
    NSDictionary   *responseObject;
    NSArray *resultArray ;
    NSArray *userLoginList;
    NSArray *userLogoutList;
    NSString *token;
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
    NSArray *classNamePickerTwo,*sectionArrayPickerTwo,*uniqClassIdLogin,*uniqSectionIdLogin;
    
    NSMutableArray *drawingCategoryId, *drawingCategoryName, *drawingList ,*DrawingId, *DrawingName, *ImageUrl ;
}

-(void)initialiser{
    
    drawingCategoryId = [[NSMutableArray alloc]init];
    drawingCategoryName = [[NSMutableArray alloc]init];
    drawingList = [[NSMutableArray alloc]init];
    DrawingId= [[NSMutableArray alloc]init];
    DrawingName= [[NSMutableArray alloc]init];
    ImageUrl= [[NSMutableArray alloc]init];
    
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
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initialiser];
    self.classSelect.dataSource = self;
    self.classSelect.delegate = self;
    self.sectionSelect.dataSource = self;
    self.sectionSelect.delegate = self;
    [self loadData];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    resultArray = [[responseOne objectForKey:@"StudentDetails"]
                   filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"StudentFirstName contains[c] %@", searchText]];
    [self.tableView reloadData];
    [self.studentListCollectionview reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText
                               scope:[[self.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchBar
                                                     selectedScopeButtonIndex]]];
}

-(void) populateStudentData:(NSDictionary *)body
{
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton studentList:Student_details body:body];
}

- (void) dockStudentList: (NSDictionary *)studentListDict
{
    if (studentListDict == nil)
    {
        NSLog(@"alert");
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Drawing List"
                                     message:@"Student List Empty !"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        //        UIAlertAction* test = [UIAlertAction
        //                                    actionWithTitle:@"test"
        //                                    style:UIAlertActionStyleDefault
        //                                    handler:^(UIAlertAction * action) {
        //                                        //Handle your yes please button action here
        //                                        // [self clearAllData];
        //                                    }];
        //
        //        UIAlertAction* yesButton = [UIAlertAction
        //                                    actionWithTitle:@"Yes"
        //                                    style:UIAlertActionStyleDefault
        //                                    handler:^(UIAlertAction * action) {
        //                                        //Handle your yes please button action here
        //                                       // [self clearAllData];
        //                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Close"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        //Add your buttons to alert controller
        //   [alert addAction:test];
        //   [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else
    {
        
        
        
        
        [self initialiser];
        responseOne = [studentListDict objectForKey:@"StudentData"];
        NSArray *responseTwo = [responseOne objectForKey:@"StudentDetails"];
        for (int i=0; i<[responseTwo count ]; i++)
        {
            NSDictionary *responseThree = [responseTwo objectAtIndex:i];
            [Id addObject:[responseThree objectForKey:@"Id"]];
            [StudentFirstName addObject:[responseThree objectForKey:@"StudentFirstName"]];
            [StudentProfileImage addObject:[responseThree objectForKey:@"StudentProfileImage"]];
            //        [AdmissionDate addObject:[responseThree objectForKey:@"AdmissionDate"]];
            //        [CityName addObject:[responseThree objectForKey:@"CityName"]];
            //        [ClassName addObject:[responseThree objectForKey:@"ClassName"]];
            //        [classStdLst addObject:[responseThree objectForKey:@"ClassName"]];
            //        [CountryName addObject:[responseThree objectForKey:@"CountryName"]];
            //        [DateOfBirth addObject:[responseThree objectForKey:@"DateOfBirth"]];
            //        [DocumentsImage addObject:[responseThree objectForKey:@"DocumentsImage"]];
            //        [EmergencyContactNumber addObject:[responseThree objectForKey:@"EmergencyContactNumber"]];
            //        [Gender addObject:[responseThree objectForKey:@"Gender"]];
            //        [GradeCompleted addObject:[responseThree objectForKey:@"GradeCompleted"]];
            //        [PreviousSchool addObject:[responseThree objectForKey:@"PreviousSchool"]];
            //        [SectionName addObject:[responseThree objectForKey:@"SectionName"]];
            //        [sectionStdLst addObject:[responseThree objectForKey:@"SectionName"]];
            //        [StateName addObject:[responseThree objectForKey:@"StateName"]];
            //        [StudentAddress addObject:[responseThree objectForKey:@"StudentAddress"]];
            //        [StudentEmail addObject:[responseThree objectForKey:@"StudentEmail"]];
            //        [StudentLastName addObject:[responseThree objectForKey:@"StudentLastName"]];
            //        [TelephoneNumber addObject:[responseThree objectForKey:@"TelephoneNumber"]];
            //        [StudentMiddleName addObject:[responseThree objectForKey:@"StudentMiddleName"]];
            //        [StudentMobileNumber addObject:[responseThree objectForKey:@"StudentMobileNumber"]];
            //        [StudentRollNumber addObject:[responseThree objectForKey:@"StudentRollNumber"]];
            //        [StudentZipCode addObject:[responseThree objectForKey:@"StudentZipCode"]];
            //        [Transport addObject:[responseThree objectForKey:@"Transport"]];
            //        [Hostel addObject:[responseThree objectForKey:@"Hostel"]];
        }
        // _messageText.text = @"populate table";
        [self.tableView reloadData];
        [self.studentListCollectionview reloadData];
    }
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
    //  _messageText.text = @"User Logged In";
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
    [self populateStudentData:sendDict];
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = [UIColor colorWithRed:0.85 green:0.82 blue:0.91 alpha:1.0];
    else
        cell.backgroundColor = [UIColor whiteColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView)
    {
        return 100;
    }
    else if (tableView == _categoryTableView)
    {
        return 100;
    }
    else
    {
        return 100;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == _categoryTableView)
    {
        static NSString *cellIdentifier = @"cellIdCategory";
        LUTeacherCategoryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[LUTeacherCategoryDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.DrawingCategoryNameLabel.text = [drawingCategoryName objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _tableView)
    {
        static NSString *cellIdentifier = @"cellIdDrawing";
        LUTeacherDrawingDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[LUTeacherDrawingDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if (resultArray.count>=1)
        {
            //Loading table with search result data
            cell.stdId.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"Id"];
            cell.stdName.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentFirstName"];
            cell.stdProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:
                                                                                          [[resultArray objectAtIndex:indexPath.row]objectForKey:@"StudentProfileImage"]]]];
            cell.stdProfile.layer.cornerRadius = 20;
            cell.stdProfile.layer.masksToBounds = YES;
            //        cell.stdClass.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"ClassName"];
            //        cell.stdEmail.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentEmail"];
            //        cell.stdContact.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentMobileNumber"];
            //        cell.stdAddress.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentAddress"];
            //        if ([[[resultArray objectAtIndex:indexPath.row ] objectForKey:@"Hostel"] isEqual:@"NO"])
            //        {
            //            cell.stayStatusImage.image = [UIImage imageNamed:@"Hostel@2x.png"];
            //        }
            //        else
            //        {
            //            cell.stayStatusImage.image = nil;
            //        }
            //
            //        if ([[[resultArray objectAtIndex:indexPath.row] objectForKey:@"Transport"] isEqual:@"NO"])
            //        {
            //            cell.transportStatusImage.image = [UIImage imageNamed:@"bus@2X.png"];
            //        }
            //        else
            //        {
            //            cell.transportStatusImage.image = nil;
            //        }
        }
        else
        {
            //Loading table with all the data
            cell.stdId.text = [Id objectAtIndex:indexPath.row];
            cell.stdName.text = [StudentFirstName objectAtIndex:indexPath.row];
            cell.stdProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[StudentProfileImage  objectAtIndex:indexPath.row] ]]];
            cell.stdProfile.layer.cornerRadius = 20;
            cell.stdProfile.layer.masksToBounds = YES;
            //        cell.stdClass.text = [ClassName objectAtIndex:indexPath.row];
            //        cell.stdEmail.text = [StudentEmail objectAtIndex:indexPath.row];
            //        cell.stdContact.text = [StudentMobileNumber objectAtIndex:indexPath.row];
            //        cell.stdAddress.text = [StudentAddress objectAtIndex:indexPath.row];
            //        if ([[Hostel objectAtIndex:indexPath.row] isEqual:@"NO" ])
            //        {
            //            cell.stayStatusImage.image = [UIImage imageNamed: @"Hostel@2x.png"];
            //        }
            //        else
            //        {
            //            cell.stayStatusImage.image = [UIImage imageNamed: @"SelectedHostel@2x.png"];
            //        }
            //
            //        if ([[Transport objectAtIndex:indexPath.row] isEqual:@"NO"])
            //        {
            //            cell.transportStatusImage.image = [UIImage imageNamed: @"bus@2X.png"];
            //        }
            //        else
            //        {
            //            cell.transportStatusImage.image = [UIImage imageNamed: @"blue-bus-@2x.png"];
            //        }
        }
        return cell;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger retValue ;
    if (tableView == _tableView)
    {
        if (resultArray.count>=1)
        {
            retValue = [resultArray count];
        }
        else
        {
            retValue = [Id count];
        }
    }
    else if (tableView == _categoryTableView)
    {
        retValue = [drawingCategoryId count];
    }
    else
    {
        
    }
    return retValue ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.categoryTableView reloadData];
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    NSString *idString = [[[responseOne objectForKey:@"StudentDetails"] objectAtIndex:indexPath.row] objectForKey:@"Id"];
    NSDictionary *selectDict = @{@"StudentId" : idString};
    NSLog(@"%@",selectDict);
    [sharedSingleton teacherDrawingCategoryListing:DrawingCategoryList_link body:selectDict];
    //- (BOOL) teacherDrawingCategoryListing:(NSString *)url body:(NSDictionary *)body
    //    [sharedSingleton studentList:Student_details body:body];
}

- (void) listDrawingCategory: (NSDictionary *)drawingCategoryDict
{
    NSArray *categoryResponsetwo = [drawingCategoryDict objectForKey:@"message"];
    if ([categoryResponsetwo  isEqual: @"Record not found"])
    {
        NSLog(@"alert");
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Drawing"
                                     message:@"No drawings Submitted!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        //        UIAlertAction* test = [UIAlertAction
        //                                    actionWithTitle:@"test"
        //                                    style:UIAlertActionStyleDefault
        //                                    handler:^(UIAlertAction * action) {
        //                                        //Handle your yes please button action here
        //                                        // [self clearAllData];
        //                                    }];
        //
        //        UIAlertAction* yesButton = [UIAlertAction
        //                                    actionWithTitle:@"Yes"
        //                                    style:UIAlertActionStyleDefault
        //                                    handler:^(UIAlertAction * action) {
        //                                        //Handle your yes please button action here
        //                                       // [self clearAllData];
        //                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Close"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        //Add your buttons to alert controller
        //   [alert addAction:test];
        //   [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else
    {
        NSLog(@"inside");
        NSArray *categoryResponse = [drawingCategoryDict objectForKey:@"Drawings"];
        for (int i=0; i<[categoryResponse count]; i++)
        {
            NSDictionary *temp = [categoryResponse objectAtIndex:i];
            [drawingCategoryId addObject:[temp objectForKey:@"DrawingCategoryId"]];
            [drawingCategoryName addObject:[temp objectForKey:@"DrawingCategoryName"]];
            [drawingList addObject:[temp objectForKey:@"drawings"]];
        }
        LUShelfListViewController *pushToShelf = [self.storyboard instantiateViewControllerWithIdentifier:@"LUStudentNotesVC"];
        pushToShelf.setTeacherDrawing = YES;
        pushToShelf.teacherDrawingList = categoryResponse;
        pushToShelf.setResource =YES;
        //    NSArray *arry01 = drawingList;
        //    for (int i=0; i<[arry01 count]; i++)
        //        {
        //            NSDictionary *temp2 = [arry01 objectAtIndex:i];
        //
        //            [DrawingName addObject:[temp2 objectForKey:@"DrawingName"]];
        //            [DrawingId addObject:[temp2 objectForKey:@"DrawingId"]];
        //            [ImageUrl addObject:[temp2 objectForKey:@"ImageUrl"]];
        //        }
        [self.navigationController pushViewController:pushToShelf animated:YES];
        //[self.categoryTableView reloadData];
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
    else
    {
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
    else
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
        classRow =[uniqClassIdLogin objectAtIndex:row]; // [ClassId_login objectAtIndex:[ClassName_login indexOfObject:[ClassName_login objectAtIndex:row]]];
        sendDict = @{
                     @"ClassId":classRow,
                     @"SectionId":sectionRow
                     };
        //sectionRow = [SectionId_login objectAtIndex:[SectionName_login indexOfObject:[SectionName_login objectAtIndex:0]]];
        //        classRow = classNamePickerTwo;
        //        [self.tableView reloadData];
        [self populateStudentData:sendDict];
    }
    //load table according to section data recieved from Login (returning section Id)
    else if (pickerView == _sectionSelect)
    {
        sectionRow =[uniqSectionIdLogin objectAtIndex:row]; // [SectionId_login objectAtIndex:[SectionName_login indexOfObject:[SectionName_login objectAtIndex:row]]];
        sendDict = @{
                     @"ClassId":classRow,
                     @"SectionId":sectionRow
                     };
        //[self.tableView reloadData];
        [self populateStudentData:sendDict];
    }
    else
        NSLog(@"Other Picker View");
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (resultArray.count >= 1)
    {
        return [resultArray count];
    }
    else
    {
        return Id.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"drawingCELL" forIndexPath:indexPath];
    if (resultArray.count >=1)
    {
        UILabel *subLbl = (UILabel *)[cell viewWithTag:10];
        UILabel *subLb2 = (UILabel *)[cell viewWithTag:20];
        UIImageView *imgProfile =(UIImageView *) [cell viewWithTag:30];
        subLbl.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"Id"];
        subLb2.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"StudentFirstName"];
        imgProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[resultArray objectAtIndex:indexPath.row]objectForKey:@"StudentProfileImage"]]]];
    }
    else
    {
        UILabel *subLbl = (UILabel *)[cell viewWithTag:10];
        UILabel *subLb2 = (UILabel *)[cell viewWithTag:20];
        UIImageView *imgProfile =(UIImageView *) [cell viewWithTag:30];
        subLbl.text = [Id objectAtIndex:indexPath.row];
        subLb2.text = [StudentFirstName objectAtIndex:indexPath.row];
        imgProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[StudentProfileImage  objectAtIndex:indexPath.row] ]]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (resultArray.count >=1)
    {
        NSLog(@"INSIDE path = %@",indexPath);
        [self.categoryTableView reloadData];
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        NSString *idString = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"Id"];
        NSDictionary *selectDict = @{@"StudentId" : idString};
        NSLog(@"%@",selectDict);
        [sharedSingleton teacherDrawingCategoryListing:DrawingCategoryList_link body:selectDict];
    }
    else
    {
        NSLog(@"INSIDE path = %@",indexPath);
        [self.categoryTableView reloadData];
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        NSString *idString = [[[responseOne objectForKey:@"StudentDetails"] objectAtIndex:indexPath.row] objectForKey:@"Id"];
        NSDictionary *selectDict = @{@"StudentId" : idString};
        NSLog(@"%@",selectDict);
        [sharedSingleton teacherDrawingCategoryListing:DrawingCategoryList_link body:selectDict];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

