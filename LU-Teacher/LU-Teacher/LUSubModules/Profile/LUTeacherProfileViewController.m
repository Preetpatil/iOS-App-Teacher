//
//  LUTeacherProfileViewController.m
//  //  LUTeacher
//
//  Created by Preeti Patil on 16/04/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUTeacherProfileViewController.h"
#import "LUTeacherProfileSubjectListCell.h"
#import "LUTeacherProfileAwardsCell.h"
#import "LUTeacherProfileTeacherInfoCell.h"


@implementation LUTeacherProfileViewController
{
    NSDictionary *responseObject;
    NSString *profileImage, *designation,  *dob, *email, *phone, *gender, *address, *firstName, *lastName;
    
    NSMutableArray *ClassId_login, *ClassName_login, *Id_login, *SectionId_login, *SectionName_login, *SubjectId_login,
    *SubjectName_login, *SectionData_login, *Subjectresult_login;
    
    NSArray *sectionDataResponse;
    NSArray *subjectnameResponse, *subjectStateArray;
    
    NSMutableArray *subjectName, *subjectCode;
    



    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //TODO: add JSON Singleton implementtation to fetch data from server
//    NSError *error;
//    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Sample2" ofType:@"json"];
//    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
//    responseObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
   
    ClassId_login = [[NSMutableArray alloc] init];
    ClassName_login = [[NSMutableArray alloc] init];
    Id_login = [[NSMutableArray alloc] init];
    SectionId_login = [[NSMutableArray alloc] init];
    SectionName_login = [[NSMutableArray alloc] init];
    SubjectId_login = [[NSMutableArray alloc] init];
    SubjectName_login = [[NSMutableArray alloc] init];
    SectionData_login = [[NSMutableArray alloc] init];
    Subjectresult_login = [[NSMutableArray alloc] init];
    subjectName = [[NSMutableArray alloc] init];
    subjectCode= [[NSMutableArray alloc] init];

    
    [self loadData];
    
    
    _teacherFirstName.text = firstName;
    _teacherLastName.text = lastName;
    _teacherProfileImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileImage]]];
    _teacherDesignation.text = designation;
    _teacherDOB.text = dob;
    _teacherGender.text = gender;
    _teacherEmail.text = email;
    _teacherPhone.text = phone;
    _teacherAddress.text = address;
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _subjectListTableView) {
       // return 0;//[[responseObject objectForKey:@"Teacher Details"] count];
        return subjectCode.count;
    }
    else
    {
        return 0;// [[responseObject objectForKey:@"Teacher Details"] count];
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _subjectListTableView)
    {
        _subjectListTableView.allowsSelection = NO;
        static NSString *cellIdentifier = @"subjectListCell";
        
        LUTeacherProfileSubjectListCell *cell = [_subjectListTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[LUTeacherProfileSubjectListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.subjectName.text = [subjectName objectAtIndex:indexPath.row];
        cell.subjectCode.text = [subjectCode objectAtIndex:indexPath.row];
        
        
        
        
//        cell.teacherId.text = [[[responseObject objectForKey:@"Teacher Details"] objectAtIndex:indexPath.row]objectForKey:@"Teacher_id"];
//        cell.teacherName.text = [[[responseObject objectForKey:@"Teacher Details"] objectAtIndex:indexPath.row]objectForKey:@"Name"];
//        cell.teacherClass.text = [[[responseObject objectForKey:@"Teacher Details"] objectAtIndex:indexPath.row]objectForKey:@"Class"];
//        
//        cell.teacherCode.text = [[[responseObject objectForKey:@"Teacher Details"] objectAtIndex:indexPath.row]objectForKey:@"Code"];
        return cell;
    }
    else
    {
        _awardsTableView.allowsSelection = NO;
        static NSString *cellIdentifier = @"awardsCell";
        
        LUTeacherProfileAwardsCell *cell = [_awardsTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (cell==nil)
        {
            cell=[[LUTeacherProfileAwardsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.teacherId.text = [[[responseObject objectForKey:@"Teacher Details"] objectAtIndex:indexPath.row]objectForKey:@"Teacher_id"];
        cell.awardTitle.text = [[[responseObject objectForKey:@"Teacher Details"] objectAtIndex:indexPath.row]objectForKey:@"Title"];
        cell.awardRemark.text = [[[responseObject objectForKey:@"Teacher Details"] objectAtIndex:indexPath.row]objectForKey:@"Remark"];
        return cell;
        
    }
//    else
//    {
//        _teacherInfoTableView.allowsSelection = NO;
//        _teacherInfoTableView.scrollEnabled = NO;
//        static NSString *cellIdentifier = @"cellId3";
//        
//        LUTeacherProfileTeacherInfoCell *cell = [_teacherInfoTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//        if (cell==nil)
//        {
//            cell=[[LUTeacherProfileTeacherInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
//        
//       // cell.teacherDesignation.text = designation;
//        cell.teacherDob.text = dob;
//        cell.teacherGender.text = gender;
//        cell.teacherEmail.text = email;
//        cell.teacherPhone.text =phone;
//        cell.teacherAddress.text = address;
//        cell.teacherNameInfo.text = firstName;
//        cell.teacherClassInfo.text = lastName;
//        cell.teacherProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileImage]]];
//        return cell;
//    }
}


-(void)loadData
{
    
    NSDictionary *mainResponse = [LUOperation getSharedInstance].userProfileDetails;
    
    responseObject = [mainResponse objectForKey:@"item"];
    
    profileImage = [responseObject objectForKey:@"UserProfileImage"];
    firstName = [responseObject objectForKey:@"UserFirstName"];
    lastName = [responseObject objectForKey:@"UserLastName"];
    designation = [responseObject objectForKey:@"DesignationData"];
    dob = [responseObject objectForKey:@"UserDateOfBirth"];
    email = [responseObject objectForKey:@"UserEmail"];
    phone = [responseObject objectForKey:@"UserMobileNumber"];
    gender = [responseObject objectForKey:@"UserGender"];
    address = [responseObject objectForKey:@"UserAddress"];

    
    NSArray *classSubjectDataResponse = [responseObject objectForKey:@"ClassSubjectData"];
    NSLog(@"%@",classSubjectDataResponse);
//   
//    NSArray *a1 = [classSubjectDataResponse objectAtIndex:0];
//    NSDictionary *responseOne_login = [a1 objectAtIndex:0];
//    
   
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
            
            [subjectName addObject:[subjectnameResponseTwo objectForKey:@"SubjectName"]];
            [subjectCode addObject:[subjectnameResponseTwo objectForKey:@"SubjectId"]];
            
            [SubjectId_login addObject:[subjectnameResponseTwo objectForKey:@"SubjectId"]];
            [SubjectName_login addObject:[subjectnameResponseTwo objectForKey:@"SubjectName"]];
        }
    }
    }
}

@end
