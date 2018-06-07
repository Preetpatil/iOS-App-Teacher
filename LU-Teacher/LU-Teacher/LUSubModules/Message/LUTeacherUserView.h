//
//  LUTeacherUserView.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUTeacherUserView : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageUser;
@property (strong, nonatomic) IBOutlet UILabel *name;

//@property (strong, nonatomic) IBOutlet UIImageView *status;
@property (strong, nonatomic) IBOutlet UILabel *lastLogin;

@property (strong, nonatomic) IBOutlet UIImageView *userStatus;
@end
