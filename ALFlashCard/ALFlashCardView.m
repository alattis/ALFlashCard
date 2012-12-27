//
//  ALFlashCardView.m
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/21.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import "ALFlashCardView.h"

#import <QuartzCore/QuartzCore.h>


@implementation ALFlashCardView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		[[NSBundle mainBundle] loadNibNamed:@"ALFlashCardView" owner:self options:nil];
		[self addSubview:self.view];
		
		//round the corner and add the shadow
		self.view.layer.cornerRadius = 5.0f;
		self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
		self.view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
		self.view.layer.shadowOpacity = .6f;
		self.view.layer.shadowRadius = 3.0f;
		
		UIBezierPath *containerViewPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
		self.view.layer.shadowPath = containerViewPath.CGPath;
	}
	
	return self;
}


- (void) awakeFromNib
{
    [super awakeFromNib];
	
    [[NSBundle mainBundle] loadNibNamed:@"ALFlashCardView" owner:self options:nil];
    [self addSubview:self.view];
}


- (void) prepareForReuse {
	//reset the state of the main objects
	self.largeImageView.alpha = 0.0f;
	self.largeImageView.image = nil;
	
	self.smallImageView.alpha = 0.0f;
	self.smallImageView.image = nil;
	
	self.textView.alpha = 0.0f;
	self.textView.text = nil;
	
	
	//remove anything from the view that isn't from ib
	NSArray *nibViews = @[self.largeImageView, self.smallImageView, self.view, self.textView, self.flipButton];
	for (UIView *subview in self.subviews) {
		//search the array of known objects and remove anything else from view
		if (![nibViews containsObject:subview]) {
			NSLog(@"unknown subview found: %@", subview);
			[subview removeFromSuperview];
		} /*else {
		   NSLog(@"known view found: %@", subview);
		   }*/
	}
}

@end
