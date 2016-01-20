//
//  PlotAnimator.hpp
//  ExpertOption
//
//  Created by Stephen Kopylov - Home on 20/01/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#ifndef PlotAnimator_hpp
#define PlotAnimator_hpp

#include <stdio.h>

enum PlotAnimatorCurve {
    PlotAnimatorCurveLinear,
    green,
    blue
};

class PlotAnimator {
private:
    double startTime;
    double value;
public:
    PlotAnimatorCurve curveType;
    double fromValue;
    double toValue;
    double time;
    double duration;
    
    void setToValue(double newToValue)
    {
        if ( newToValue != toValue ) {
            toValue = newToValue;
            startTime = time;
        }
    }
    
    
    double getValue()
    {
        if ( fromValue == toValue ) {
            return toValue;
        }
        else {
            double timeDiff = time - startTime;
            double valDiff = toValue - fromValue;
            
            if ( timeDiff >= duration ) {
                timeDiff = duration;
            }
            
            switch ( curveType )
            {
                case PlotAnimatorCurveLinear: {
                    value = linear(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case green: {
                    break;
                }
                    
                case blue: {
                    break;
                }
            }
            
            if ( value == toValue ) {
                fromValue = toValue;
            }
            
            return value;
        }
    }
    
    
    double linear(double t, double from, double to, double d)
    {
        return to * t / d + from;
    }
    
    
    double easeInOutCubic(double t, double from, double to, double d)
    {
        if ((t /= d / 2) < 1 ) {
            return to / 2 * t * t * t + from;
        }
        else {
            t -= 2;
            return to / 2 * (t * t * t + 2) + from;
        }
    }
    
    
    PlotAnimator();
};


#endif /* PlotAnimator_hpp */
