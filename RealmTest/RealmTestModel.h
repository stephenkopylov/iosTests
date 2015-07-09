//
//  RealmTestModel.h
//  RealmTest
//
//  Created by Admin on 09.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmTestModel : RLMObject
@property NSString *name;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<RealmTestModel>
RLM_ARRAY_TYPE(RealmTestModel)
