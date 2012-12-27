//
//  ALFScrollView.h
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/21.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import <UIKit/UIKit.h>

///delegate protocol for the scroll view datasource
@protocol ALFScrollViewDataSource <NSObject>
/**delegate method to get a view to display for the front of the card
 * @param pageIndex the index of the page being created
 * @return uiview object to display on this page
 */
- (UIView *) scrollViewWillDisplayPageAtIndex:(NSInteger)pageIndex;

@end

///class to handle a dynamically loading horizontal scroll view. similar to UICollectionView but compatable with ios5
@interface ALFScrollView : UIScrollView <UIScrollViewDelegate>

/**method that gets called by the datasource delegate to get a card that is currently in memory but not visible
 * @return if a card is in memory but not visible it is returned, otherwise nil
 */
- (id)dequeueReusableCard;

///method that controls adding/removing cards from the view, cards thats are removed get added to the reusable queue
- (void) updateVisibleCards;

/**method called by the delegate to resize the scrollview and set the number of visible pages
 * @param pages the number of pages that can be displayed
 */
- (void) setNumberofPages:(NSInteger)pages;

/**method to get the index of the card that is currently visible
 * @return integer value of the visible card
 */
- (NSInteger) currentIndex;


///@name Properties

///queue that stores reusable views that are in memory but not visible
@property (nonatomic, strong) NSMutableSet *reusableViews;

///dictionary that stores the views that are currently visible, addressed by their index value
@property (nonatomic, strong) NSMutableDictionary *visibileViews;

///range to store the view index's that are currently loaded in the scrollview
@property (nonatomic) NSRange visibleRange;

///number of pages the datasource has avaiilable
@property (nonatomic) NSInteger numPages;

///property for the data source delegate
@property (nonatomic, weak) id <ALFScrollViewDataSource> dataSource;

@end