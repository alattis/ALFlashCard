//
//  ALFCard.h
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/23.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import "ALFPlistLoader.h"

/** This object stores the list of flash cards, in order. it also contains descriptions and image names for the cards. this is stored as a dictionary of array's loaded from a plist
 */
@interface ALFCards : ALFPlistLoader


/** @name Tasks */

/** Returns the number of terms
 * @return NSInteger value for the number of terms
 */
- (NSInteger) count;

/** Returns a NSArray with the term at index 0, and the definition at index 1
 * @return NSArray array containing the term and defintion
 * @param index NSInteger object index to return
 */
- (NSArray *) objectAtIndex:(NSInteger)index;

/** Returns a NSArray with the term at index 0, and the definition at index 1
 * @return NSArray array containing the term and defintion
 * @param key NSString value of the term to return
 */
- (NSArray *) objectForKey:(NSString *)key;

@end
