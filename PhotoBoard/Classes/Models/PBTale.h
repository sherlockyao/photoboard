//
//  PBTale.h
//  
//
//  Created by Sherlock Yao on 6/20/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface PBTale : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSSet *scenes;
@end

@interface PBTale (CoreDataGeneratedAccessors)

- (void)addScenesObject:(NSManagedObject *)value;
- (void)removeScenesObject:(NSManagedObject *)value;
- (void)addScenes:(NSSet *)values;
- (void)removeScenes:(NSSet *)values;

@end
