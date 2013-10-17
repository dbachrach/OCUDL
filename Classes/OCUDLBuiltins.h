//
//  OCUDLBuiltins.h
//  OCUDL
//
//  Created by Dustin Bachrach on 10/15/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Built-in user defined literals
 */
@interface OCUDLBuiltins : NSObject

/**
 * Enable all built-in user defined literals.
 * Must call this method before any user defined literal is created.
 */
+ (void)use;

@end
