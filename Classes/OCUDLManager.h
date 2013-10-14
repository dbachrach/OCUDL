//
//  OCUDLManager.h
//  OCUDL
//
//  Created by Dustin Bachrach on 10/10/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef id (^OCUDLBlock)(NSString*, NSString*);


@protocol OCUDLClass <NSObject>

@optional
- (id)initWithLiteral:(NSString*)literal prefix:(NSString*)prefix;
- (id)initWithLiteral:(NSString*)literal suffix:(NSString*)suffix;

@end


@interface OCUDLManager : NSObject

+ (instancetype)defaultManager;

// TODO: Only expose this to nsstring+ocudl
@property (strong, nonatomic) NSMutableDictionary *prefixMapping;
@property (strong, nonatomic) NSMutableDictionary *suffixMapping;

- (void)registerPrefix:(NSString*)prefix forClass:(Class<OCUDLClass>)class;
- (void)registerPrefix:(NSString*)prefix forBlock:(OCUDLBlock)block;
- (void)registerSuffix:(NSString*)suffix forClass:(Class<OCUDLClass>)class;
- (void)registerSuffix:(NSString*)suffix forBlock:(OCUDLBlock)block;

@end

