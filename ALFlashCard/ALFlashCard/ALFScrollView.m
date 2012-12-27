//
//  ALFScrollView.m
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/21.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import "ALFScrollView.h"

@implementation ALFScrollView


- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		
		// we will recycle cards by removing them from the view and storing them here
		self.reusableViews = [[NSMutableSet alloc] init];
		
		self.visibileViews = [[NSMutableDictionary alloc] init];
		
		//this sets the system scrollview delegate to us
		self.delegate = self;
		
		//default to zero so we populate the visible cards on the first call to updateVisible
		self.visibleRange = NSMakeRange(0, 0);
	}
	
	return self;
}


- (id)dequeueReusableCard {
	id view = [self.reusableViews anyObject];
	if (view) {
		[self.reusableViews removeObject:view];
		
		[view prepareForReuse];
	}
	return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self updateVisibleCards];
}


- (NSInteger) currentIndex {
	CGFloat pageWidth = self.frame.size.width;
	NSInteger index = self.contentOffset.x/(int)pageWidth;
	
	return index;
}


- (void) updateVisibleCards {
	CGFloat pageWidth = self.frame.size.width;
	
	//get the right and left most visible views
	CGFloat leftViewOriginX = self.contentOffset.x  - pageWidth;
	CGFloat rightViewOriginX = self.contentOffset.x + pageWidth;
	
	//figure out what view's map to the left/right origin
	NSInteger firstView;
	NSInteger lastView;
	if (self.contentOffset.x > 0 ) {
		firstView = (int)leftViewOriginX/(int)pageWidth;
		lastView = (int)rightViewOriginX/(int)pageWidth;
		//		NSLog(@"left page: %d right page: %d", firstView, lastView);
	} else {
		firstView = 0;
		lastView = 2;
	}
	
	//add the views that are now in range that weren't before
	for (int current = firstView ; current <=lastView ; current++) {
		if (!NSLocationInRange(current, self.visibleRange)) {
			NSLog(@"adding: %d", current);
			
			//make sure we have a datasource before adding the view
			if (![self.dataSource respondsToSelector:@selector(scrollViewWillDisplayPageAtIndex:)]) {
				continue;
			}
			
			//we ended up past the last object
			if (current >= self.numPages) {
				continue;
			}
			
			UIView *view = [self.dataSource scrollViewWillDisplayPageAtIndex:current];
			
			//move the card to the correct position in the scrollview
			NSInteger pageWidth = self.frame.size.width;
			CGRect newFrame = view.frame;
			newFrame.origin.x = (current*pageWidth)+10;
			view.frame = newFrame;
			
			[self addSubview:view];
			
			[self.visibileViews setValue:view forKey:[NSString stringWithFormat:@"%d",current]];
		}
	}
	
	//remove views that are no longer visible
	//FIXME: shouldn't hardcode 3 here
	NSRange newRange = NSMakeRange(firstView, 3);
	for (int current = self.visibleRange.location ; current < self.visibleRange.location+self.visibleRange.length ; current++) {
		
		if (!NSLocationInRange(current, newRange)) {
			//don't try to remove pages that go beyond the end
			if (current >= self.numPages) {
				continue;
			}
			
			id view = [self.visibileViews objectForKey:[NSString stringWithFormat:@"%d", current]];
			
			//make sure we have a view object
			if ([view respondsToSelector:@selector(removeFromSuperview)]) {
				//add the page to the reuse queue
				[self.reusableViews addObject:view];
				
				[view removeFromSuperview];
			}
			
			[self.visibileViews removeObjectForKey:[NSString stringWithFormat:@"%d", current]];
		}
	}
	
	self.visibleRange = newRange;
}


- (void) setNumberofPages:(NSInteger)pages {
	[self setContentSize:CGSizeMake(self.frame.size.width * pages, self.frame.size.height)];
	self.numPages = pages;
}

@end