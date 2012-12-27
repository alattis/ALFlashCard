//
//  ALFPlistLoader.h
//  ALFlashCard
//
//  Created by andrew lattis on 12/12/23.
//  Copyright (c) 2012 andrew lattis. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class loads the list of terms and definitions from a plist file and stores them as a dictionary for reference. and an alphabetically sorted nsarray
 
 The plist is expected to be in the following format, the dictionary key value must be unique, and gets used for any dictionary key searches, its best if it matches the term.
 The first string in the array in the term and the sort field, the second string in the array is the defintion
 
 
 <dict>
 <key>Dictionary Key Value</key>
 <array>
 <string>Acronym or Term</string>
 <string>Definition</string>
 </array>
 </dict>
 */

@interface ALFPlistLoader : NSObject

/** @name Public Methods */

/** Initialize the class with a plist file
 * @return Initialized object with the plist file loaded
 * @param path NSString path for the plist file to load
 */
- (id) initWithPlistPath:(NSString *)path;




/** @name Properties */

///Dictionary of arrays that contains all the terms and definitions
@property (strong, nonatomic) NSDictionary *terms;

///Sorted NSArray that contains only the terms sorted alphabetically.
@property (strong, nonatomic) NSArray *sortedTerms;


@end
