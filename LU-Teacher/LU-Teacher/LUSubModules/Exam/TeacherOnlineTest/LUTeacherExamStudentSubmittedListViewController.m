//
//  LUTeacherExamStudentSubmittedListViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherExamStudentSubmittedListViewController.h"
#import "LUHeader.h"

@interface LUTeacherExamStudentSubmittedListViewController ()

@end

@implementation LUTeacherExamStudentSubmittedListViewController
{
    NSArray *resultArray ;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"%@",_studentIDString);
    NSLog(@"%@",_studentNameString);

}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
//    resultArray = [[tempDict objectForKey:@"TestList"]
//                   filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SubjectName contains[c] %@", searchText]];
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _studentIDString.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"examStudentSubmittedCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    UILabel *lableForID = (UILabel *) [cell viewWithTag:1];
    UILabel *lableForStudent = (UILabel *) [cell viewWithTag:2];
    
    lableForID.text = [_studentIDString objectAtIndex:indexPath.row];
    lableForStudent.text = [_studentNameString objectAtIndex:indexPath.row];
 
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
