//
//  LUStudentMessagesViewController.h
//  LearningUmbrellaMaster
//
//  Created by Preeti Patil on 27/05/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUChatMessageView.h"
#import "LUChatUserView.h"
#import "LUURLLink.h"
#import "LUHeader.h"
//#import "LUModel.h"


//#import "ChatCellSettings.h"
//#import "ChatTableViewCell.h"



@interface LUStudentMessagesViewController: UIViewController <UITableViewDataSource, UITableViewDelegate, LUDelegate,UIDocumentPickerDelegate,UIPopoverPresentationControllerDelegate,UITextFieldDelegate>

{
    NSTimer*timer;
}

@property (weak, nonatomic) IBOutlet UIView *additinalview;


@property (strong, nonatomic) NSDictionary *chatdetailDict;
@property (strong, nonatomic) NSString *stdntID;
@property (strong, nonatomic) NSString *stdntImage;

@property (strong, nonatomic) NSDictionary *profiledata;
@property (strong, nonatomic) NSDictionary *chatdataDict;
@property (strong, nonatomic) NSMutableArray *chatUserList;
@property (strong, nonatomic) NSMutableArray *chatUserNameList;
@property (strong, nonatomic) NSMutableArray *chatImageList;
@property (strong, nonatomic) NSMutableArray *chatUserImageList;
@property (strong, nonatomic) NSMutableArray *chatHistory;
@property (strong, nonatomic) NSMutableArray *TeacherdetailArray;
@property (strong, nonatomic) NSMutableArray *StudentdetailArray;

@property (strong, nonatomic) IBOutlet UITextView *messageText;


@property (weak, nonatomic) IBOutlet UILabel *receiverName;

@property (weak, nonatomic) IBOutlet UILabel *RollNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ClassNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *StudentRollLbl;
@property (weak, nonatomic) IBOutlet UIImageView *Imageview;
@property (weak, nonatomic) IBOutlet UILabel *Nametype;


@property (weak, nonatomic) IBOutlet UIView *uiview;




@property (strong,nonatomic) LUChatMessageView *chatCell;

- (IBAction)sendMessage:(id)sender;
- (IBAction)attachFiles:(id)sender;
- (IBAction)AdditionalInformationBtn:(id)sender;
- (IBAction)closeBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *attachfilebtn;
@property (weak, nonatomic) IBOutlet UIButton *sendbtn;


@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


@end

