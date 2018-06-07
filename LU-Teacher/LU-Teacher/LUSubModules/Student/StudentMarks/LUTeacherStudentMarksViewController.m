//
//  LUTeacherStudentMarksViewController.m
//  //  LUTeacher
//
//  Created by Lucas on 11/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import "LUTeacherStudentMarksViewController.h"

@interface LUTeacherStudentMarksViewController ()

@end

@implementation LUTeacherStudentMarksViewController
{
    NSDictionary   *responseObject, *responseArray  ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
    responseObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    responseArray = [responseObject objectForKey:@"Student Details"];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    // return [[responseObject objectForKey:@"Student Details"] count];
    return responseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    tableView.allowsSelection = NO;
    
    
    static NSString *cellIdentifier = @"CellId";
    LUTeacherStudentMarksTableViewCell *marksTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    id studentDetailObject = [[responseObject objectForKey:@"Student Details"] objectAtIndex:indexPath.row];
    
    if (marksTableCell==nil)
    {
        marksTableCell=[[LUTeacherStudentMarksTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    marksTableCell.layer.cornerRadius = 10;
    self.marksTableView.separatorColor = [UIColor grayColor];
    
    marksTableCell.studentId.text = [studentDetailObject objectForKey:@"Student_id"];
    marksTableCell.studentName.text = [studentDetailObject objectForKey:@"Name"];
    marksTableCell.studentClass.text = [studentDetailObject objectForKey:@"Class"];
    marksTableCell.studentProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:
                                                                                                [[[responseObject objectForKey:@"Student Details"] objectAtIndex:indexPath.row]objectForKey:@"Profile"]]]];
    marksTableCell.studentProfile.layer.cornerRadius = 25;
    marksTableCell.studentProfile.layer.masksToBounds = YES;
    return marksTableCell;
}

- (IBAction)marksSheetPopUp:(id)sender {
    //----------------------------------------------------------------------------------------------------------
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.marksTableView];
    NSIndexPath *indexPath = [self.marksTableView indexPathForRowAtPoint:buttonPosition];
    LUTeacherStudentMarksDetailController *marksDetailView =[[LUTeacherStudentMarksDetailController alloc]
                                             initWithNibName:@"LUTeacherStudentMarksDetailController" bundle:nil];
    marksDetailView.preferredContentSize = CGSizeMake(650,400);
    UINavigationController *navigationObject = [[UINavigationController alloc]
                                                initWithRootViewController:marksDetailView];
    navigationObject.modalPresentationStyle = UIModalPresentationPopover;
    navigationObject.navigationBarHidden=YES;
    UIPopoverPresentationController *instantPopView = navigationObject.popoverPresentationController;
    instantPopView.sourceView = self.view;
    instantPopView.sourceRect = CGRectMake(700, 460, 0, 0);
    instantPopView.permittedArrowDirections=0;
    //----------------------------------------------------------------------------------------------------------
    NSArray *studentDetailObject = [responseObject objectForKey:@"Student Details"];
    NSDictionary *studentDetailKeys = [studentDetailObject objectAtIndex:indexPath.row];
    NSArray *marksDetailObject = [studentDetailKeys objectForKey:@"Marks"];
    NSDictionary *marksDetailKey = [marksDetailObject objectAtIndex:0];
    
    NSMutableArray *marksArray = [[NSMutableArray alloc]init];
    NSMutableArray *gradeArray= [[NSMutableArray alloc]init];
    NSMutableArray *pointArray= [[NSMutableArray alloc]init];
    
    for (int i=0; i<[marksDetailKey allKeys].count; i++)
    {
        _marksPopUp = [[marksDetailKey objectForKey:[[marksDetailKey allKeys] objectAtIndex:i] ] objectForKey:@"Mark"];
        _gradePopUp = [[marksDetailKey objectForKey:[[marksDetailKey allKeys] objectAtIndex:i] ] objectForKey:@"Grade"];
        _pointPopUp = [[marksDetailKey objectForKey:[[marksDetailKey allKeys] objectAtIndex:i] ] objectForKey:@"Point"];
        [marksArray addObject:_marksPopUp];
        [gradeArray addObject:_gradePopUp];
        [pointArray addObject:_pointPopUp];
        marksDetailView.markForPopUp = marksArray;
        marksDetailView.gradeForPopUp = gradeArray;
        marksDetailView.pointForPopUp = pointArray;
    }
    [self presentViewController:navigationObject animated:YES completion:nil];
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
