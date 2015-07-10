//
//  RealmTestModel.h
//  RealmTest
//
//  Created by Admin on 09.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Realm/Realm.h>
RLM_ARRAY_TYPE(RealmTestModelDog)
RLM_ARRAY_TYPE(RealmTestModel)

@interface RealmTestModel : RLMObject
    @property NSString *firstName;
    @property NSString *secondName;
    @property NSDate *date;
    @property RLMArray<RealmTestModelDog> *dogs;
@end

@interface RealmTestModelDog : RLMObject
    @property NSString *name;
    @property (readonly) NSArray *owners;
@end


