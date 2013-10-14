//
//  NSString+OCUDL.h
//  OCUDL
//
//  Created by Dustin Bachrach on 10/10/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OCUDL)

+ (instancetype)ocudlStringWithUTF8String:(const char *)nullTerminatedCString;

@end
