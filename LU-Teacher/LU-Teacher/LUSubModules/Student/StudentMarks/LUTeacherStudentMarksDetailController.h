//
//  MarksDetailController.h
//  StudentMarks
//
//  Created by Lucas on 26/04/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"
@interface LUTeacherStudentMarksDetailController : UIViewController<UITableViewDataSource>

@property (strong, nonatomic) NSArray *markForPopUp;

@property (strong, nonatomic) NSArray *gradeForPopUp;

@property (strong, nonatomic) NSArray *pointForPopUp;

- (IBAction)dissmissButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *marksDetailTableView;

@end
