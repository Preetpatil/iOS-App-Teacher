//
//  LUTeacherStudentMarksViewController.h
//  //  LUTeacher
//
//  Created by Lucas on 11/05/18.
//  Copyright © 2017 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"
@interface LUTeacherStudentMarksViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *marksTableView;

@property (strong, nonatomic) NSArray *marksPopUp;

@property (strong, nonatomic) NSArray *gradePopUp;

@property (strong, nonatomic) NSArray *pointPopUp;


- (IBAction)marksSheetPopUp:(id)sender;
@end
