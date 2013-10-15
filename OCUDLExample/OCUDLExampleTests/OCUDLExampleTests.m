//
//  OCUDLExampleTests.m
//  OCUDLExampleTests
//
//  Created by DUSTIN on 10/14/13.
//  Copyright (c) 2013 Dustin Bachrach. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCUDL/OCUDL.h>
#import <OCUDL/OCUDLBuiltins.h>

@interface OCUDLExampleTests : XCTestCase

@end

@implementation OCUDLExampleTests

- (void)setUp
{
    [super setUp];
	[OCUDLBuiltins use];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNSNull
{
	XCTAssertEqualObjects($(null), [NSNull null], @"");
}

- (void)testUIColor
{
	XCTAssertEqualObjects($(#FF0000),
						  [UIColor colorWithRed:255.0
										  green:0
										   blue:0
										  alpha:1.0],
						  @"Red is equal");

	XCTAssertEqualObjects($(#00FF00),
						  [UIColor colorWithRed:0
										  green:255.0
										   blue:0
										  alpha:1.0],
						  @"Green is equal");
	
	XCTAssertEqualObjects($(#0000FF),
						  [UIColor colorWithRed:0
										  green:0
										   blue:255.0
										  alpha:1.0],
						  @"Blue is equal");
	
	XCTAssertEqualObjects($(#FFF),
						  [UIColor colorWithRed:255.0
										  green:255.0
										   blue:255.0
										  alpha:1.0],
						  @"White is equal");
	
	XCTAssertEqualObjects($(#yellow),
						  [UIColor yellowColor],
						  @"Yellow is equal");
}

- (void)testNSUUID
{
	NSUUID *uuid = $(68753A44-4D6F-1226-9C60-0050E4C00067uuid);
	XCTAssertEqualObjects(uuid.UUIDString,
						  @"68753A44-4D6F-1226-9C60-0050E4C00067",
						  @"68753A44-4D6F-1226-9C60-0050E4C00067 is equal");
}

- (void)testNSURL
{
	NSURL *url = $(http:apple.com);
	XCTAssertEqualObjects([url description],
						  @"http://apple.com",
						  @"http://apple.com is equal");
	NSURL *url2 = $(https:apple.com);
	XCTAssertEqualObjects([url2 description],
						  @"https://apple.com",
						  @"https://apple.com is equal");
}

@end
