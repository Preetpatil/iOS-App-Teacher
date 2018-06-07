//
//  LUChatUserView.h
//  LearningUmbrellaMaster
//
//  Created by Preeti Patil on 27/05/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUChatUserView : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageUser;
@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UIImageView *status;
@property (strong, nonatomic) IBOutlet UILabel *lastLogin;
@property (weak, nonatomic) IBOutlet UIImageView *statusimage;


/*
 name = sss;
 profile = "http://setumbrella.in/img/Koala.jpg";
 status = online;
 "user_id" = 3371;
 */
@end
