//
//  LUTimeTableDetailViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DataDelegate <NSObject>
@required
- (void)passData:(NSString *)data;

@end
@interface LUTimeTableDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) id<DataDelegate> delegatemethod;

@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property NSArray *detailArray;
@property NSString*data;
@end
