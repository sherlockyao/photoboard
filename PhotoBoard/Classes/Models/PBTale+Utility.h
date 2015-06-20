//
//  PBTale+Utility.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTale.h"
#import "PBTaleInfo.h"

@interface PBTale (Utility)

+ (NSArray *)taleInfosForTales:(NSArray *)tales;

- (PBTaleInfo *)taleInfo;

@end
