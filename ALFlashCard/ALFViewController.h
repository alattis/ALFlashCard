//
//  ALFViewController.h
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/21.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALFScrollView.h"
#import "ALFCards.h"
#import "ALFlashCardView.h"

///class that displays the rank flashcards, and controls the user interaction with them
@interface ALFViewController : UIViewController <ALFScrollViewDataSource>

///@name Tasks
/**method to add a flip button to the bottom of the card
 * @param card the card to add the button to
 */
- (void)addFlipButtonToCard: (ALFlashCardView *)card;

/**action method that gets called when the flip button is pressed
 * @param sender the object that sent the message
 * @return ibaction nil
 */
- (void)flipButtonPressed:(id)sender;


///@name Properties

///outlet scrollview that holds the flash cards
@property (nonatomic, strong) ALFScrollView* scrollView;

///object storing all the ranks
@property (nonatomic, strong) ALFCards *cards;

///single object for the back card, only one is ever active at a time, so it just moves around as needed
@property (strong, nonatomic) ALFlashCardView *cardBack;

///indicates if the currently visible card is the front or back
@property (nonatomic) BOOL showingFront;

@end
