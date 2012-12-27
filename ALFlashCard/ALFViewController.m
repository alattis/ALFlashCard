//
//  ALFViewController.m
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/21.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import "ALFViewController.h"

@interface ALFViewController ()

@end

@implementation ALFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.cards = [[ALFCards alloc] init];

	self.scrollView = [[ALFScrollView alloc] initWithFrame:self.view.frame];
	//set ourself as the datasource delegate
	self.scrollView.dataSource = self;
	
	[self.scrollView setNumberofPages:[self.cards count]];
	[self.scrollView setPagingEnabled:YES];
	
	[self.view addSubview:self.scrollView];
	
	[self.scrollView updateVisibleCards];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	if ([self isViewLoaded] && self.view.window == nil) {
		self.scrollView = nil;
		self.cards = nil;
		self.cardBack = nil;
	}
}


#pragma mark - scrollview data source methods

- (UIView *) scrollViewWillDisplayPageAtIndex:(NSInteger)pageIndex {
	//try and get a page from the scrollview queue
	ALFlashCardView *cardView = [self.scrollView dequeueReusableCard];
	if (cardView == nil) {
		cardView =  [[ALFlashCardView alloc] initWithFrame:CGRectMake(10, 10, 320, 400)];
		
		[self addFlipButtonToCard:cardView];
	}
	
	//FIXME: make this a real object instead of an array
	NSArray *card = [self.cards objectAtIndex:pageIndex];
	
	cardView.textView.alpha = 1.0f;
	cardView.textView.text = [card objectAtIndex:0];
	//cardView.largeImageView.image = [UIImage imageNamed:[card objectAtIndex:3]];
	//cardView.smallImageView.image = [UIImage imageNamed:[card objectAtIndex:2]];
	cardView.smallImageView.alpha = 0.0;
	cardView.largeImageView.alpha = 0.0;
	
	self.showingFront = YES;
	
	return cardView;
}



#pragma mark - card ui methods

- (void)addFlipButtonToCard: (ALFlashCardView *)card {
	[card.flipButton addTarget:self action:@selector(flipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)flipButtonPressed:(id)sender {
	if (self.cardBack == nil) {
		NSLog(@"back alloc");
		self.cardBack = [[ALFlashCardView alloc] initWithFrame:CGRectMake(10, 10, 320, 400)];
		self.cardBack.largeImageView.alpha = 0.0f;
		self.cardBack.smallImageView.alpha = 0.0f;
		[self addFlipButtonToCard:self.cardBack];
	}
	
	
	if (self.showingFront) {
		//switch to the back of the card view
		
		//figure out the currently displayed page and move the back card to that scrollview area
		NSInteger currentIndex = [self.scrollView currentIndex];
		NSInteger pageWidth = self.scrollView.frame.size.width;
		CGRect backFrame = self.cardBack.frame;
		backFrame.origin.x = (currentIndex*pageWidth)+10;
		self.cardBack.frame = backFrame;
		
		//FIXME: make this a real object instead of an array
		NSArray *card = [self.cards objectAtIndex:currentIndex];
		
		self.cardBack.textView.text = [card objectAtIndex:1];
		
		[UIView transitionWithView:self.scrollView duration:.75 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
			[self.scrollView addSubview:self.cardBack];
		} completion:nil];
		self.showingFront = NO;
	} else {
		//remove the back card. which pushes the front card back to the foreground
		[UIView transitionWithView:self.scrollView duration:.75 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
			[self.cardBack removeFromSuperview];
		} completion:nil];
		self.showingFront = YES;
	}
}


@end
