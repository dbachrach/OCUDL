//
//  NSString+OCUDL.m
//  OCUDL
//
//  Created by Dustin Bachrach on 10/10/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import "NSString+OCUDL.h"
#import "OCUDLManager.h"
#import <objc/runtime.h>

@implementation NSString (OCUDL)

+ (id)ocudlStringWithUTF8String:(const char *)nullTerminatedCString
{
	
	// Call through original stringWithUTF8String: implementation
	NSString *str = [NSString ocudlStringWithUTF8String:nullTerminatedCString];
	
	NSString *ocudlUuid = @"9AD499E3-61B8-43AC-83A1-4B322E67C9B3";
	if ([str hasPrefix:ocudlUuid])
	{
		str = [str substringFromIndex:[ocudlUuid length]];
		
		NSMutableDictionary *prefixMapping = [OCUDLManager defaultManager].prefixMapping;
		NSArray *sortedPrefixMappingKeys = [[prefixMapping allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			return[@([obj1 length]) compare:@([obj2 length])];
		}];
		
		for (NSString *prefix in sortedPrefixMappingKeys) {
			if ([str hasPrefix:prefix]) {
				
				str = [str substringFromIndex:[prefix length]];
				
				id mapping = prefixMapping[prefix];
				
				// http://stackoverflow.com/questions/6536244/check-if-object-is-class-type
				if (class_isMetaClass(object_getClass(mapping))) {
					Class class = mapping;
					id<OCUDLClass> literalClass = [class alloc];
					return (id)[literalClass initWithLiteral:str prefix:prefix];
				}
				else if ([mapping isKindOfClass:NSClassFromString(@"NSBlock")]) {
					OCUDLBlock block = mapping;
					return block(str, prefix);
				}
			}
		}
		
		NSMutableDictionary *suffixMapping = [OCUDLManager defaultManager].suffixMapping;
		NSArray *sortedSuffixMappingKeys = [[suffixMapping allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			return[@([obj2 length]) compare:@([obj1 length])];
		}];
		
		for (NSString *suffix in sortedSuffixMappingKeys) {
			if ([str hasSuffix:suffix]) {
				
				str = [str substringToIndex:[str length] - [suffix length]];
				
				id mapping = suffixMapping[suffix];
				
				// http://stackoverflow.com/questions/6536244/check-if-object-is-class-type
				if (class_isMetaClass(object_getClass(mapping))) {
					Class class = mapping;
					id<OCUDLClass> literalClass = [class alloc];
					return (id)[literalClass initWithLiteral:str suffix:suffix];
				}
				else if ([mapping isKindOfClass:NSClassFromString(@"NSBlock")]) {
					OCUDLBlock block = mapping;
					return block(str, suffix);
				}
			}
		}
	}
	
	return str;
}

@end
