//
//  LUOperation.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUOperation.h"

static LUOperation *luSharedInstance = nil;

@implementation LUOperation


+(LUOperation *)getSharedInstance
{
    if (nil != luSharedInstance)
    {
        return luSharedInstance;
    }
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        luSharedInstance = [[LUOperation alloc]init];
    });
    return luSharedInstance;
}


#pragma mark -
#pragma mark Login
//Fetch logged in user details
-(BOOL)userLoginWithURL:(NSString *)loginURL username:(NSString *)username password:(NSString *)password roleName:(NSString *)roleName DeviceId:(NSString *)devId
{
    __block BOOL returnLoginDetails=NO;
    // 1
    NSURL *url = [NSURL URLWithString:loginURL];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 3
//Teacher
 //NSDictionary *dictionary = @{@"username": @"abhishek@setinfotech.com", @"password":@"set@123", @"RoleName":@"Teacher", @"DeviceId":devId};
 //  NSDictionary *dictionary = @{@"username": @"allen@gmail.com", @"password":@"rakesh", @"RoleName":@"Teacher", @"DeviceId":devId};
// Student
 NSDictionary *dictionary = @{@"username": @"deepak@setinfotech.com", @"password":@"set@123", @"RoleName":@"Student", @"DeviceId":devId};
   

 //     NSDictionary *dictionary = @{@"username": username, @"password":password, @"RoleName":roleName, @"DeviceId":devId};
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:kNilOptions error:&error];
    [request setHTTPBody:data];
//    request.HTTPBody = data;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
     completionHandler:^(NSData *data,
                         NSURLResponse *response,
                         NSError *error)
      {
          dispatch_async(dispatch_get_main_queue(), ^{
          if (!error)
          {
              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
              _userProfileDetails = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              NSLog(@"JSONArray = %@",_userProfileDetails);
             
              NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
              NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_userProfileDetails];
              [currentDefaults setObject:data forKey:@"yourKeyName"];
              
             // loginModel.loginDetailModel = [userProfileDetails valueForKey:@"item"] ;
              returnLoginDetails=YES;
              if (returnLoginDetails==YES)
              {
                  [self userLoginDelegate];
              }
              else
              {
                  //handle alert here
              }
          }
          else
          {
              [self errorLog:error.localizedDescription];
              NSLog(@"Error: %@", error.localizedDescription);
          }
          });
      }];
    [task resume];
 return returnLoginDetails;
}
-(void)errorLog:(NSString *)log{
    if( [_LUDelegateCall respondsToSelector:@selector(errorLog:)] )
    {
        [_LUDelegateCall errorLog:log];
    }
}

// Delegate Call for userLogin
-(void)userLoginDelegate
{   //Selector method in login
    if ([_LUDelegateCall respondsToSelector:@selector(loginUser:)])
    {
       
        token = [[_userProfileDetails valueForKey:@"item"] valueForKey:@"Token"];
        ClassSubjectData = [[[_userProfileDetails valueForKey:@"item"] valueForKey:@"ClassSubjectData"] objectAtIndex:0];
       
        //        [_LUDelegateCall loginUser:userProfileDetailsDictionary ];
        [_LUDelegateCall loginUser:_userProfileDetails];
        //pass  response to the selector method
    }
}


#pragma mark -
#pragma mark Logout
//Fetch logged in user details
-(BOOL)logoutUser:(NSString *)logoutURL
{
    __block BOOL returnLogoutDetails=NO;

    // 1
    NSURL *url = [NSURL URLWithString:logoutURL];
    
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
          if (!error)
          {
              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
              
              NSLog(@"data = %@", data);
              userLogoutDetails = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              NSLog(@"JSONArray = %@",userLogoutDetails);
              
              returnLogoutDetails=YES;
              if (returnLogoutDetails==YES)
              {
                  [self userLogoutDelegate];
              }
              else
              {
                  //handle alert here
              }
          }
          else
          {
              NSLog(@"Error: %@", error.localizedDescription);
          }
         });
      }];
    [task resume];
    return returnLogoutDetails;
}

// Delegate Call for userLogin
-(void)userLogoutDelegate
{   //Selector method in login
    if ([_LUDelegateCall respondsToSelector:@selector(userLoggedOut:)])
    {
        [_LUDelegateCall userLoggedOut:userLogoutDetails];
        //pass  response to the selector method
    }
}


#pragma mark -
#pragma mark Assignment
//Fetch assignment
-(BOOL)assignmentList:(NSString *)URL
{
    __block BOOL returnAssignmentList=NO;
    // 1
    NSURL *url = [NSURL URLWithString:URL];
    
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                            dispatch_async(dispatch_get_main_queue(),
                                            ^{
                                               
                                                NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                NSDictionary *jsonDict;
                                                if (data!=nil) {
                                                   jsonDict  =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                }
                                               else
                                               {
                                                   //alert
                                               }
                                                if (jsonDict.count!=0)
                                                {
                                                    assisnmentListArray = [jsonDict objectForKey:@"Notes"];
                                                    returnAssignmentList=YES;

                                                }
                                                else
                                                {
                                                    //alert
                                                }
                                                if (returnAssignmentList==YES)
                                                {
                                                    [self assignmentDelegate];
                                                }
                                                else
                                                {
                                                    //handle alert here
                                                }
                                                
                                              
                                                
                                            });
                                        }];
    [task resume];

    return returnAssignmentList;
}

//Delegate Call for assignment details fetch
-(void)assignmentDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(assignmentList:)])
    {
        [_LUDelegateCall assignmentList:assisnmentListArray ]; //pass  response to the selector method
    }
}


#pragma mark
#pragma mark Assignment
- (BOOL) assignmentSubmit: (NSDictionary *)body
{
    __block BOOL returnAssignmentSubmissionDetails=NO;
    // 1
    NSURL *url = [NSURL URLWithString:AssignmentSubmit_link];
    NSError *error;
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              assignmentSubmittedresponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              [self assignmentSubmissionDelegate];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    
    
    return returnAssignmentSubmissionDetails;

}
-(void)assignmentSubmissionDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(assignmentSubmit:)])
    {
        [_LUDelegateCall assignmentSubmit:assignmentSubmittedresponse ]; //pass  response to the selector method
    }
}








#pragma mark -
#pragma mark Notes
//Fetch notes List for the shelf

-(BOOL)notesList:(NSString *)URL
{
    NSLog(@"%@",URL);
    __block BOOL returnNotesList=NO;
    // 1
    NSURL *url = [NSURL URLWithString:URL];
    NSError *error;
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 3
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    
    
                                        {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                               
                                                NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                if (data!=nil) {
                                                     noteListArray  =  [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"Notes"];
                                                }
                                                else
                                                {
                                                    //alert
                                                }
                                               
                                                if (noteListArray.count!=0 )//|| [noteListArray isNotEqual:@""])
                                                {
                                                    returnNotesList=YES;
                                                }
                                                else
                                                {
                                                    //alert
                                                }
                                                
                                                if (returnNotesList==YES)
                                                {
                                                    [self notesDelegate];
                                                }
                                                else
                                                {
                                                    //handle alert here
                                                }
                                            });
                                        
                                        }];
    [dataTask resume];
    return returnNotesList;
}

//Delegate call for notes list
-(void)notesDelegate{
    if ([_LUDelegateCall respondsToSelector:@selector(noteList:)])
    {
        [_LUDelegateCall noteList:noteListArray];
    }
}


- (BOOL) notesSubmit: (NSDictionary *)body
{
    __block BOOL returnSubmission=NO;
    // 1
    NSURL *url = [NSURL URLWithString:NotesSubmit_link];
    NSError *error;
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                              
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    
    
    
    
    
    return  returnSubmission;

    
    
}



#pragma mark
#pragma mark Drawing
- (BOOL) drawingSubmit: (NSDictionary *)body
{
 __block BOOL returnSubmission=NO;
    // 1
    NSURL *url = [NSURL URLWithString:DrawingSubmit_Link];
    NSError *error;
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                              
                                            
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    
    
    

    
    return  returnSubmission;
}



#pragma mark -
#pragma mark Exam

-(BOOL)examCall:(NSString *)url body:(NSDictionary *)body
{
     __block BOOL returnExamResonse=NO;
    // 1
    NSURL *URL = [NSURL URLWithString:url];
    NSError *error;
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
   
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (body.count!=0)
    {
        [request setHTTPMethod:@"POST"];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
        [request setHTTPBody:postData];
        
    }else
    {
         [request setHTTPMethod:@"GET"];
    }
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                              questionListArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"TestData"];
                                              returnExamResonse=YES;
                                              if (returnExamResonse==YES)
                                              {
                                                  [self questionsDelegate];
                                              }
                                              else
                                              {
                                                  //handle alert here
                                              }

                                              
//                                              _response.text =[ NSString stringWithFormat:@"%li",(long)((NSHTTPURLResponse *)response).statusCode];
//                                              _response.text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                                              _serializedData.text =[ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    return returnExamResonse;
    

}
-(void)questionsDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(questionList:)])
    {
        [_LUDelegateCall questionList:questionListArray];
    }
}

//Fetch exam details
-(BOOL)examList:(NSString *)URL
{
    __block BOOL returnNotesList=NO;
    // 1
    NSURL *url = [NSURL URLWithString:URL];
//NSString *tokenTemp = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIxIiwiaWF0IjoxNDk1Mjk1NzM0LCJleHAiOjE0OTUzMjQ1MzR9.JsGsHxgP7U1tbAv0_hJ5NJ12DEDhKR-Gn4TRlRivfFQ";
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
    
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                if (data!=nil) {
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    examListArray = [responseDict objectForKey:@"TestData"];                }
                else
                {
                    //alert
                }
                
                if (examListArray.count!=0 )//|| [noteListArray isNotEqual:@""])
                {
                    returnNotesList=YES;
                }
                else
                {
                    //alert
                }
                
                if (returnNotesList==YES)
                {
                   [self examDelegate];
                }
                else
                {
                    //handle alert here
                }

            });
        }];
        [task resume];
    return returnNotesList;
}

// Delegate call for exam list
-(void)examDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(examList:)])
    {
        [_LUDelegateCall examList:examListArray];
    }
}


//Exam sub,it
- (BOOL) Examsubmit:(NSDictionary *)body
{
    __block BOOL returnSubmission=NO;
    // 1
    NSURL *url = [NSURL URLWithString:submitExam_link ];
    NSError *error;
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                              
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    
    
    
    
    
    return  returnSubmission;
}






//#pragma mark -
//#pragma mark Question
////Fetch Questions details
//-(BOOL)questionList:(NSString *)URL
//{
//    __block BOOL returnNotesList=NO;
//    
//    NSString *dataUrl  =  URL;
//    NSURLSession *session  =  [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask  =  [session dataTaskWithURL:[NSURL URLWithString:dataUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        questionListArray = [[NSArray alloc]init];
//        questionListArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//        
//        
//        returnNotesList=YES;
//        if (returnNotesList==YES)
//        {
//            [self questionsDelegate];
//        }
//        else
//        {
//            //handle alert here
//        }
//        
//    }];
//    [dataTask resume];
//    
//    return returnNotesList;
//}
//
////Delegate call for exam questions
//-(void)questionsDelegate
//{
//    if ([_LUDelegateCall respondsToSelector:@selector(questionList:)])
//    {
//        [_LUDelegateCall questionList:questionListArray];
//    }
//}

//#pragma mark -
//#pragma mark RegularQuestions
////Fetch RegularQuestions details
//-(BOOL)regularQuestionList:(NSString *)URL
//{
//    __block BOOL returnQuestionList=NO;
//    NSString *dataUrl  = URL;
//    NSURLSession *session  =  [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask  =  [session dataTaskWithURL:[NSURL URLWithString:dataUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            regularQuestionListArray  =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            returnQuestionList=YES;
//            if (returnQuestionList==YES)
//            {
//                [self regularQuestionsDelegate];
//            }
//            else
//            {
//                
//            }
//            
//            });
//    }];
//    [dataTask resume];
//
//    return returnQuestionList;
//}
//
//#pragma Delegate call for RegularQuestions
//-(void)regularQuestionsDelegate
//{
//    if ([_LUDelegateCall respondsToSelector:@selector(regularQuestionList:)]) //tochange
//    {
//        [_LUDelegateCall regularQuestionList:regularQuestionListArray];
//    }
//}
//
#pragma mark -
#pragma mark ResourceLibrary
//Fetch ResourceLibrary details
-(BOOL)resourceLibraryList:(NSString *)URL body:(NSDictionary *)body
{
    
    __block BOOL returnLibraryList=NO;
    NSError *error;
    // 1
    NSURL *lURl = [NSURL URLWithString:URL];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:lURl];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                          resourceLibraryListDict =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          
                                          
                                          //                                          for (int i=0; i<response.count; i++)
                                          //                                          {
                                          //                                              resourceLibraryListArray = [response objectForKey:@"ResourceBank"];
                                          //                                          }
                                          
                                          returnLibraryList=YES;
                                          if (returnLibraryList==YES)
                                          {
                                              [self resourceLibraryDelegate];
                                          }
                                          else
                                          {
                                              
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    return returnLibraryList;
}

//Delegate call for resourceLibrary
-(void)resourceLibraryDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(resourceLibraryList:)]) //tochange
    {
        [_LUDelegateCall resourceLibraryList:resourceLibraryListDict];
    }
}


#pragma mark -
#pragma mark TimeTable
// Fetch TimeTable details
-(BOOL)timeTableList:(NSString *)URL
{
     __block BOOL returnTimetableList=NO;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {

            dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
            timeTableListArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                returnTimetableList=YES;
                if (returnTimetableList==YES)
                {
                    [self timeTableDetailsDelegate];
                }
                else
                {
                    
                }
            });
            
        }];
        [task resume];

   
    
    return returnTimetableList;
}

//Delegate call for TimeTable

-(void)timeTableDetailsDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(timeTableList:)])
    {
        [_LUDelegateCall timeTableList:timeTableListArray];
    }
}

-(BOOL) todaytimeTableList:(NSDictionary *)body
{
    __block BOOL returntodayTimetableList=NO;
    
    
    NSURL *url = [NSURL URLWithString:TodayTimeTable_Link];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              todaytimetable=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              [self todaytimeTableDetailsDelegate];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    
    return returntodayTimetableList;
}

-(void) todaytimeTableDetailsDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(todayTimetablelist:)])
    {
        [_LUDelegateCall todayTimetablelist:todaytimetable];
    }
}






#pragma mark -
#pragma mark TextBook
// Fetch TextBook details

-(BOOL)textBookList:(NSString *)URL
{
    __block BOOL returnBookList=NO;
    NSString *dataUrl  =  URL;
    NSURLSession *session  =  [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask  =  [session dataTaskWithURL:[NSURL URLWithString:dataUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                        {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                               textBookListArray  =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                returnBookList = YES;
                                                if (returnBookList==YES)
                                                {
                                                    [self textbookDetailsDelegate];
                                                }
                                                else
                                                {
                                                    
                                                }

                                                
                                            });
                                        }];
    [dataTask resume];

    return returnBookList;
}

// Delegate call for Textbook
-(void)textbookDetailsDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(textBookList:)])
    {
        [_LUDelegateCall textBookList:textBookListArray];
    }
}



#pragma mark
#pragma mark Messages
- (BOOL) messagesList:(NSString *)URL
{
    
    
    
    __block BOOL returnStudentDetails=NO;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          messageListDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          returnStudentDetails=YES;
                                          if (returnStudentDetails==YES)
                                          {
                                              [self messagesDelegate];
                                          }
                                          else
                                          {
                                              
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    return returnStudentDetails;
}

/*
 Delegate Call for Messages details fetch
 */
-(void)messagesDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(messagesList:)])
    {
        [_LUDelegateCall messagesList:messageListDict]; //pass  response to the selector method
    }
}


- (BOOL) messagesChatHistoryList:(NSDictionary *)body
{
    __block BOOL returnChatHistoryDetails=NO;
    
    NSURL *url = [NSURL URLWithString:MessagesFetchChatHistory_Link];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              messagesChatHistoryDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              [self messagesChatHistoryDelegate];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    
    
    
    return returnChatHistoryDetails;
}

/*
 Delegate Call for Messages details fetch
 */
-(void)messagesChatHistoryDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(messagesChatHistoryList:)])
    {
        [_LUDelegateCall messagesChatHistoryList:messagesChatHistoryDict ]; //pass  response to the selector method
    }
}


- (BOOL) messagesSendChatMessage: (NSDictionary *) Body
{
    __block BOOL returnSendChatMessageDetails=NO;
    NSURL *url = [NSURL URLWithString:MessagesSendChatMessage_Link];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:Body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              messagesSendMessageDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              [self messagesChatHistoryDelegate];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    
    
    return returnSendChatMessageDetails;
}
// messagesSendMessageResponse

-(void)messagesSendMessageDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(messagesSendMessageResponse:)])
    {
        [_LUDelegateCall messagesSendMessageResponse:messagesSendMessageDict ]; //pass  response to the selector method
    }
    // [_LUDelegateCall messagesSendMessageResponse:messagesSendMessageDict];
}
#pragma mark
#pragma mark Notification
- (BOOL) notificationList:(NSString *)URL
{
    
    __block BOOL returnNotificationDetails=NO;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          notificationDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          returnNotificationDetails=YES;
                                          if (returnNotificationDetails==YES)
                                          {
                                              [self notificationDelegate];
                                          }
                                          else
                                          {
                                              
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    
    
    
    return returnNotificationDetails;
}


// Delegate Call for Messages details fetch
-(void)notificationDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(notificationList:)])
    {
        [_LUDelegateCall notificationList:notificationDict ]; //pass  response to the selector method
    }
}


- (BOOL) notificationIsRead:(NSString *) Body

{
    __block BOOL returnNotificationIsReadDetails=NO;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",NotificationIsRead_Link,Body];
    
    
    NSURL *URL = [NSURL URLWithString:url];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"GET"];
    
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      
                                      {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              //                                                NSArray *json
                                              notificationReadDict =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              //                                                messagesListArray = [json objectAtIndex:0];
                                              returnNotificationIsReadDetails=YES;
                                              if (returnNotificationIsReadDetails==YES)
                                              {
                                                  [self notificationIsReadDelegate];
                                              }
                                              else
                                              {
                                                  //handle alert here
                                              }
                                          });
                                      }];
    [dataTask resume];
    
    return returnNotificationIsReadDetails;
    

    
    
//    __block BOOL returnNotificationIsReadDetails=NO
//    ;
//    NSURL *url = [NSURL URLWithString:NotificationIsRead_Link];
//    NSError *error;
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    
//    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
//    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:Body options:0 error:&error];
//    [request setHTTPBody:postData];
//    
//    
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
//                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//                                  {
//                                      dispatch_async(dispatch_get_main_queue(), ^{
//                                          if (!error)
//                                          {
//                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
//                                              NSLog(@"data = %@", data);
//                                              notificationReadDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                              [self notificationIsReadDelegate];
//                                              
//                                          }
//                                          else
//                                          {
//                                              NSLog(@"Error: %@", error.localizedDescription);
//                                          }
//                                      });
//                                  }];
//    [task resume];
//    
//    
//    
//    return returnNotificationIsReadDetails;
    
}

// Delegate Call for Messages details fetch
-(void)notificationIsReadDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(notificationIsReadList:)])
    {
        [_LUDelegateCall notificationIsReadList:notificationReadDict ]; //pass  response to the selector method
    }
}

#pragma mark
#pragma mark Email
- (BOOL) emailStudentTeacherList:(NSDictionary *)Body
{
    __block BOOL returnEmailStudentTeacherDetails=NO;
    
    NSURL *url = [NSURL URLWithString:EmailStudentTeacherList_Link];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:Body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              emailStudentTeacherListDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              [self emailStudentTeacherListDelegate];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    //    NSString *dataUrl  =  URL;
    //    NSURLSession *session  =  [NSURLSession sharedSession];
    //    NSURLSessionDataTask *dataTask  =  [session dataTaskWithURL:[NSURL URLWithString:dataUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    //                                        {
    //                                            dispatch_async(dispatch_get_main_queue(), ^{
    //                                                //                                                NSArray *json
    //                                                emailStudentTeacherListArray =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //                                                // messagesListArray = [json objectAtIndex:0];
    //                                                returnEmailStudentTeacherDetails=YES;
    //                                                if (returnEmailStudentTeacherDetails==YES)
    //                                                {
    //                                                    [self emailStudentTeacherListDelegate];
    //                                                }
    //                                                else
    //                                                {
    //                                                    //handle alert here
    //                                                }
    //                                            });
    //                                        }];
    //[dataTask resume];
    
    return returnEmailStudentTeacherDetails;
}

//Delegate Call for Email details fetch
-(void)emailStudentTeacherListDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(emailStudentTeacherList:)])
    {
        [_LUDelegateCall emailStudentTeacherList:emailStudentTeacherListDict ]; //pass  response to the selector method
    }
}

#pragma mark -
#pragma mark Notification
// Fetch Notification
- (BOOL) emailSavedMailToServerResponse:(NSDictionary *)Body
{
    __block BOOL returnEmailSavedMailToServerDetails=NO;
    NSURL *url = [NSURL URLWithString:EmailSaveMailToServer_Link];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:Body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              emailSavedMailToServerDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              [self emailSavedMailToServerDelegate];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    
    return returnEmailSavedMailToServerDetails;
}

// Delegate Call for Messages details fetch
- (void) emailSavedMailToServerDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(emailSavedMailToServerResponse:)])
    {
        [_LUDelegateCall emailSavedMailToServerResponse:emailStudentTeacherListDict ]; //pass  response to the selector method
    }
}
//For Library


#pragma mark
#pragma mark Library
-(BOOL) StudentLibrarayList:(NSString*)URL
{
    
    
    __block BOOL returnLibraryDetails=NO;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          //  NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding ]);
                                          //[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]);
                                          
                                          
                                          
                                          
                                          StudentLibraryListDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];//DEATAIL
                                          
                                          returnLibraryDetails=YES;
                                          if (returnLibraryDetails==YES)
                                          {
                                              [self LibraryDelegate];
                                          }
                                          else
                                          {
                                              
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    
    
    
    return returnLibraryDetails;
}

// Delegate Call for Library details fetch

-(void)LibraryDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(StudentLibrarayList:)])
    {
        [_LUDelegateCall StudentLibrarayList:StudentLibraryListDict ]; //pass  response to the selector method
    }
}

#pragma mark
#pragma mark FilterLibrary
-(BOOL) StudentLibraryFilterList:(NSString*)URL
{
    
    __block BOOL returnLibraryFilterDetails=NO;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          StudentLibraryFilterDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          
                                          returnLibraryFilterDetails=YES;
                                          if (returnLibraryFilterDetails==YES)
                                          {
                                              [self LibraryFilterDelegate];
                                          }
                                          else
                                          {
                                              
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    
    
    
    return returnLibraryFilterDetails;
}

// Delegate Call for LibraryFilter details fetch

-(void)LibraryFilterDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(StudentLibrarayList:)])
    {
        [_LUDelegateCall StudentLibrarayList:StudentLibraryFilterDict ]; //pass  response to the selector method
    }
}


#pragma mark
#pragma mark Attendance

-(BOOL)studentAttendance:(NSString *)url body:(NSDictionary *)body
{
    __block BOOL returnExamResonse=NO;
    // 1
    NSURL *URL = [NSURL URLWithString:url];
    NSError *error;
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (body.count!=0)
    {
        [request setHTTPMethod:@"POST"];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
        [request setHTTPBody:postData];
        
    }
    else
    {
        [request setHTTPMethod:@"GET"];
    }
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                              attendance = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] ;
                                              returnExamResonse=YES;
                                              if (returnExamResonse==YES)
                                              {
                                                  [self attendanceDelegate];
                                              }
                                              else
                                              {
                                                  //handle alert here
                                              }
                                              
                                              
                                              //                                              _response.text =[ NSString stringWithFormat:@"%li",(long)((NSHTTPURLResponse *)response).statusCode];
                                              //                                              _response.text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                              //                                              _serializedData.text =[ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                  }];
    [task resume];
    
    return returnExamResonse;

}


-(void)attendanceDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(studentAttendanceResponse:)])
    {
        [_LUDelegateCall studentAttendanceResponse:attendance ]; //pass  response to the selector method
    }
    
}

#pragma mark -
#pragma mark TimeTable
// Fetch TimeTable details
-(BOOL)teacherTimeTableList:(NSString *)URL
{
    __block BOOL returnTimetableList=NO;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          teacherTimeTableListArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          returnTimetableList=YES;
                                          if (returnTimetableList==YES)
                                          {
                                              [self teacherTimeTableDetailsDelegate];
                                          }
                                          else
                                          {
                                              
                                          }
                                      });
                                      
                                  }];
    [task resume];
    return returnTimetableList;
}

//Delegate call for TimeTable

-(void)teacherTimeTableDetailsDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(teachetTimeTableList:)])
    {
        [_LUDelegateCall teachetTimeTableList:teacherTimeTableListArray];
    }
}

-(void)populateTodayTable:(NSString *)url dayNo:(NSString *)dayNo
{
    NSError *error;
    // 1
    NSURL *localUrl = [NSURL URLWithString:url];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:localUrl];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *todayParameter = @{
                                     @"DayId":dayNo
                                     };
    
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:todayParameter options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           NSDictionary *todayTimeTableDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           todayTTArray = [todayTimeTableDict objectForKey:@"TodayData"];
                                                           [self todayTTDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];
}

-(void)todayTTDelegate
{
        if ([_LUDelegateCall respondsToSelector:@selector(displayTodayTimetable:)])
        {
            [_LUDelegateCall displayTodayTimetable:todayTTArray ]; //pass  response to the selector method
        }
}


-(BOOL)studentList:(NSString *)URL
{
    __block BOOL returnStudentDetails=NO;
    // 1
    NSURL *url = [NSURL URLWithString:URL];
    
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          NSDictionary *jsonDict;
                                          if (data!=nil) {
                                              jsonDict  =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          }
                                          else
                                          {
                                              //alert
                                          }
                                          if (jsonDict.count!=0)
                                          {
                                              studentListDict = [jsonDict objectForKey:@"Notes"];
                                              returnStudentDetails=YES;
                                              
                                          }
                                          else
                                          {
                                              //alert
                                          }
                                          if (returnStudentDetails==YES)
                                          {
                                              [self studentListDelegate];
                                          }
                                          else
                                          {
                                              //handle alert here
                                          }
                                          
                                          
                                          
                                      });
                                  }];
    [task resume];
    
    return returnStudentDetails;
}

//Delegate Call for assignment details fetch

-(void)studentListDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(assignmentList:)])
    {
        [_LUDelegateCall studentList:studentListDict ]; //pass  response to the selector method
    }
}

#pragma mark -
#pragma mark TeacherStudentList


-(BOOL)studentList:(NSString *)url body:(NSDictionary *)body
{
    __block BOOL returnStudentList=NO;

    NSError *error;
    // 1
    NSURL *urlStr = [NSURL URLWithString:url];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlStr];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //body (parameter) for getting student details
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:kNilOptions error:&error];
    [request setHTTPBody:data];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           dockStudentList = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           returnStudentList = YES;
                                                           [self studentDockListDelegate];
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnStudentList;

}

-(void)studentDockListDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(dockStudentList:)])
    {
        [_LUDelegateCall dockStudentList:dockStudentList]; //pass  response to the selector method
    }
}

#pragma mark -
#pragma mark TeacherAssignmentList

-(BOOL)LUTeacherAssignmentList:(NSString *)URL
{
    __block BOOL returnTeacherAssignmentList=NO;
    
    NSURL *url = [NSURL URLWithString:Listing_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           //NSLog(@"data = %@", data);
                                                           teacherAssignmentListDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",teacherAssignmentListDict);
                                                           returnTeacherAssignmentList=YES;
                                                           [self teacherAssignmentDelegate];
                                                           
                                                       }
                                                   });
                                    
                                  }];
    [task resume];
    
    
    
    return returnTeacherAssignmentList;
}

-(void)teacherAssignmentDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(teacherAssignmentList:)])
    {
        [_LUDelegateCall teacherAssignmentList:teacherAssignmentListDict]; //pass  response to the selector method
    }

}


-(BOOL)LUTeacherAssignmentEdit:(NSString *)URL body:(NSDictionary *)body
{
    __block BOOL returnTeacherAssignmentList=NO;
    NSURL *url = [NSURL URLWithString:URL];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //3
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    [request setHTTPBody:postData];
    
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           NSDictionary *editData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",editData);
                                                           
                                                           teacherAssignemntEdit = [editData objectForKey:@"Edit Assignment"];
                                                           
                                                           [self teacherAssignmentEditDelegate:teacherAssignemntEdit];
                                                           
                                                           NSLog(@"%@",[ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]);
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];

    
    
    return returnTeacherAssignmentList;
}

-(void) teacherAssignmentEditDelegate:(NSDictionary *)editAssignment
{
    if ([_LUDelegateCall respondsToSelector:@selector(editAssignment:)])
    {
        [_LUDelegateCall editAssignment:editAssignment]; //pass  response to the selector method
    }
}

-(BOOL)LUTeacherAssignmentSubmit:(NSString *)URL body:(NSDictionary *)body
{
    __block BOOL returnTeacherAssignmentList=NO;
    NSError *error;
    // 1
    NSURL *url = [NSURL URLWithString:URL];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           NSArray *onlineTest = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",onlineTest);
                                                         //  _messageText.text = @"submit tapped";
                                                         //  _responseLabel.text = [ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                                                           
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    
    [task resume];

    
    return returnTeacherAssignmentList;

}


-(BOOL)LUTeacherAssignmentDelete:(NSString *)URL body:(NSDictionary *)body
{
    __block BOOL returnTeacherAssignmentList=NO;
     NSError *error;
    NSURL *url = [NSURL URLWithString:URL];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //3
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           NSArray *onlineTest = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",onlineTest);
                                                           [self teacherAssignmentDeleteDelegate];
                                                           
                                                           NSLog(@"%@",[ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]);
                                                           // [self test:nil];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];


    
   return  returnTeacherAssignmentList;
}






-(void)teacherAssignmentDeleteDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(deleteAssignment:)])
    {
        [_LUDelegateCall deleteAssignment:teacherAssignmentDelete ]; //pass  response to the selector method
    }
    
    
}


-(BOOL)LUTeacherAssignmentPageType:(NSString *)URL
{
     __block BOOL returnTeacherAssignmentList=NO;
    
    // 1
    NSURL *url = [NSURL URLWithString:URL];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(),
                                                     ^{
                                                         if (!error)
                                                         {
                                                             NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                             //NSLog(@"data = %@", data);
                                                             teacherAssignmentPageType = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                             returnTeacherAssignmentList = YES;
                                                             [self teacherAssignmentPageTypeDelegate];
                                                         }
                                                         else
                                                         {
                                                             NSLog(@"Error: %@", error.localizedDescription);
                                                         }
                                                     });
                                  }];
    [task resume];


    return returnTeacherAssignmentList;
}

-(void)teacherAssignmentPageTypeDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(getPagetype:)])
    {
        [_LUDelegateCall getPagetype:teacherAssignmentPageType ]; //pass  response to the selector method
    }
    
    
}

-(BOOL)LUTeacherAssignmentGetDetails:(NSString *)URL body:(NSDictionary *)body
{
    __block BOOL returnTeacherAssignmentList=NO;
    NSError *error;
    NSURL *url = [NSURL URLWithString:URL];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //3
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           assisnmentListArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                         
                                                          
                                                           [self teacherGetAssignmentDetailsDelegate];
                                                           
                                                           NSLog(@"%@",[ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]]);
                                                           // [self test:nil];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];
    
    
    
    return  returnTeacherAssignmentList;
}






-(void)teacherGetAssignmentDetailsDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(fetchAssignmentDetails:)])
    {
        [_LUDelegateCall fetchAssignmentDetails:assisnmentListArray ]; //pass  response to the selector method
    }
    
    
}


#pragma mark
#pragma mark TeacherResource
- (BOOL) teacherResourceLibraryList: (NSString *)URL
{
    
    __block BOOL returnLibraryList=NO;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          teacherResourcelist =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          
                                         
                                              [self teacherResourceLibraryDelegate];
                                          
                                         
                                      });
                                      
                                  }];
    [task resume];
    
    return returnLibraryList;
}
-(void)teacherResourceLibraryDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(teacherResourcesLibraryList:)])
    {
        [_LUDelegateCall teacherResourcesLibraryList:teacherResourcelist ]; //pass  response to the selector method
    }

    
}

//post resource

#pragma mark TeacherStudentList


-(BOOL)postResource:(NSString *)url body:(NSDictionary *)body
{
    __block BOOL returnStudentList=NO;
    
    NSError *error;
    // 1
    NSURL *urlStr = [NSURL URLWithString:url];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlStr];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //body (parameter) for getting student details
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:kNilOptions error:&error];
    [request setHTTPBody:data];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           postResourceArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           returnStudentList = YES;
                                                           [self postResourceDelegate];
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnStudentList;
    
}

-(void)postResourceDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(postResource:)])
    {
        [_LUDelegateCall postResource:postResourceArray]; //pass  response to the selector method
    }
}





- (BOOL) emailTeacherList:(NSDictionary *)Body
{
    __block BOOL returnEmailStudentTeacherDetails=NO;
    
    NSURL *url = [NSURL URLWithString:EmailTeacherList_Link];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:Body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              emailStudentTeacherListDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              [self emailTeacherListDelegate];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    //    NSString *dataUrl  =  URL;
    //    NSURLSession *session  =  [NSURLSession sharedSession];
    //    NSURLSessionDataTask *dataTask  =  [session dataTaskWithURL:[NSURL URLWithString:dataUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    //                                        {
    //                                            dispatch_async(dispatch_get_main_queue(), ^{
    //                                                //                                                NSArray *json
    //                                                emailStudentTeacherListArray =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //                                                // messagesListArray = [json objectAtIndex:0];
    //                                                returnEmailStudentTeacherDetails=YES;
    //                                                if (returnEmailStudentTeacherDetails==YES)
    //                                                {
    //                                                    [self emailStudentTeacherListDelegate];
    //                                                }
    //                                                else
    //                                                {
    //                                                    //handle alert here
    //                                                }
    //                                            });
    //                                        }];
    //[dataTask resume];
    
    return returnEmailStudentTeacherDetails;
}

//Delegate Call for Email details fetch
-(void)emailTeacherListDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(emailTeacherList:)])
    {
        [_LUDelegateCall emailTeacherList:emailStudentTeacherListDict ]; //pass  response to the selector method
    }
}




- (BOOL) emailSavedMailToServerResponseTeacher:(NSDictionary *)Body
{
    __block BOOL returnEmailSavedMailToServerDetails=NO;
    NSURL *url = [NSURL URLWithString:EmailSaveMailToServerTeacher_Link];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:Body options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (!error)
                                          {
                                              NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                              NSLog(@"data = %@", data);
                                              emailSavedMailToServerDictTeacher=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              [self emailSavedMailToServerDelegateTeacher];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      });
                                      
                                  }];
    [task resume];
    
    
    return returnEmailSavedMailToServerDetails;
}

// Delegate Call for Messages details fetch
- (void) emailSavedMailToServerDelegateTeacher
{
    if ([_LUDelegateCall respondsToSelector:@selector(emailSavedMailToServerResponse:)])
    {
        [_LUDelegateCall emailSavedMailToServerResponse:emailStudentTeacherListDict ]; //pass  response to the selector method
    }
}
#pragma mark
#pragma TeacherNotification
-(BOOL)teacherNotificationAdd:(NSString *)url body:(NSDictionary *)body
{
    __block BOOL returnTeacherNotification=NO;
    
    NSError *error;
    // 1
    NSURL *urlStr = [NSURL URLWithString:url];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlStr];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //body (parameter) for getting student details
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:kNilOptions error:&error];
    [request setHTTPBody:data];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           //dockStudentList = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           returnTeacherNotification = YES;
                                                           [self teacherNotificationDelegate];
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnTeacherNotification;
 
}

-(void)teacherNotificationDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(teacherNotificationAdd:)])
    {
        [_LUDelegateCall teacherNotificationAdd:teacherNotifactionDict ]; //pass  response to the selector method
    }
}


#pragma mark
#pragma mark DBSync

-(BOOL) syncMyDb:(NSString *)url body:(NSDictionary *)body
{
    __block BOOL returnTeacherNotification=NO;
    
    NSError *error;
    // 1
    NSURL *urlStr = [NSURL URLWithString:url];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlStr];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //body (parameter) for getting student details
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:kNilOptions error:&error];
    [request setHTTPBody:data];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                     syncArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           //                                                           dockStudentList = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           returnTeacherNotification = YES;
                                                           [self dbSyncDelegate];
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnTeacherNotification;
    
    
    
}
//-(void) dbSync:(NSArray *)syncData;
-(void) dbSyncDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(dbSync:)])
    {
        [_LUDelegateCall dbSync:syncArr ]; //pass  response to the selector method
    }
}


#pragma mark
#pragma mark Notes Subject List
-(BOOL) notesSubjectList:(NSString *)url body:(NSDictionary *)body
{
    __block BOOL returnTeacherNotification=NO;
    
    NSError *error;
    // 1
    NSURL *urlStr = [NSURL URLWithString:url];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlStr];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //body (parameter) for getting student details
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:kNilOptions error:&error];
    [request setHTTPBody:data];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           syncArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           //                                                           dockStudentList = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           returnTeacherNotification = YES;
                                                           [self teacherNotesDelegateCall];
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnTeacherNotification;
    
    
    
}
-(void)teacherNotesDelegateCall
{
    if ([_LUDelegateCall respondsToSelector:@selector(notesSubjectList:)])
    {
        [_LUDelegateCall notesSubjectList:syncArr ]; //pass  response to the selector method
    }
}


-(BOOL) notesCreate:(NSString *)url body:(NSDictionary *)body
{
    __block BOOL returnTeacherNotification=NO;
    
    NSError *error;
    // 1
    NSURL *urlStr = [NSURL URLWithString:url];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlStr];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //body (parameter) for getting student details
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:kNilOptions error:&error];
    [request setHTTPBody:data];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           teacherResourcelist = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           //                                                           dockStudentList = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           returnTeacherNotification = YES;
                                                           [self createDelegateCall];
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnTeacherNotification;
    
}
-(void) createDelegateCall
{
    if ([_LUDelegateCall respondsToSelector:@selector(notesCreateResponse:)])
    {
        [_LUDelegateCall notesCreateResponse:teacherResourcelist ]; //pass  response to the selector method
    }
}
-(BOOL) notesCreateInput:(NSString *)url
{
    __block BOOL returnLibraryList=NO;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          teacherResourcelist =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          
                                          [self notesCreateDelegateCall];
                                         //
                                          
                                          
                                      });
                                      
                                  }];
    [task resume];
    
    return returnLibraryList;
}
-(void) notesCreateDelegateCall
{
    if ([_LUDelegateCall respondsToSelector:@selector(notesCreateInputResponse:)])
    {
        [_LUDelegateCall notesCreateInputResponse:teacherResourcelist ]; //pass  response to the selector method
    }
}


-(BOOL) getPageType:(NSString *)url
{
    __block BOOL returnLibraryList=NO;
    // 1
    NSURL *URL = [NSURL URLWithString:url];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"GET";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           //NSLog(@"data = %@", data);
                                                           pageTypeDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           [self pageTypeDelegateCall];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];

return returnLibraryList=NO;
}
-(void)pageTypeDelegateCall
{
    if ([_LUDelegateCall respondsToSelector:@selector(getPageresponse:)])
    {
        [_LUDelegateCall getPageresponse:pageTypeDictionary ]; //pass  response to the selector method
    }
}


#pragma mark -
#pragma mark TeacherOnlineTest

// //For Teacher OnlineTeSt listing

- (BOOL) teacherExamList:(NSString *)URL //For Teacher OnlineTeSt listing
{
    __block BOOL returnteacherExamList=NO;
    
    NSURL *url2 = [NSURL URLWithString:ExamListTeacher_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url2];
    request.HTTPMethod = @"GET";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           //NSLog(@"data = %@", data);
                                                           examlistDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",examlistDict);
                                                           //NSLog(@"%@",[onlineTest objectAtIndex:0]);
                                                           [self examListDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnteacherExamList;
}
-(void)examListDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(ExamList:)])
    {
        [_LUDelegateCall ExamList:examlistDict ]; //pass  response to the selector method
    }
}


//For creating exam

-(BOOL) teacherCreateExam: (NSString *)url body:(NSDictionary *)body //For creating exam
{
    __block BOOL returnteacherCreateExam=NO;
    NSError *error;
    // 1
    NSURL *URL = [NSURL URLWithString:CreateExamTeacher_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           createExamDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",createExamDict);
                                                           // _messageText.text = @"Add data Test";
                                                           
                                                           //  _responseLabel.text = [ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                                                           [self createExamDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];
    return returnteacherCreateExam;
}
-(void)createExamDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(createExam:)])
    {
        [_LUDelegateCall createExam:createExamDict ]; //pass  response to the selector method
    }
}


//For editing created exam

-(BOOL)teacherEditExam:(NSString *)url body:(NSDictionary *)body //For editing created exam
{
    __block BOOL returnEditExam=NO;
    
    NSError *error;
    // 1
    NSURL *URL = [NSURL URLWithString:EditExamteacher_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           editExamDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           // NSLog(@"JSONArray = %@",temp);
                                                           // _messageText.text = @"Add data Test";
                                                           
                                                           //  _responseLabel.text = [ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                                                           
                                                           [self editExamDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    
    [task resume];
    
    return returnEditExam;
}

-(void)editExamDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(createExam:)])
    {
        [_LUDelegateCall createExam:editExamDict ]; //pass  response to the selector method
    }
}

//For adding questions to created exam

-(BOOL)teacherAddQuestions:(NSString *)url body:(NSDictionary *)body //For adding questions to created exam
{
    __block BOOL returnAddQuestions=NO;
    NSError *error;
    // 1
    NSURL *URL = [NSURL URLWithString:AddQuestionsTeacher_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           getQuestionDetailsDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           [self addQuestionDetailsDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    
    [task resume];
    return returnAddQuestions;
    
}
-(void)addQuestionDetailsDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(addQuestionsForExam:)])
    {
        [_LUDelegateCall addQuestionsForExam:getQuestionDetailsDict ]; //pass  response to the selector method
    }
}


//For adding questions to question paper

- (BOOL) teacherAddQuestToQuestPaper:(NSString *)url body:(NSDictionary *)body //For adding questions to paper
{
    __block BOOL returnAddQuestionsToPaper=NO;
    NSError *error;
    // 1
    NSURL *URL = [NSURL URLWithString:AddQuestToQuestPaper_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           questToQuestPaperDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           // NSLog(@"JSONArray = %@",temp);
                                                           // _messageText.text = @"Add data Test";
                                                           
                                                           //  _responseLabel.text = [ NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                                                           
                                                           [self addQuestionToQuestPaperDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    
    [task resume];
    return returnAddQuestionsToPaper;
}

-(void)addQuestionToQuestPaperDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(addQuestionsToQuestPaper:)])
    {
        [_LUDelegateCall addQuestionsToQuestPaper:questToQuestPaperDict ]; //pass  response to the selector method
    }
}




//For Teacher Review OnlineTest listing

- (BOOL) teacherReviewExamList: (NSString *)URL //For Teacher Review OnlineTest listing
{
    __block BOOL returnteacherReviewExamList=NO;
    
    NSURL *url2 = [NSURL URLWithString:ExamListReview_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url2];
    request.HTTPMethod = @"GET";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           //NSLog(@"data = %@", data);
                                                           examReviewListDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",examReviewListDict);
                                                           //NSLog(@"%@",[onlineTest objectAtIndex:0]);
                                                           [self examReviewListDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnteacherReviewExamList;
    
}

-(void)examReviewListDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(ExamReviewList:)])
    {
        [_LUDelegateCall ExamReviewList:examReviewListDict ]; //pass  response to the selector method
    }
}

//For viewing student submitted created exam

- (BOOL) teacherStudentSubmittedExam:(NSString *)url body:(NSDictionary *)body //For viewing student submitted created exam
{
    __block BOOL returnteacherStudentSubmittedExamList=NO;
    NSError *error;
    
    NSURL *url2 = [NSURL URLWithString:ExamListStudentSubmitted_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url2];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           
                                                           examStudentSubmittedDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",examStudentSubmittedDict);
                                                           //NSLog(@"%@",[onlineTest objectAtIndex:0]);
                                                           [self examStudentSubmittedListDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnteacherStudentSubmittedExamList;
    
}

-(void)examStudentSubmittedListDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(ExamStudentSubmittedList:)])
    {
        [_LUDelegateCall ExamStudentSubmittedList:examStudentSubmittedDict ]; //pass  response to the selector method
    }
}


#pragma mark -
#pragma mark TeacherDrawing

- (BOOL) teacherDrawingCategoryListing:(NSString *)url body:(NSDictionary *)body
{
    __block BOOL returnteacherDrawingCategoryList=NO;
    NSError *error;
    
    NSURL *url2 = [NSURL URLWithString:DrawingCategoryList_link];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url2];
    request.HTTPMethod = @"POST";
    NSString *authStr = [NSString stringWithFormat:@"Bearer %@", token];
    [request setValue:authStr forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    [request setHTTPBody:postData];
    
    //3
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                           NSLog(@"data = %@", data);
                                                           NSLog(@"data = %@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                                                           
                                                           drawingCategoryDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           NSLog(@"JSONArray = %@",drawingCategoryDict);
                                                           //NSLog(@"%@",[onlineTest objectAtIndex:0]);
                                                           [self drawingTeacherCategoryListDelegate];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];
    
    return returnteacherDrawingCategoryList;
    
}

-(void)drawingTeacherCategoryListDelegate
{
    if ([_LUDelegateCall respondsToSelector:@selector(listDrawingCategory:)])
    {
        [_LUDelegateCall listDrawingCategory:drawingCategoryDict ]; //pass  response to the selector method
    }
}



@end
