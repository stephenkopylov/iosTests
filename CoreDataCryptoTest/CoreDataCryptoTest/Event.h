//
//  Event.h
//  CoreDataCryptoTest
//
//  Created by rovaev on 14.04.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Person *)value;
- (void)removeRelationshipObject:(Person *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
