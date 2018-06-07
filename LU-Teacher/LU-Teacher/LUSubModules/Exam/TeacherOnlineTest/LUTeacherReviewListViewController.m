//
//  LUTeacherReviewListViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherReviewListViewController.h"
#import "LUTeacherExamStudentSubmittedListViewController.h"
#import "LUHeader.h"

@interface LUTeacherReviewListViewController ()

@end

@implementation LUTeacherReviewListViewController
{
    NSArray *resultArray ;
    NSDictionary *responseOne;
    NSDictionary *examListResponse;
    NSDictionary *tempDict;


    NSMutableArray  *Id, *subject, *testDate, *testStartTime, *testEndTime, *totalMarks;
    NSString *catchString;
    NSMutableArray *studentId, *studentName;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    resultArray = [[tempDict objectForKey:@"TestList"]
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    Id = [[NSMutableArray alloc]init];
    subject = [[NSMutableArray alloc]init];
    testDate = [[NSMutableArray alloc]init];
    testStartTime = [[NSMutableArray alloc]init];
    testEndTime = [[NSMutableArray alloc]init];
    totalMarks = [[NSMutableArray alloc]init];
    studentId = [[NSMutableArray alloc]init];
    studentName = [[NSMutableArray alloc]init];

    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton teacherReviewExamList:ExamListReview_link];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) ExamReviewList: (NSDictionary *) examReviewListDict
{
    tempDict = examReviewListDict;

    NSArray *firstResponse = [examReviewListDict objectForKey:@"TestList"];
    for (int i=0; i<[firstResponse count]; i++)
    {
        NSDictionary *examListResponse = [firstResponse objectAtIndex:i];
        [Id addObject:[examListResponse objectForKey:@"Id"]];
        [subject addObject:[examListResponse objectForKey:@"SubjectName"]];
        [testDate addObject:[examListResponse objectForKey:@"TestDate"]];
        [testStartTime addObject:[examListResponse objectForKey:@"TestStartTime"]];
        [testEndTime addObject:[examListResponse objectForKey:@"TestEndTime"]];
        [totalMarks addObject:[examListResponse objectForKey:@"TotalMarks"]];
         NSLog(@"%@",examListResponse);
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
    }}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.allowsSelection = NO;
    
    static NSString *cellIdentifier = @"examReviewListCellId";
    
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
  //  UIButton *editButton = (UIButton *) [cell viewWithTag:7];
  
    if (resultArray.count>=1)
    {
    lableForID.text = [Id objectAtIndex:indexPath.row];
    lableForSubject.text = [subject objectAtIndex:indexPath.row];
    lableForTestDate.text = [testDate objectAtIndex:indexPath.row];
    lableForStartTime.text = [testStartTime objectAtIndex:indexPath.row];
    lableForEndTime.text = [testEndTime objectAtIndex:indexPath.row];
    lableForTotalMarks.text = [totalMarks objectAtIndex:indexPath.row];
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

- (IBAction)reviewExam:(id)sender
{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    
    catchString = [Id objectAtIndex:indexPath.row];
    NSDictionary *editParameter = @{@"TestId":[Id objectAtIndex:indexPath.row]};
    
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton teacherStudentSubmittedExam:ExamListStudentSubmitted_link body:editParameter ];
}



- (void) ExamStudentSubmittedList: (NSDictionary *) examStudentSubmittedDict
{
   
    NSLog(@"%@",examStudentSubmittedDict );
    
    NSArray *secondResponse = [examStudentSubmittedDict objectForKey:@"StudentList"];
    
    for (int i=0; i<[secondResponse count]; i++)
    {
        NSDictionary *responseOne = [secondResponse objectAtIndex:i];
        [studentId addObject:[responseOne objectForKey:@"StudentId"]];
        [studentName addObject:[responseOne objectForKey:@"StudentName"]];
        
    }

    LUTeacherExamStudentSubmittedListViewController *pushToStudentSubmittedExam = [self.storyboard instantiateViewControllerWithIdentifier:@"LUTeacherExamStudentSubmittedListVC"];
    
    pushToStudentSubmittedExam.studentIDString = studentId;
    pushToStudentSubmittedExam.studentNameString = studentName;
    
    [self.navigationController pushViewController:pushToStudentSubmittedExam animated:YES];
    [_tableView reloadData];
    
}
@end
