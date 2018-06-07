//
//  LUNotesMainDataManager.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface LUNotesMainDataManager : NSObject
{
    NSString *DataBasePath;
}
+(LUNotesMainDataManager*) getSharedInstance;
-(BOOL) createDB: (NSString*) dbName;
-(BOOL) save: (NSString*) dbName pageno:(NSString*) pageNo pageimage:(NSData *) pageImage;
-(BOOL) update: (NSString*) dbName pageno:(NSString*) pageNo pageimage:(NSData *) pageImage;
-(NSArray*) viewAllArt: (NSString*) dbName;

@end
