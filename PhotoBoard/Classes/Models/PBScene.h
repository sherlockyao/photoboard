//
//  PBScene.h
//  
//
//  Created by Sherlock Yao on 6/20/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PBTale;

@interface PBScene : NSManagedObject

@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * assetURL;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) PBTale *tale;

@end
