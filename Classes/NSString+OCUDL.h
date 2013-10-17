//
//  NSString+OCUDL.h
//  OCUDL
//
//  Created by Dustin Bachrach on 10/10/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * NSString category to support user defined literals.
 */
@interface NSString (OCUDL)

/**
 * Implementation that will be swizzled with stringWithUTF8String:.
 * Will either construct the literal or fallback on stringWithUTF8String,
 * if the string does not match a registered user defined literal prefix or suffix.
 * @param nullTerminatedCString The string
 */
+ (instancetype)ocudlStringWithUTF8String:(const char *)nullTerminatedCString;

@end
