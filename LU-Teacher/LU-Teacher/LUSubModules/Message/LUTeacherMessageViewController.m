//
//  LUTeacherMessageViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherMessageViewController.h"
//#import "LUStudentProfileViewController.h"
#import "MobileCoreServices/MobileCoreServices.h"
#import <QuartzCore/QuartzCore.h>

@interface LUTeacherMessageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *chatUserTableView;
@property (weak, nonatomic) IBOutlet UITableView *chatMessageTableView;
@property (weak, nonatomic) IBOutlet UITableView *LUchatUserTableView;
@property (weak, nonatomic) IBOutlet UITableView *LUchatMessageTableView;

@end

@implementation LUTeacherMessageViewController
{
    //    ChatCellSettings *chatCellSettings;
    
    NSDictionary*dict;
    NSData* documentData;
    NSURL *urlOfSelectedDocument;
    NSString *Rollnumber;
    NSString *Studentroll;
    NSString *ClassName;
    NSString *extension;
    NSString *lastlogindate;
    NSString *image;
    NSString *nametype;
    NSMutableArray *mA1;

    NSDictionary *responseObject, *refreshBody;
    NSString *profileImage, *designation,  *dob, *email, *phone, *gender, *address, *firstName, *lastName, *teacherId;
    




}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    mA1 = [[NSMutableArray alloc]init];
    
    
    
    
    _additinalview.hidden=YES;
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"yourKeyName"];
    _profiledata= [[NSMutableDictionary alloc] init];
    _profiledata=[[NSKeyedUnarchiver unarchiveObjectWithData:data] objectForKey:@"item"];
    //StudentProfileImage
//    _stdntID=[_profiledata objectForKey:@"StudentId"];
//    _stdntImage= [_profiledata objectForKey:@"StudentProfileImage"];
    [self initializeMessageView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self loadData];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
}

- (void) initializeMessageView
{
    LUOperation *sharedSingleton;
    sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton messagesList:Message_teacher_list];
    
    
    _chatUserNameList = [[NSMutableArray alloc] init];
    _chatHistory = [[NSMutableArray alloc] init];
    _chatUserList = [[NSMutableArray alloc] init];
    _chatUserImageList = [[NSMutableArray alloc] init];
    _chatImageList = [[NSMutableArray alloc] init];
    
    _chatMessageTableView.rowHeight = 175.0;
    _chatUserTableView.rowHeight = 75.00;
    
    

}

-(void)refreshTable
{
    // [self fetchChatHistory];
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton messagesChatHistoryList:refreshBody];
    
}

//-(void)updateTable
//{
//    [self fetchChatHistory];
//    
//}

- (IBAction)sendMessage:(id)sender
{
    [self sendChatMessage];

   // [self updateTable];
    
    }

/**
 <#Description#>
 
 @param sender <#sender description#>
 */
- (IBAction)attachFiles:(id)sender
{
    
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"]
                                                                                                            inMode:UIDocumentPickerModeImport];
    //UIDocumentPickerViewController*doctextfile=[[UIDocumentPickerViewController alloc]initWithDocumentTypes:@[@""] inMode:<#(UIDocumentPickerMode)#>]
    
    documentPicker.delegate = self;
    
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

#pragma mark - iCloud files
-(void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker

{
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        urlOfSelectedDocument = url;
        extension=[url pathExtension];
        
        documentData = [[NSData alloc] initWithContentsOfURL:url];
        documentData = [[NSData alloc] initWithContentsOfFile:[url path]];
        
        // File Name
        
        _messageText.text = [url lastPathComponent];
        
        NSString *alertMessage = [NSString stringWithFormat:@"Successfully attached %@", [url lastPathComponent]];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Import"
                                                  message:alertMessage
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
}
/*
 *
 * Cancelled
 *
 */
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller
{
    NSLog(@"Cancelled");
    
    NSString *alertMessage = @"Cancelled attachment";
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Alert"
                                              message:alertMessage
                                              preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    });
    
}


#pragma Delegate method
/**
 <#Description#>
 
 @param messageDetails <#messageDetails description#>
 */
-(void)messagesList:(NSDictionary *)messageDetails
{
    NSLog(@"messageDetails = %@", messageDetails);
    
//    NSArray *arrayResponseOne = [messageDetails objectForKey:@"ChatData"];
//    
//    for (int i=0; i<[arrayResponseOne count]; i++)
//    {
//        NSDictionary *dictResponseOne = [arrayResponseOne objectAtIndex:i];
//        [mA1 addObject:[dictResponseOne objectForKey:@"TeacherDetails"]];
//        
//    }
    
    _chatdataDict=[messageDetails objectForKey:@"ChatData"];
    
    
    NSLog(@"%@",_chatdataDict);
    
    _TeacherdetailArray =[_chatdataDict objectForKey:@"TeacherDetails"];
    _StudentdetailArray=[_chatdataDict objectForKey:@"StudentDetails"];
    
    [_chatUserList addObjectsFromArray:[_chatdataDict valueForKey:@"StudentDetails"]];
    [_chatUserList addObjectsFromArray:[_chatdataDict valueForKey:@"TeacherDetails"]];
    
    NSLog(@"%@",_chatUserList);
    [_chatUserNameList addObjectsFromArray: [[_chatdataDict valueForKey:@"StudentDetails"] valueForKey:@"UserFirstName"]];
    [ _chatUserNameList addObjectsFromArray:[[_chatdataDict valueForKey:@"TeacherDetails"] valueForKey:@"UserFirstName"]];
  
    //           [self loadImagesForChatTable];
   
    [self createChatUserImageList];
}



- (IBAction)AdditionalInformationBtn:(id)sender {
    
    _LUchatUserTableView.allowsSelection=NO;
    
    if (_chatHistory.count!=0)
    {
        _additinalview.hidden=NO;
        CALayer *shadowLayer = _additinalview.layer;
        shadowLayer.shadowColor = [[UIColor blackColor] CGColor];
        
        _RollNameLbl.text= Rollnumber;
        _ClassNameLbl.text=ClassName;
        _StudentRollLbl.text=Studentroll;
        _Nametype.text=nametype;
        _Imageview.image;
    }
    
    
}

- (IBAction)closeBtn:(id)sender {
    
    _additinalview.hidden=YES;
    _LUchatUserTableView.allowsSelection=YES;
}


- (void) createChatUserImageList
{
    if([_chatUserList count])
    {
        NSString *imageURL;
        for(NSInteger i= 0; i< [_chatUserList count]; i++)
        {
            imageURL = [[_chatUserList objectAtIndex:i] valueForKey:@"UserProfileImage"];
            
            //        NSURL *url = [NSURL URLWithString:@"http://setumbrella.in/img/Lighthouse.jpg"];
            NSURL *url = [NSURL URLWithString:imageURL];
            
            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (data) {
                        UIImage *image = [UIImage imageWithData:data];
                        if (image)
                        {
                            
//                            dispatch_async(dispatch_get_main_queue(),
//                                           
//                            ^{
                            
                                
                            [_chatImageList addObject:image];
                            NSLog(@" image count = %lu", (unsigned long)[_chatImageList count]);
                            
                            
  //                          });
                        }
                    }
                    if([_chatImageList count] == [_chatUserList count])
                    {
                        NSLog(@"I am here");
                        [self loadChatUserTable];
                    }
                });
                
                
            }];
            [task resume];
        }
    }
}
//
/**
 <#Description#>
 */
- (void) loadChatUserTable
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_LUchatUserTableView reloadData];
        //        [_chatUserTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    });
}

/**
 <#Description#>
 
 @param index <#index description#>
 @return <#return value description#>
 */
- (UIImage *) mapImageForReceiverAndSender:(NSInteger) index
{
    NSString *senderId = [[_chatHistory objectAtIndex:index] valueForKey:@"ReceiverId"];
    NSLog(@"%@", senderId);
    
    //    NSString *receiverId = [[_chatHistory objectAtIndex:index] valueForKey:@"receiver_id"];
    
    __block UIImage *image = [UIImage imageNamed:@"premium01@2x.png"];
    [_chatUserList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([[obj valueForKey:@"UserProfileImage"] isEqualToString:senderId])
            image = [_chatImageList objectAtIndex:idx];
    }];
    return image;
}

//http://setumbrella.in/learning_umbrella/chat/chat_receive.php?school_id=13&sender_id=3&receiver_id=6
/**
 <#Description#>
 */
- (void) fetchChatHistory
{
    //userid, userrollid
    
    NSString*receive_Id =[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserId"];
    
    NSString*receiveroll_Id=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserRoleId"];
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc]init];
    [body setObject:receive_Id forKey:@"ReceiverId"];
    [body setObject:receiveroll_Id forKey:@"ReceiverRoleId"];
    
    refreshBody = [body copy];
    
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton messagesChatHistoryList:body];
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(refreshTable) userInfo:nil repeats:YES];
    
    //    NSString*receiveroll_Id =[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserRoleId"];
    //  NSString *sender_id = @"3";
    
    //    //    NSURLComponents *components = [NSURLComponents componentsWithString:@"http://setumbrella.in/learning_umbrella/chat/chat_receive.php"];
    //
    //    NSURLComponents *components = [NSURLComponents componentsWithString:MessagesFetchChatHistory_Link];
    //
    //    components.queryItems = @[ [NSURLQueryItem queryItemWithName:@"ReceiverId" value:receive_Id], [NSURLQueryItem queryItemWithName:@"UserRoleId" value:receiveroll_Id]];
    //    NSURL *url = components.URL;
    //
    //    //    NSURL *url = [NSURL URLWithString:@"http://setumbrella.in/learning_umbrella/chat/chat_receive.php?school_id=13&sender_id=3&receiver_id=6"];
    //
    //    [sharedSingleton messagesChatHistoryList: [url absoluteString]];
    
    /*
     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
     
     NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
     
     NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     if(error)
     {
     NSLog(@"Error = %@", error);
     }
     else
     {
     _chatHistory = [[NSMutableArray alloc] init];
     _chatHistory = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
     NSLog(@"chatHistory = %@", _chatHistory);
     [_chatHistory enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     NSLog(@"obj = %@\n", obj);
     }];
     [self loadChatHistoryTable];
     }
     
     }];
     [dataTask resume];
     */
}


/**
 <#Description#>
 
 @param messagesChatHistoryDict description
 */
- (void) messagesChatHistoryList: (NSDictionary *)messagesChatHistoryDict
{
    NSLog(@"%@", messagesChatHistoryDict);
    
    _chatdetailDict=[messagesChatHistoryDict objectForKey:@"ChatData"];
    NSLog(@"%@",_chatdetailDict);
    
    _chatHistory = [[NSMutableArray alloc] init];
    
    
    [_chatHistory addObjectsFromArray:[_chatdetailDict valueForKey:@"ChatDetails"]];
    NSLog(@"%@",_chatHistory);
    
    //    _chatHistory = [[NSMutableArray alloc] init];
    //   _chatHistory = [NSMutableArray arrayWithArray:messagesChatHistoryDict];
    //    NSLog(@"chatHistory = %@", _chatHistory);
    [_chatHistory enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj = %@\n", obj);
    }];
    [self loadChatHistoryTable];
    
}


/**
 <#Description#>
 */
- (void) loadChatHistoryTable
{
    //dispatch_async(dispatch_get_main_queue(), ^{
        [_LUchatMessageTableView reloadData];
        
       // NSIndexPath* ip = [NSIndexPath indexPathForRow:[_LUchatMessageTableView numberOfRowsInSection:0] - 1 inSection:0];
        
       // [_LUchatMessageTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        if (_LUchatUserTableView.contentSize.height > _LUchatMessageTableView.frame.size.height)
        {
            CGPoint offset = CGPointMake(0, _LUchatMessageTableView.contentSize.height -     _LUchatMessageTableView.frame.size.height);
            [_LUchatMessageTableView setContentOffset:offset animated:YES];
        }
        //_messageText.text = @"";
  //  });
}

/**
 <#Description#>
 */
- (void) sendChatMessage
{
    //    NSURL *url = [NSURL URLWithString:@"http://setumbrella.in/learning_umbrella/chat/save_chat.php?school_id=13&sender_id=1111&receiver_id=2222&message=gggg"];
    
    
    NSString *ReceiverId = [[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserId"];
    
    NSString*Receiveroll_Id=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserRoleId"];
    //[[[_chatUserList valueForKey:@"class_students"] objectAtIndex:[_chatTableView indexPathForSelectedRow].row] valueForKey:@"user_id"];
    
    NSString *messageString = _messageText.text;
    
    
    NSMutableDictionary*Body= [[NSMutableDictionary alloc]init];
    
    [Body setObject:ReceiverId forKey:@"ReceiverId"];
    [Body setObject:Receiveroll_Id forKey:@"ReceiverUserRoleId"];
    [Body setObject:messageString forKey:@"MessageDetails"];
    //[Body setObject:[_profiledata objectForKey:@"RoleId"] forKey:@"SenderUserRoleId"];
    if (documentData!=nil)
    {
        NSString *newStr = [documentData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [Body setObject:newStr forKey:@"MessageAttachmentUrl"];
        [Body setObject:extension forKey:@"MessageFileExtension"];//MessageFileExtension
        documentData=nil;
    }
    
    
    
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton messagesSendChatMessage:Body];
    
   // [self loadChatHistoryTable];
    
    
    
    //    NSURLComponents *components = [NSURLComponents componentsWithString:@"http://setumbrella.in/learning_umbrella/chat/save_chat.php"];
    
    //    NSURLComponents *components = [NSURLComponents componentsWithString:MessagesSendChatMessage_Link];
    //
    //    components.queryItems = @[ [NSURLQueryItem queryItemWithName:@"school_id" value:@"13"], [NSURLQueryItem queryItemWithName:@"sender_id" value:@"3"],
    //                               [NSURLQueryItem queryItemWithName:@"receiver_id" value:receiverId],
    //                               [NSURLQueryItem queryItemWithName:@"message" value:messageString]];
    //
    //    NSURL *url = components.URL;
    //
    //    [sharedSingleton messagesSendChatMessage:[url absoluteString]];
    //
    /*
     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
     
     NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
     
     __block NSString *temp;
     NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     if(error)
     {
     NSLog(@"Error = %@", error);
     }
     else
     {
     NSMutableArray *chatUserList = [[NSMutableArray alloc] init];
     chatUserList = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
     NSLog(@"chatUserList = %@", chatUserList);
     temp = [NSString stringWithFormat:@"%@",[chatUserList valueForKey:@"Message"]];
     //            _messageText.text = @"";
     
     }
     
     }];
     [dataTask resume];
     */
    _messageText.text = @"";

}


/**
 <#Description#>
 
 @param sendMessageResponseDict description
 */
- (void) messagesSendMessageResponse:(NSDictionary *) sendMessageResponseDict
{
    NSLog(@"sendMessageResponseArray = %@", sendMessageResponseDict);
    
    NSMutableArray *chatUserList = [[NSMutableArray alloc] init];
    chatUserList = [NSMutableArray arrayWithArray:sendMessageResponseDict];
    
    NSLog(@"chatUserList = %@", chatUserList);
    NSString *temp = [NSString stringWithFormat:@"%@",[chatUserList valueForKey:@"Message"]];
    NSLog(@"temp = %@", temp);
}



//download task
-(void)downloadTask
{
    
    NSURL *URL = [NSURL URLWithString:MessagesFetchChatHistory_Link];
    // turn it into a request and use NSData to load its content
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // find Documents directory and append your local filename
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentsURL = [documentsURL URLByAppendingPathComponent:@"2Hrs permission form 03rd.docx"];
    
    // and finally save the file
    [data writeToURL:documentsURL atomically:YES];
    
    
}

-(void)keyboardWillShow
{
    
    self.uiview.frame = CGRectMake(0,352, 905, 70);
    
    //    CGRect frame = [_LUchatMessageTableView frame]; //assuming tableViewer is your tableview
    //    frame.size.height -= 300;
    //    [_LUchatMessageTableView setFrame:frame];
    // _LUchatMessageTableView.frame=CGRectMake(0, 100, 905, 754);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 352, 0.0);
    
    [_LUchatMessageTableView setContentInset:contentInsets];
    
    [_LUchatMessageTableView setScrollIndicatorInsets:contentInsets];
    
    NSInteger lastsection= [_LUchatMessageTableView numberOfSections ]-1;
    NSInteger rowIndex = [_LUchatMessageTableView numberOfRowsInSection:lastsection]-1;
    
    if (rowIndex>=0)
    {
        NSIndexPath *indexpathTemp = [NSIndexPath indexPathForRow:rowIndex inSection:lastsection];
       // NSIndexPath* ip = [NSIndexPath indexPathForRow:[_LUchatMessageTableView numberOfRowsInSection:0] - 1 inSection:0];
        
        [_LUchatMessageTableView scrollToRowAtIndexPath:indexpathTemp atScrollPosition:UITableViewScrollPositionBottom animated:NO];

        
    }
    
}

-(void)keyboardWillHide
{
    self.uiview.frame = CGRectMake(0, 825, 905, 70);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 63, 0.0);//y position 63(tableview)
    
    [_LUchatMessageTableView setContentInset:contentInsets];
    
    [_LUchatMessageTableView setScrollIndicatorInsets:contentInsets];
    
    //_LUchatMessageTableView.frame=CGRectMake(0, 63, 905, 754);
//    NSIndexPath* ip = [NSIndexPath indexPathForRow:[_LUchatMessageTableView numberOfRowsInSection:0] - 1 inSection:0];
//    
//    [_LUchatMessageTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//    
    
}



#pragma mark textfield delegate

//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//{
//
//    if (textField==_messageText)
//    {
//        self.uiview.frame =CGRectMake(0, -5, 905, 69);
//    }
//
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField;
//{
//
////    [self.messageText resignFirstResponder];
//
//}
#pragma mark
#pragma mark TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_LUchatMessageTableView])
    {
        return 200.00;//cell size
        
    }
    else
    {
        return 100.00;
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count;
    if([tableView isEqual:_LUchatUserTableView])
    {
        count = _chatUserNameList.count;
    }
    else if([tableView isEqual:_LUchatMessageTableView])
    {
        count = _chatHistory.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    
    if([tableView isEqual:_LUchatUserTableView])
    {
        
        LUChatUserView *chatCell = [tableView  dequeueReusableCellWithIdentifier:@"ChatCell"];
        if (chatCell == nil)
        {
            chatCell = [[LUChatUserView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatCell"];
        }
        
       
        NSString *readOrUnread;
        
        
        
        
        readOrUnread = [[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"Status"];
        
        if([readOrUnread isEqualToString:@"Online"])
        {
            chatCell.statusimage.image=[UIImage imageNamed:@"Online.png"];
            
        }
        else
        {
            chatCell.statusimage.image=[UIImage imageNamed:@"Offline.png"];
        }
        

//        
//        readOrUnread = [[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"Status"];
//        
//        if([readOrUnread isEqualToString:@"Online"])
//        {
//            
//              chatCell.statusimage.image=[UIImage imageNamed:@"read"];
//            
//        }
//        else
//        {
//            chatCell.statusimage.image=[UIImage imageNamed:@"unread"];
//        }
//        
//        
        
        chatCell.name.text = [[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"UserFirstName"];
        
        chatCell.lastLogin.text = [[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"LastLogin"];
      
        lastlogindate = [[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"LastLogin"];
        NSLog(@"%@",lastlogindate);
        
        
        if([_chatImageList objectAtIndex:indexPath.row] != nil)
        {
            chatCell.imageUser.image = (UIImage *)[_chatImageList objectAtIndex:indexPath.row];
        }
        else
        {
            //            chatCell.imageUser.image = nil;
            chatCell.imageUser.image = [UIImage imageNamed:@"Offline.png"];
        }
                return chatCell;
        
    }
    else if([tableView isEqual:_LUchatMessageTableView])
    {
        NSString *senderId = [[_chatHistory objectAtIndex:indexPath.row] valueForKey:@"ReceiverId"];
        
        _chatCell = ([senderId isEqualToString:teacherId]) ? (LUChatMessageView *)[tableView dequeueReusableCellWithIdentifier:@"chatReceive"] : (LUChatMessageView *)[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
        
        
        _chatCell.message.text = [[_chatHistory objectAtIndex:indexPath.row] valueForKey:@"MessageDetails"];
        
        _chatCell.message.adjustsFontSizeToFitWidth = NO;
        _chatCell.message.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        
        _chatCell.message.numberOfLines = 1;
        [_chatCell.message sizeToFit];
        _chatCell.time.text = [[_chatHistory objectAtIndex:indexPath.row] valueForKey:@"CreatedAt"];
        
        _chatCell.imageUser.image = ([senderId isEqualToString:teacherId])?  [self mapImageForReceiverAndSender:indexPath.row]:[UIImage imageNamed:profileImage];
        return _chatCell;
    }
    else
    {
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserFirstName"];
    _receiverName.text = name;
    
    
    Rollnumber=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserFirstName"];
    Studentroll=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"RollNumber"];
    
    ClassName=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"ClassName"];
    
    nametype=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"RoleName"];
    
    _Imageview.image =(UIImage *)[_chatImageList objectAtIndex:indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fetchChatHistory];
    });
    
    //    if (indexPath.row==Studentroll)
    //    {
    //        
    //    }
    //   
}

-(void)loadData
{
    
    NSDictionary *mainResponse = [LUOperation getSharedInstance].userProfileDetails;
    
    responseObject = [mainResponse objectForKey:@"item"];
    
    profileImage = [responseObject objectForKey:@"UserProfileImage"];
    firstName = [responseObject objectForKey:@"UserFirstName"];
    lastName = [responseObject objectForKey:@"UserLastName"];
    designation = [responseObject objectForKey:@"DesignationData"];
    dob = [responseObject objectForKey:@"UserDateOfBirth"];
    email = [responseObject objectForKey:@"UserEmail"];
    phone = [responseObject objectForKey:@"UserMobileNumber"];
    gender = [responseObject objectForKey:@"UserGender"];
    address = [responseObject objectForKey:@"UserAddress"];
    teacherId = [responseObject objectForKey:@"Id"];
    NSLog(@"%@",teacherId);
//    
//    NSArray *classSubjectDataResponse = [responseObject objectForKey:@"ClassSubjectData"];
//    NSLog(@"%@",classSubjectDataResponse);
//    NSArray *a1 = [classSubjectDataResponse objectAtIndex:0];
//    NSDictionary *responseOne_login = [a1 objectAtIndex:0];
//    
//    for (int i=0; i<[classSubjectDataResponse count]; i++)
//    {
//        [ClassId_login addObject:[responseOne_login objectForKey:@"ClassId"]];
//        [ClassName_login addObject:[responseOne_login objectForKey:@"ClassName"]];
//        [SectionData_login addObject:[responseOne_login objectForKey:@"sectiondata"]];
//    }
//    
//    sectionDataResponse = [SectionData_login objectAtIndex:0];
//    for (int i=0; i<[sectionDataResponse count]; i++)
//    {
//        NSDictionary *subjectResultResponse = [sectionDataResponse objectAtIndex:i];
//        NSLog(@"%@",subjectResultResponse);
//        [SectionId_login addObject:[subjectResultResponse objectForKey:@"SectionId"]];
//        [SectionName_login addObject:[subjectResultResponse objectForKey:@"SectionName"]];
//        [Subjectresult_login addObject:[subjectResultResponse objectForKey:@"subjectresult"]];
//    }
//    
//    for (int j=0; j<[Subjectresult_login count]; j++)
//    {
//        subjectnameResponse = [Subjectresult_login objectAtIndex:j];
//        for (int i=0; i<[subjectnameResponse count]; i++)
//        {
//            NSDictionary *subjectnameResponseTwo = [subjectnameResponse objectAtIndex:i];
//            NSLog(@"%@",subjectnameResponseTwo);
//            
//            [subjectName addObject:[subjectnameResponseTwo objectForKey:@"SubjectName"]];
//            [subjectCode addObject:[subjectnameResponseTwo objectForKey:@"SubjectId"]];
//            
//            [SubjectId_login addObject:[subjectnameResponseTwo objectForKey:@"SubjectId"]];
//            [SubjectName_login addObject:[subjectnameResponseTwo objectForKey:@"SubjectName"]];
//        }
//    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
