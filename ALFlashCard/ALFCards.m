//
//  ALFCard.m
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/23.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import "ALFCards.h"

@implementation ALFCards

- (id) init {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"plist"];
	
	if ((self = [super initWithPlistPath:path])) {
	}
	
	return self;
}



- (NSString *) description {
	//just return a list of the acronyms with no definitions
	return [self.sortedTerms description];
}


- (NSInteger) count {
	return [self.terms count];
}


- (NSArray *) objectAtIndex:(NSInteger)index {
	NSString *key = [self.sortedTerms objectAtIndex:index];
	NSArray *keyValue = [self.terms objectForKey:key];
	
	return keyValue;
}


- (NSArray *) objectForKey:(NSString *)key {
	NSArray *keyValue = [self.terms objectForKey:key];
	
	return keyValue;
}


@end
