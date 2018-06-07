//
//  LUChatMessageView.h
//  LearningUmbrellaMaster
//
//  Created by Preeti Patil on 27/05/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUChatMessageView: UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *receiver_id;
@property (strong, nonatomic) IBOutlet UILabel *sender_id;
@property (strong, nonatomic) IBOutlet UIImageView *imageUser;
@property (strong, nonatomic) IBOutlet UILabel *user;

@property (weak, nonatomic) IBOutlet UIButton *downloadbtn;


/*
 message = hi;
 "receiver_id" = 6;
 "sender_id" = 3;
 time = "2017-01-10 13:50:45";
 */

@end
