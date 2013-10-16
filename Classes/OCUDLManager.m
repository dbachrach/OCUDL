//
//  OCUDLManager.m
//  OCUDL
//
//  Created by Dustin Bachrach on 10/10/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import "OCUDLManager.h"

#import <objc/runtime.h>
#import <objc/message.h>

void Swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getClassMethod(c, orig);
    Method newMethod = class_getClassMethod(c, new);
	method_exchangeImplementations(origMethod, newMethod);
}


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

		Swizzle([NSString class],
			@selector(stringWithUTF8String:),
			@selector(ocudlStringWithUTF8String:));
	}
	return self;
}

- (void)registerPrefix:(NSString*)prefix forClass:(Class<OCUDLClass>)class
{
	self.prefixMapping[prefix] = class;
}

- (void)registerPrefix:(NSString*)prefix forBlock:(OCUDLBlock)block
{
	self.prefixMapping[prefix] = block;
}

- (void)registerSuffix:(NSString*)suffix forClass:(Class<OCUDLClass>)class
{
	self.suffixMapping[suffix] = class;
}

- (void)registerSuffix:(NSString*)suffix forBlock:(OCUDLBlock)block
{
	self.suffixMapping[suffix] = block;
}

@end
