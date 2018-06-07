//
//  LUStudentMessagesViewController.m
//  LearningUmbrellaMaster
//
//  Created by Preeti Patil on 27/05/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUStudentMessagesViewController.h"
//#import "LUStudentProfileViewController.h"
#import "MobileCoreServices/MobileCoreServices.h"
#import <QuartzCore/QuartzCore.h>


@interface LUStudentMessagesViewController()

@property (weak, nonatomic) IBOutlet UITableView *chatUserTableView;
@property (weak, nonatomic) IBOutlet UITableView *chatMessageTableView;
@property (weak, nonatomic) IBOutlet UITableView *LUchatUserTableView;
@property (weak, nonatomic) IBOutlet UITableView *LUchatMessageTableView;

@end

@implementation LUStudentMessagesViewController
{
    //    ChatCellSettings *chatCellSettings;
    LUOperation *sharedSingleton;
    NSDictionary*dict;
    NSDictionary*tablereload;
    NSData* documentData;
    NSURL *urlOfSelectedDocument;
    NSString*Rollnumber;
    NSString*Studentroll;
    NSString*ClassName;
    NSString*extension;
    NSString*lastlogindate;
    NSString*image;
    NSString*nametype;
    NSString *newStr;
    NSString*DownloadURL;
    int index;
    
}
- (void) viewDidLoad
{
    
    
    [super viewDidLoad];
    
    _additinalview.hidden=YES;
    [_attachfilebtn setEnabled:NO];
    [_sendbtn setEnabled:NO];
    _messageText.editable=NO;
    
    _LUchatMessageTableView.dataSource=self;
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"yourKeyName"];
    _profiledata= [[NSMutableDictionary alloc] init];
    _profiledata=[[NSKeyedUnarchiver unarchiveObjectWithData:data] objectForKey:@"item"];
    //StudentProfileImage
    _stdntID=[_profiledata objectForKey:@"StudentId"];
    _stdntImage= [_profiledata objectForKey:@"StudentProfileImage"];
    [self initializeMessageView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    //    _closeBtn.layer.cornerRadius = 15; // this value vary as per your desire
    //    _closeBtn.clipsToBounds = YES;
    
    //    sharedSingleton = [LUOperation getSharedInstance];
    //    sharedSingleton.LUDelegateCall=self;
    //    [sharedSingleton messagesList:Messages_Link];
    //
    //    _chatdataDict=[[NSMutableDictionary alloc] init];
    //    _chatUserNameList = [[NSMutableArray alloc] init];
    //    _chatHistory = [[NSMutableArray alloc] init];
    //    _chatUserList = [[NSMutableArray alloc] init];
    //    _chatUserImageList = [[NSMutableArray alloc] init];
    //    _chatImageList = [[NSMutableArray alloc] init];
    //    _chatMessageTableView.rowHeight = 175.0;
    //    _chatUserTableView.rowHeight = 75.00;
    //
    
    //    _messageText.text = @"Enter your message here";
    //    _messageText.textColor = [UIColor lightGrayColor];
    
    
    
    //    UIColor *borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    //    _messageText.layer.borderColor = borderColor.CGColor;
    //    _messageText.layer.borderWidth = 1.0;
    //    _messageText.layer.cornerRadius = 5.0;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [ timer invalidate];
    [_LUchatUserTableView removeFromSuperview];
    [_LUchatMessageTableView removeFromSuperview];
    
}

/**
 <#Description#>
 */
- (void) initializeMessageView
{
    sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton messagesList:Messages_Link];
    _chatUserNameList = [[NSMutableArray alloc] init];
    _chatHistory = [[NSMutableArray alloc] init];
    _chatUserList = [[NSMutableArray alloc] init];
    _chatUserImageList = [[NSMutableArray alloc] init];
    _chatImageList = [[NSMutableArray alloc] init];
    _chatMessageTableView.rowHeight = 175.0;
    _chatUserTableView.rowHeight = 75.00;
   
    

   }


-(void)updateTable
{
    //[self fetchChatHistory];
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton messagesChatHistoryList:tablereload];
    


}

- (IBAction)sendMessage:(id)sender
{
    
         [self sendChatMessage];
         _messageText.text = @"";
     }

/**
 <#Description#>
 
 @param sender <#sender description#>
 */
- (IBAction)attachFiles:(id)sender {
    
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
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
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
    
    _chatdataDict=[messageDetails objectForKey:@"ChatData"];
    NSLog(@"%@",_chatdataDict);
    
    _TeacherdetailArray =[_chatdataDict objectForKey:@"TeacherDetails"];
    _StudentdetailArray=[_chatdataDict objectForKey:@"StudentDetails"];
    
    [_chatUserList addObjectsFromArray:[_chatdataDict valueForKey:@"StudentDetails"]];
    [_chatUserList addObjectsFromArray:[_chatdataDict valueForKey:@"TeacherDetails"]];
    
    NSLog(@"%@",_chatUserList);
    [_chatUserNameList addObjectsFromArray: [[_chatdataDict valueForKey:@"StudentDetails"] valueForKey:@"UserFirstName"]];
    [ _chatUserNameList addObjectsFromArray:[[_chatdataDict valueForKey:@"TeacherDetails"] valueForKey:@"UserFirstName"]];
    
    
    
    // [self loadImagesForChatTable];
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


//-(void)additionalinformation
//
//{
//
//
//    NSArray*array;
//
//    array = [NSArray arrayWithArray:_chatUserList];
//
//    LUTimeTableDetailViewController *controller =[[LUTimeTableDetailViewController alloc]initWithNibName:@"LUTimeTableDetailViewController" bundle:nil];
//    controller.detailArray= @[[[array objectAtIndex:indexPath.row] valueForKey:@"NotificationTitle"], [[array objectAtIndex:indexPath.row] valueForKey:@"NotificationDescription"]];//[cellData object];
//
//    // present the controller
//    // on iPad, this will be a Popover
//    // on iPhone, this will be an action sheet
//    controller.modalPresentationStyle = UIModalPresentationPopover;
//    [self presentViewController:controller animated:YES completion:nil];
//
//    // configure the Popover presentation controller
//    UIPopoverPresentationController *popController = [controller popoverPresentationController];
//    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    popController.delegate = self;
//
//    // in case we don't have a bar button as reference
//    popController.sourceRect = CGRectMake(300, 500, 10, 10);
//    popController.sourceView = self.view;
//
//
//
//
//}
//





/*
 2017-02-15 11:28:24.912 Learning Umbrella[3334:59262] messageDetails = {
 "class_students" =     (
 {
 name = xyz;
 profile = "http://setumbrella.in/img/";
 status = online;
 "user_id" = "<null>";
 },
 {
 name = sss;
 profile = "http://setumbrella.in/img/";
 status = online;
 "user_id" = "<null>";
 },
 {
 name = "sdf sdf";
 profile = "http://setumbrella.in/img/";
 status = online;
 "user_id" = "<null>";
 },
 {
 name = gayathri;
 profile = "http://setumbrella.in/img/user.png";
 status = online;
 "user_id" = 3431;
 },
 {
 name = dd;
 profile = "http://setumbrella.in/img/";
 status = online;
 "user_id" = "<null>";
 },
 {
 name = fgh;
 profile = "http://setumbrella.in/img/doc.png";
 status = online;
 "user_id" = 3440;
 },
 {
 name = nn;
 profile = "http://setumbrella.in/img/doc.png";
 status = online;
 "user_id" = 3453;
 }
 );
 "class_teachers" =     (
 {
 name = " ravi";
 profile = "http://setumbrella.in/img/Chrysanthemum.jpg";
 status = online;
 "user_id" = 4;
 },
 {
 name = asdasdqweqwe;
 profile = "http://setumbrella.in/img/";
 status = online;
 "user_id" = "<null>";
 }
 );
 }
 (lldb)
 */

/**
 <#Description#>
 */
- (void) createChatUserImageList
{
    if([_chatUserList count])
    {
        NSString *imageURL;
        for(NSInteger i= 0; i< [_chatUserList count]; i++)
        {
            imageURL = [[_chatUserList objectAtIndex:i] valueForKey:@"UserProfileImage"];
            
            //        NSURL *url = [NSURL URLWithString:@"http://setumbrella.in/img/Lighthouse.jpg"];
                         if ([imageURL isEqual:@""])
            {
                UIImage*ima=[UIImage imageNamed:@"Offline.png"];
                [_chatImageList addObject:ima];
                
               // NSLog(@"%lu",(unsigned long)[_chatImageList count]);
            }
           
            else
            {
                NSURL *url = [NSURL URLWithString:imageURL];

            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                //dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",data);
                    
                    if (data) {
                        
                
                        
                        UIImage *image1 = [UIImage imageWithData:data];
                        if (image1) {
                                                    //dispatch_async(dispatch_get_main_queue(), ^{
                            [_chatImageList addObject:image1];
                            NSLog(@" image count = %lu", (unsigned long)[_chatImageList count]);
                                                    //});
                        }

                        
                    }
                    
//                    if (data) {
//                        UIImage *image = [UIImage imageWithData:data];
//                        if (image) {
//                            //                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [_chatImageList addObject:image];
//                            NSLog(@" image count = %lu", (unsigned long)[_chatImageList count]);
//                            //                        });
//                        }
//                    }
                    if([_chatImageList count] == [_chatUserList count])
                    {
                        NSLog(@"I am here");
                        
                        [self loadChatUserTable];
                    }
                
               // });
                
                
            }];
            
            [task resume];
            }
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
    
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: _stdntImage]];
    
    NSLog(@"%@",imageData);
    __block UIImage *image = [UIImage imageWithData:imageData];
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
    tablereload=[body copy];
    
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton messagesChatHistoryList:body];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTable) userInfo:nil repeats:YES];
    
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
       
       NSInteger lastSection = [_LUchatMessageTableView numberOfSections] - 1;
       //[_LUchatMessageTableView.dataSource numberOfSectionsInTableView:self] - 1;
       
       NSInteger rowIndex =[_LUchatMessageTableView  numberOfRowsInSection:lastSection] - 1;
       //[_LUchatMessageTableView.dataSource tableView:self numberOfRowsInSection:lastSection] - 1;
       
       
       if(rowIndex >= 0)
       {
           
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:lastSection];
           [_LUchatMessageTableView scrollToRowAtIndexPath:indexPath  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
           
           //        NSIndexPath* ip = [NSIndexPath indexPathForRow:[_LUchatMessageTableView numberOfRowsInSection:0] - 1 inSection:0];
           //
           //        [_LUchatMessageTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
       }
       

//        if (_LUchatUserTableView.contentSize.height > _LUchatMessageTableView.frame.size.height)
//        {
//            CGPoint offset = CGPointMake(0, _LUchatMessageTableView.contentSize.height -     _LUchatMessageTableView.frame.size.height);
//            [_LUchatMessageTableView setContentOffset:offset animated:YES];
//        }
        //_messageText.text = @"";
   // });
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
    [Body setObject:[_profiledata objectForKey:@"RoleId"] forKey:@"SenderUserRoleId"];
    if (documentData!=nil)
    {
         newStr = [documentData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [Body setObject:newStr forKey:@"MessageAttachmentUrl"];
        [Body setObject:extension forKey:@"MessageFileExtension"];//MessageFileExtension
        documentData=nil;
    }
    
    
    
    LUOperation *sharedSingleton = [LUOperation getSharedInstance];
    sharedSingleton.LUDelegateCall=self;
    [sharedSingleton messagesSendChatMessage:Body];
    
    
    
    
    
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
    //downlaod from cell
    NSURL *URL = [NSURL URLWithString:DownloadURL];
    // turn it into a request and use NSData to load its content
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // find Documents directory and append your local filename
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
   // documentsURL = [documentsURL URLByAppendingPathComponent:@"2Hrs permission form 03rd.docx"];
       
    // and finally save the file
    [data writeToURL:documentsURL atomically:YES];
    NSLog(@"%@",data);
    
}



//check whether file download or not
// list contents of Documents Directory just to check
-(void)checklist
{
NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

NSArray *contents = [[NSFileManager defaultManager]contentsOfDirectoryAtURL:documentsURL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];

NSLog(@"%@", [contents description]);
    
}



-(void)keyboardWillShow {
    
    self.uiview.frame = CGRectMake(0,352, 905, 70);
    
    //    CGRect frame = [_LUchatMessageTableView frame]; //assuming tableViewer is your tableview
    //    frame.size.height -= 300;
    //    [_LUchatMessageTableView setFrame:frame];
    // _LUchatMessageTableView.frame=CGRectMake(0, 100, 905, 754);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 352, 0);
    
    [_LUchatMessageTableView setContentInset:contentInsets];
    
    [_LUchatMessageTableView setScrollIndicatorInsets:contentInsets];
    
    
    //if ([_LUchatMessageTableView cellForRowAtIndexPath:0]==nil)
    //{
        // row is not visible
   // }
   // else
   // {
    NSInteger lastSection = [_LUchatMessageTableView numberOfSections] - 1;
    //[_LUchatMessageTableView.dataSource numberOfSectionsInTableView:self] - 1;
    
    NSInteger rowIndex =[_LUchatMessageTableView  numberOfRowsInSection:lastSection] - 1;
    //[_LUchatMessageTableView.dataSource tableView:self numberOfRowsInSection:lastSection] - 1;
    
    
    if(rowIndex >= 0)
    {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:lastSection];
        [_LUchatMessageTableView scrollToRowAtIndexPath:indexPath  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
        //        NSIndexPath* ip = [NSIndexPath indexPathForRow:[_LUchatMessageTableView numberOfRowsInSection:0] - 1 inSection:0];
        //
        //        [_LUchatMessageTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }

    
}

-(void)keyboardWillHide {
    
    
    self.uiview.frame = CGRectMake(0, 825, 905, 70);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 63, 0.0);//y position 63(tableview)
    
    [_LUchatMessageTableView setContentInset:contentInsets];
    
    [_LUchatMessageTableView setScrollIndicatorInsets:contentInsets];
    
    _LUchatMessageTableView.frame=CGRectMake(0, 63, 905, 754);
    if ([_LUchatMessageTableView cellForRowAtIndexPath:0]==nil)
    {
        // row is not visible
   }
    else
    {
    
    
   
        NSIndexPath* ip = [NSIndexPath indexPathForRow:[_LUchatMessageTableView numberOfRowsInSection:0] - 1 inSection:0];
        
        [_LUchatMessageTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    }
    
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
        return 70.00;
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
        
        LUChatUserView *chatCell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
        if (chatCell == nil)
        {
            chatCell = [[LUChatUserView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatCell"];
        }
        
        //        NSString *dateString = @"2013-01-08 07:52:00 +0000";
        //        NSArray *components = [dateString componentsSeparatedByString:@" "];
        //        NSString *date = components[0];
        //        NSString *time = components[1];
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
        
        
        chatCell.name.text = [[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"UserFirstName"];
        chatCell.lastLogin.text=[[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"LastLogin"];
        lastlogindate=[[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"LastLogin"];
        NSLog(@"%@",lastlogindate);
        chatCell.imageUser.image = (UIImage *)[_chatImageList objectAtIndex:indexPath.row];
        
//        if([_chatImageList objectAtIndex:indexPath.row] != nil)
//        {
//            chatCell.imageUser.image = (UIImage *)[_chatImageList objectAtIndex:indexPath.row];
//        }
//        else
//        {
//            //            chatCell.imageUser.image = nil;
//            //chatCell.imageUser.image = [UIImage imageNamed:@"user.png"];
//        }
        //
        //        if([[[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"status"] isEqualToString:@"online"])
        //        {
        //            chatCell.status.image =  [UIImage imageNamed:@"Online.png"];
        //        }
        //        else
        //        {
        //            chatCell.status.image = [UIImage imageNamed:@"Offline.png"];
        //        }
        //
        //        chatCell.lastLogin.text = [[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"last_login"];
        return chatCell;
        
    }
    else if([tableView isEqual:_LUchatMessageTableView])
        
    {
        //NSString*receiveriD=[[_chatHistory objectAtIndex:indexPath.row] valueForKey:@"ReceiverId"]];
        NSString *senderId = [[_chatHistory objectAtIndex:indexPath.row] valueForKey:@"ReceiverId"];
        //
        //
        //
        //       NSString*receiverId =[[_chatUserList objectAtIndex:indexPath.row] valueForKey:@"UserId"];
        //
        //        if (senderId)
        //        {
        //            _chatCell = (LUChatMessageView *)[tableView dequeueReusableCellWithIdentifier:@"chatReceive"];
        //
        //        }
        //    else if (receiverId)
        //
        //    {
        //
        //        _chatCell= (LUChatMessageView *)[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
        //
        //
        //    }
        //        else
        //
        //        {
        //
        //
        //            _chatCell = (ChatTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Chatsend"];
        //
        //
        //        }
        //        _chatCell.message.text = [messagereceive objectAtIndex:indexPath.row];
        //        _chatCell.sendlbl.text=[messagesend objectAtIndex:indexPath.row];
        //        return _chatCell;
        
//        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        addButton.frame = CGRectMake(200.0f, 5.0f, 75.0f, 30.0f);
//        [addButton setTitle:@"download" forState:UIControlStateNormal];
//        [_chatCell addSubview:addButton];
//        [addButton addTarget:self
//                            action:@selector(downloadbtn:)
//                  forControlEvents:UIControlEventTouchUpInside];
     [_chatCell.downloadbtn addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _chatCell.downloadbtn.tag= indexPath.row;
        
//        NSString*urldata=[[_chatHistory objectAtIndex:indexPath.row] valueForKey:@"MessageAttachmentUrl"];
//        
//        if (_chatCell.message.text==urldata)
//            
//        {
//            [_chatCell.downloadbtn setHidden:YES];
//           
//        }
//        else{
//           
//            [_chatCell.downloadbtn setHidden:NO];
//           
//        }
//
        _chatCell = ([senderId isEqualToString:_stdntID]) ? (LUChatMessageView *)[tableView dequeueReusableCellWithIdentifier:@"chatReceive"] : (LUChatMessageView *)[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
        
        
        _chatCell.message.text = [[_chatHistory objectAtIndex:indexPath.row] valueForKey:@"MessageDetails"];
        
        //_chatCell.message.adjustsFontSizeToFitWidth = NO;
        //_chatCell.message.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        
        //_chatCell.message.numberOfLines = 1;
       // [_chatCell.message sizeToFit];
        _chatCell.time.text = [[_chatHistory objectAtIndex:indexPath.row] valueForKey:@"CreatedAt"];
        
        _chatCell.imageUser.image = ([senderId isEqualToString:_stdntID])?  [self mapImageForReceiverAndSender:indexPath.row]:[UIImage imageNamed:_stdntImage];
        
        if ([senderId isEqualToString:_stdntID])
        {
            
            _chatCell.imageUser.image =(UIImage *)[_chatImageList objectAtIndex:index];
            
        }
        
        else{
            
            
            _chatCell.imageUser.image =[self mapImageForReceiverAndSender:indexPath.row];
        }
        
        return _chatCell;
    }
    else
    {
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_LUchatUserTableView) {
        
    
    NSString *name = [[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserFirstName"];
    _receiverName.text = name;
    [_attachfilebtn setEnabled:YES];
    [_sendbtn setEnabled:YES];
    _messageText.editable=YES;
    
    Rollnumber=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"UserFirstName"];
    Studentroll=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"RollNumber"];
    
    ClassName=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"ClassName"];
    
    nametype=[[_chatUserList objectAtIndex:[_LUchatUserTableView indexPathForSelectedRow].row] valueForKey:@"RoleName"];
    index=(int)indexPath.row;
    _Imageview.image =(UIImage *)[_chatImageList objectAtIndex:index];
        index=(int)indexPath.row;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fetchChatHistory];
    });
    }
    
    else
    {
        //NSLog(@"message");
        
        DownloadURL =[[_chatHistory objectAtIndex:[_LUchatMessageTableView indexPathForSelectedRow].row]valueForKey:@"MessageAttachmentUrl"];
        NSLog(@"%@",DownloadURL);
        [self downloadTask];
    }
        
    
//    NSString*link =[[_chatHistory objectAtIndex:[_LUchatMessageTableView indexPathForSelectedRow].row]valueForKey:@"MessageAttachmentUrl"];
//    NSLog(@"%@",link);
    
//    if ([tableView isEqual:_LUchatMessageTableView])
//    {
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//         NSString*link =[[_chatHistory objectAtIndex:[_LUchatMessageTableView indexPathForSelectedRow].row]valueForKey:@"MessageAttachmentUrl"];
//    }
//    
//    if ((_chatCell=(LUChatMessageView *)[tableView dequeueReusableCellWithIdentifier:@"chatReceive"]))
//    {
//        
//        
//    }
    }


-(void)ButtonClicked:(UIButton*)sender
{
    NSLog(@"click");
    [self downloadTask];
   
  //    Bool cicked=1;
//    if(clicked)
//    {
//        [cell.yourbutton setTitle: @"myTitle" forState:@""];
//    }
    
}


@end
