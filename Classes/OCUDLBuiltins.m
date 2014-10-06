//
//  OCUDLBuiltins.m
//  OCUDL
//
//  Created by Dustin Bachrach on 10/15/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import "OCUDLBuiltins.h"
#import "OCUDL.h"

@interface OCUDLBuiltins ()

+ (void)registerNSNull;
+ (void)registerNSURL;
+ (void)registerNSUUID;
+ (void)registerUIColor;
+ (void)registerUIImage;
+ (void)registerUINib;
+ (void)registerUIStoryboard;

@end

@implementation OCUDLBuiltins

+ (void)registerNSNull
{
	[[OCUDLManager defaultManager] registerPrefix:@"null"
										 forBlock:^id(NSString *literal, NSString *prefix) {
											 return [NSNull null];
										 }];
}

+ (void)registerNSURL
{
	OCUDLBlock urlBlock = ^id(NSString *literal, NSString *prefix) {
		return [NSURL URLWithString:[NSString stringWithFormat:@"%@//%@", prefix, literal]];
	};
	[[OCUDLManager defaultManager] registerPrefix:@"http:" forBlock:urlBlock];
	[[OCUDLManager defaultManager] registerPrefix:@"https:" forBlock:urlBlock];
}

+ (void)registerNSUUID
{
	[[OCUDLManager defaultManager] registerSuffix:@"uuid"
										 forBlock:^id(NSString *literal, NSString *prefix) {
											 return [[NSUUID alloc] initWithUUIDString:literal];
										 }];
}

+ (void)registerUIColor
{
	[[OCUDLManager defaultManager] registerPrefix:@"#"
										 forBlock:^id(NSString *literal, NSString *prefix) {
											 unsigned int value = 0;
											 if ([[NSScanner scannerWithString:literal] scanHexInt:&value])
											 {
												 if (literal.length == 6)
												 {
													 return [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16)) / 255.0
																			green:((float)((value & 0x00FF00) >> 8)) / 255.0
																			 blue:((float)(value & 0x0000FF)) / 255.0
																			alpha:1.0];
												 }
												 else if (literal.length == 3)
												 {
													 return [UIColor colorWithRed:((float)((value & 0xF00) >> 8)) / 15.0
																			green:((float)((value & 0x0F0) >> 4)) / 15.0
																			 blue:((float)(value & 0x00F)) / 15.0
																			alpha:1.0];
												 }
											 }
                                             if ([literal caseInsensitiveCompare:@"black"] == NSOrderedSame)
                                             {
                                                 return [UIColor blackColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"darkGray"] == NSOrderedSame)
                                             {
                                                 return [UIColor darkGrayColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"lightGray"] == NSOrderedSame)
                                             {
                                                 return [UIColor lightGrayColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"white"] == NSOrderedSame)
                                             {
                                                 return [UIColor whiteColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"gray"] == NSOrderedSame)
                                             {
                                                 return [UIColor grayColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"red"] == NSOrderedSame)
                                             {
                                                 return [UIColor redColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"green"] == NSOrderedSame)
                                             {
                                                 return [UIColor greenColor];
                                             }
                                             
                                             else if ([literal caseInsensitiveCompare:@"blue"] == NSOrderedSame)
                                             {
                                                 return [UIColor blueColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"cyan"] == NSOrderedSame)
                                             {
                                                 return [UIColor cyanColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"yellow"] == NSOrderedSame)
                                             {
                                                 return [UIColor yellowColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"magenta"] == NSOrderedSame)
                                             {
                                                 return [UIColor magentaColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"orange"] == NSOrderedSame)
                                             {
                                                 return [UIColor orangeColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"purple"] == NSOrderedSame)
                                             {
                                                 return [UIColor purpleColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"brown"] == NSOrderedSame)
                                             {
                                                 return [UIColor brownColor];
                                             }
                                             else if ([literal caseInsensitiveCompare:@"clear"] == NSOrderedSame)
                                             {
                                                 return [UIColor clearColor];
                                             }
											 return nil;
										 }];

}

+ (void)registerUIImage
{
	[[OCUDLManager defaultManager] registerSuffix:@".img"
										 forBlock:^id(NSString *literal, NSString *prefix) {
											 return [UIImage imageNamed:literal];
										 }];
}

+ (void)registerUINib
{
	[[OCUDLManager defaultManager] registerSuffix:@".xib"
										 forBlock:^id(NSString *literal, NSString *prefix) {
											 return [UINib nibWithNibName:literal bundle:nil];
										 }];
}


+ (void)registerUIStoryboard
{
	[[OCUDLManager defaultManager] registerSuffix:@".storyboard"
										 forBlock:^id(NSString *literal, NSString *prefix) {
											 return [UIStoryboard storyboardWithName:literal bundle:nil];
										 }];
}

static dispatch_once_t s_pred;

+ (void)use
{
	dispatch_once(&s_pred, ^{
		[OCUDLBuiltins registerNSNull];
		[OCUDLBuiltins registerNSURL];
		[OCUDLBuiltins registerNSUUID];
		[OCUDLBuiltins registerUIColor];
		[OCUDLBuiltins registerUIImage];
		[OCUDLBuiltins registerUINib];
		[OCUDLBuiltins registerUIStoryboard];
	});
}

@end
