//
//  LUTeacherAssignmentSubmitListController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUTeacherAssignmentSubmitListCell.h"
#import "LUHeader.h"
@interface LUTeacherAssignmentSubmitListController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *studList;
@property (nonatomic,strong) NSArray *pageList;
@property (nonatomic,strong) NSString *assingmentName;
@property (weak, nonatomic) IBOutlet UITableView *submitListTable;
@property (weak, nonatomic) IBOutlet UILabel *subCount;
@property (weak, nonatomic) IBOutlet UILabel *appCount;
@property (weak, nonatomic) IBOutlet UILabel *redoCount;
@property (weak, nonatomic) IBOutlet UILabel *rejCount;
@property (nonatomic,strong) NSString *submitted;
@property (nonatomic,strong) NSString *approved;
@property (nonatomic,strong) NSString *redo;
@property (nonatomic,strong) NSString *rejected;

@end
