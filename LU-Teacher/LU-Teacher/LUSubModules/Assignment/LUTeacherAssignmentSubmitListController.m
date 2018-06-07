//
//  LUTeacherAssignmentSubmitListController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherAssignmentSubmitListController.h"

@interface LUTeacherAssignmentSubmitListController ()

@end

@implementation LUTeacherAssignmentSubmitListController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ %@ %@",_studList,_pageList,_assingmentName);
    
    _subCount.text = _submitted;
    _appCount.text = _approved;
    _redoCount.text = _redo;
    _rejCount.text = _rejected;
   //LUSubmitListController
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _studList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"submitListCell";
    
    LUTeacherAssignmentSubmitListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[LUTeacherAssignmentSubmitListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    cell.profilePic.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_studList  objectAtIndex:indexPath.row ] objectForKey:@"StudentProfileImage"]]]];
    cell.studentName.text = [[_studList objectAtIndex:indexPath.row ] objectForKey:@"StudentFirstName"];
    //cell.attachment.image = [[[_studList objectAtIndex:0] objectAtIndex:indexPath.row ] objectForKey:@"AssignmentSubmissionAttachment"];
    cell.dos.text = [[_studList  objectAtIndex:indexPath.row ] objectForKey:@"AssignmentSubmittedDate"];
    cell.dueDate.text = [[_studList objectAtIndex:indexPath.row ] objectForKey:@"AssignmentDueDate"];
    cell.marks.text = [[_studList objectAtIndex:indexPath.row ] objectForKey:@"AssignmentSubmissionMark"];
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_pageList);
    NSMutableArray *pageImage= [[NSMutableArray alloc]init];
    NSMutableArray *pageNo = [[NSMutableArray alloc]init];
    
    for (int i=0;i<[[_pageList objectAtIndex:0] count]; i++) {
       
        [pageImage addObject:[[[_pageList objectAtIndex:0] objectAtIndex:i] objectForKey:@"AssignmentSubmissionDescription"]];
        [pageNo addObject:[[[_pageList objectAtIndex:0] objectAtIndex:i] objectForKey:@"PageNumber"]];
        
       
    }
    LUWriteNotesViewController *pushToWrite = [self.storyboard instantiateViewControllerWithIdentifier:@"LUStudentWriteNotesVC"];
    NSCharacterSet *notAllowedChars  =  [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    
    NSString* filteredUnitName  =  [[[[_studList  objectAtIndex:indexPath.row ] objectForKey:@"AssignmentSubject"] componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    //pushToWrite.FlashCoverImage = [cellData objectForKey:@"CategoryThumbinal"];
    //pushToWrite.FlashSubjectName = [cellData objectForKey:@"subject_name"];
    pushToWrite.FlashUniteNo = @"";
    pushToWrite.FlashUniteName = filteredUnitName;
    pushToWrite.FlashPageType = @"";
    pushToWrite.moduleName = @"Assignment";
    pushToWrite.isTeacherAssignment = YES;
    pushToWrite.studentId = [[_studList  objectAtIndex:indexPath.row ] objectForKey:@"StudentId"];
    pushToWrite.subjectCategoryId = [[_studList objectAtIndex:indexPath.row ] objectForKey:@"AssignmentId"];
    pushToWrite.studentClassId = [[_studList objectAtIndex:indexPath.row ] objectForKey:@"ClassId"];
    pushToWrite.studentSectionId = [[_studList objectAtIndex:indexPath.row ] objectForKey:@"SectionId"];
    
    BOOL success  =  NO;
    success  =  [[LUNotesMainDataManager getSharedInstance]createDB:filteredUnitName];
    NSLog(success ? @"Yes Notes created" : @"No notes created");
    [self.navigationController pushViewController:pushToWrite animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
