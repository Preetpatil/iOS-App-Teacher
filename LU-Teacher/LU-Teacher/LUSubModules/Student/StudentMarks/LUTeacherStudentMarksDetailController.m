//
//  MarksDetailController.m
//  StudentMarks
//
//  Created by Lucas on 26/04/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherStudentMarksDetailController.h"


@interface LUTeacherStudentMarksDetailController ()

@end

@implementation LUTeacherStudentMarksDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.marksDetailTableView registerNib:[UINib nibWithNibName:@"MarksDetailCellClass" bundle:nil] forCellReuseIdentifier:@"CellId2"];
   // NSLog(@"%ld", _markForPopUp.count);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _markForPopUp.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.allowsSelection = NO;
    static NSString *cellIdentifier = @"CellId2";
    LUTeacherStudentMarksDetailCellClass *markSheetCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (markSheetCell==nil)
        {
            markSheetCell=[[LUTeacherStudentMarksDetailCellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    markSheetCell.layer.cornerRadius = 10;
    markSheetCell.marksPopUpLable.text = [self.markForPopUp objectAtIndex:indexPath.row];
    markSheetCell.gradePopUpLable.text = [self.gradeForPopUp objectAtIndex:indexPath.row];
    markSheetCell.pointPopUpLable.text = [self.pointForPopUp objectAtIndex:indexPath.row];
   return markSheetCell;
}

- (IBAction)dissmissButton:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
