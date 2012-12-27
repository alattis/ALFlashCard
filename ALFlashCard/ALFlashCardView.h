//
//  ALFlashCardView.h
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/21.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import <UIKit/UIKit.h>

///This view is the base for all of the informational flash cards
@interface ALFlashCardView : UIView

///@name Tasks

///clear out the view so it's a blank slate ready to be re-used
- (void) prepareForReuse;


///@name Properties

///the large center image for visual cards
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;

///the smaller secondary image for visual cards
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;

///main uiview object
@property (weak, nonatomic) IBOutlet UIView *view;

///the text blob if this card is textual
@property (weak, nonatomic) IBOutlet UITextView *textView;

///button that initiates a flip to the back of the card
@property (weak, nonatomic) IBOutlet UIButton *flipButton;

@end
