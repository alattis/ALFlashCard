//
//  ALFPlistLoader.m
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/23.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import "ALFPlistLoader.h"

@implementation ALFPlistLoader

- (id) initWithPlistPath:(NSString *)path {
	if ((self = [super init])) {
		
		self.terms = [[NSDictionary alloc] initWithContentsOfFile:path];
		
		//create an array with a sorted list of acronyms
		self.sortedTerms = [self.terms keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			//get the acronym portion of the array's and store them as strings
			NSString *string1 = [obj1 objectAtIndex:0];
			NSString *string2 = [obj2 objectAtIndex:0];
			
			return [string1 caseInsensitiveCompare:string2];
		}];
	}
	
	return self;
}

@end
