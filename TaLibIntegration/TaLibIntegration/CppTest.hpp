//
//  CppTest.hpp
//  TaLibIntegration
//
//  Created by Stephen Kopylov - Home on 03/09/16.
//  Copyright © 2016 test. All rights reserved.
//

#ifndef CppTest_hpp
#define CppTest_hpp

#include <stdio.h>
#include "ta_func.h"

class CppTest {
public:
    CppTest(){
        TA_Real    closePrice[400];
        TA_Real    out[400];
        TA_Integer outBeg;
        TA_Integer outNbElement;
        /* ... initialize your closing price here... */
        
        for (int i = 0; i < 400-1; i++) {
            closePrice[i] = 0.2f;
        }
        
        TA_RetCode retCode = TA_MA( 0, 399,
                        &closePrice[0],
                        30,TA_MAType_SMA,
                        &outBeg, &outNbElement, &out[0] );
        /* The output is displayed here */
        for( int i=0; i < outNbElement; i++ ){
            printf( "Day %d = %f\n", outBeg+i, out[i] );
        }
    }
};

#endif /* CppTest_hpp */
