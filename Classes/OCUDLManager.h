//
//  OCUDLManager.h
//  OCUDL
//
//  Created by Dustin Bachrach on 10/10/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Invoked when a user defined literal should be created.
 * The first parameter is the literal.
 * The second parameter is the prefix/suffix.
 */
typedef id (^OCUDLBlock)(NSString*, NSString*);


/**
 * A protocol for any class, which can be constructed via a user defined literal.
 */
@protocol OCUDLClass <NSObject>

@optional

/**
 * Creates an instance of the class from a literal.
 * @param literal The literal. For example, for #FFF, FFF is the literal.
 * @param prefix The prefix. For example, for #FFF, # is the prefix.
 */
- (id)initWithLiteral:(NSString*)literal prefix:(NSString*)prefix;

/**
 * Creates an instance of the class from a literal.
 * @param literal The literal. For example, for 25ul, 25 is the literal.
 * @param suffix The suffix. For example, for 25ul, ul is the suffix.
 */
- (id)initWithLiteral:(NSString*)literal suffix:(NSString*)suffix;

@end


/**
 * Manages all user defined literals.
 * User defined literals must be registered to the defaultManager.
 */
@interface OCUDLManager : NSObject

/**
 * Gets the default manager.
 * All registrations should occur on this manager.
 */
+ (instancetype)defaultManager;

/**
 * Registers a user defined literal for a prefix.
 * When a literal is found that matches the prefix, the class is constructed
 * and receives the -initWithLiteral:prefix: message.
 * @param prefix The prefix.
 * @param class The class to construct when a literal is found.
 */
- (void)registerPrefix:(NSString*)prefix forClass:(Class<OCUDLClass>)class;

/**
 * Registers a user defined literal for a prefix.
 * When a literal is found that matches the prefix, the block is executed.
 * @param prefix The prefix.
 * @param block The block to execute when a literal is found.
 */
- (void)registerPrefix:(NSString*)prefix forBlock:(OCUDLBlock)block;

/**
 * Registers a user defined literal for a suffix.
 * When a literal is found that matches the suffix, the class is constructed
 * and receives the -initWithLiteral:suffix: message.
 * @param suffix The suffix.
 * @param class The class to construct when a literal is found.
 */
- (void)registerSuffix:(NSString*)suffix forClass:(Class<OCUDLClass>)class;

/**
 * Registers a user defined literal for a suffix.
 * When a literal is found that matches the suffix, the block is executed.
 * @param suffix The suffix.
 * @param block The block to execute when a literal is found.
 */
- (void)registerSuffix:(NSString*)suffix forBlock:(OCUDLBlock)block;

/**
 * Creates an object from a literal string.
 * If a literal is not found, returns nil.
 * @param str The string literal.
 * @return The created object based on the literal.
 */
- (id)objectForLiteralString:(NSString *)str;

@end

