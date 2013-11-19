//
//  OCUDLManager.m
//  OCUDL
//
//  Created by Dustin Bachrach on 10/10/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import "OCUDLManager.h"

@interface OCUDLManager ()

/// All prefixes
@property (strong, nonatomic) NSMutableDictionary *prefixMapping;

/// All suffixes
@property (strong, nonatomic) NSMutableDictionary *suffixMapping;

@end


@implementation OCUDLManager

static dispatch_once_t s_pred;
static OCUDLManager *s_manager = nil;

+ (instancetype)defaultManager
{
	dispatch_once(&s_pred, ^{
		s_manager = [[OCUDLManager alloc] init];
	});
	
	return s_manager;
}

- (id)init
{
	if (self = [super init])
	{
		self.prefixMapping = [[NSMutableDictionary alloc] init];
		self.suffixMapping = [[NSMutableDictionary alloc] init];
	}
	return self;
}

#pragma mark - Registration

- (void)registerPrefix:(NSString*)prefix forClass:(Class<OCUDLClass>)class
{
    [self registerPrefix:prefix forBlock:^id(NSString *str, NSString *prefStr) {
        return (id)[[(Class)class alloc] initWithLiteral:str prefix:prefStr];
    }];
}

- (void)registerPrefix:(NSString*)prefix forBlock:(OCUDLBlock)block
{
	self.prefixMapping[prefix] = block;
}

- (void)registerSuffix:(NSString*)suffix forClass:(Class<OCUDLClass>)class
{
    [self registerSuffix:suffix forBlock:^id(NSString *str, NSString *suffStr) {
        return (id)[[(Class)class alloc] initWithLiteral:str suffix:suffStr];
    }];
}

- (void)registerSuffix:(NSString*)suffix forBlock:(OCUDLBlock)block
{
	self.suffixMapping[suffix] = block;
}

#pragma mark - Object Emitter

- (id)objectForLiteralString:(NSString *)str {
    NSMutableDictionary *prefixMapping = self.prefixMapping;
    NSArray *sortedPrefixMappingKeys = [[prefixMapping allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return[@([obj1 length]) compare:@([obj2 length])];
    }];
    
    for (NSString *prefix in sortedPrefixMappingKeys) {
        if ([str hasPrefix:prefix]) {
            
            str = [str substringFromIndex:[prefix length]];
            
            OCUDLBlock block = prefixMapping[prefix];
            return block(str, prefix);
        }
    }
    
    NSMutableDictionary *suffixMapping = self.suffixMapping;
    NSArray *sortedSuffixMappingKeys = [[suffixMapping allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return[@([obj2 length]) compare:@([obj1 length])];
    }];
    
    for (NSString *suffix in sortedSuffixMappingKeys) {
        if ([str hasSuffix:suffix]) {
            
            str = [str substringToIndex:[str length] - [suffix length]];
            
            OCUDLBlock block = suffixMapping[suffix];
            return block(str, suffix);
        }
    }
    
    return nil;
}

@end
