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
#include <math.h>
#define PI 3.14159265

enum PlotAnimatorCurve {
    PlotAnimatorCurveLinear,
    PlotAnimatorCurveEaseInQuad,
    PlotAnimatorCurveEaseOutQuad,
    PlotAnimatorCurveEaseInOutQuad,
    PlotAnimatorCurveEaseInCubic,
    PlotAnimatorCurveEaseOutCubic,
    PlotAnimatorCurveEaseInOutCubic,
    PlotAnimatorCurveEaseInQuart,
    PlotAnimatorCurveEaseOutQuart,
    PlotAnimatorCurveEaseInOutQuart,
    PlotAnimatorCurveEaseInQuint,
    PlotAnimatorCurveEaseOutQuint,
    PlotAnimatorCurveEaseInOutQuint,
    PlotAnimatorCurveEaseInSine,
    PlotAnimatorCurveEaseOutSine,
    PlotAnimatorCurveEaseInOutSine,
    PlotAnimatorCurveEaseInExpo,
    PlotAnimatorCurveEaseOutExpo,
    PlotAnimatorCurveEaseInOutExpo,
    PlotAnimatorCurveEaseInCirc,
    PlotAnimatorCurveEaseOutCirc,
    PlotAnimatorCurveEaseInOutCirc,
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
                    
                case PlotAnimatorCurveEaseInQuad: {
                    value = easeInQuad(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseOutQuad: {
                    value = easeOutQuad(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInOutQuad: {
                    value = easeInOutQuad(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInCubic: {
                    value = easeInCubic(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseOutCubic: {
                    value = easeOutCubic(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInOutCubic: {
                    value = easeInOutCubic(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInQuart: {
                    value = easeInQuart(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseOutQuart: {
                    value = easeOutQuart(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInOutQuart: {
                    value = easeInOutQuart(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInQuint: {
                    value = easeInQuint(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseOutQuint: {
                    value = easeOutQuint(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInOutQuint: {
                    value = easeInOutQuint(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInSine: {
                    value = easeInSine(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseOutSine: {
                    value = easeOutSine(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInOutSine: {
                    value = easeInOutSine(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInExpo: {
                    value = easeInExpo(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseOutExpo: {
                    value = easeOutExpo(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInOutExpo: {
                    value = easeInOutExpo(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInCirc: {
                    value = easeInCirc(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseOutCirc: {
                    value = easeOutCirc(timeDiff, fromValue, valDiff, duration);
                    break;
                }
                    
                case PlotAnimatorCurveEaseInOutCirc: {
                    value = easeInOutCirc(timeDiff, fromValue, valDiff, duration);
                    break;
                }
            }
            
            if ( value == toValue ) {
                fromValue = toValue;
            }
            
            return value;
        }
    }
    
    
    double linear(double t, double b, double c, double d)
    {
        return c * t / d + b;
    }
    
    
    double easeInQuad(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t + b;
    }
    
    
    double easeOutQuad(double t, double b, double c, double d)
    {
        t /= d;
        return -c * t * (t - 2) + b;
    }
    
    
    double easeInOutQuad(double t, double b, double c, double d)
    {
        t /= d / 2;
        
        if ( t < 1 ) return c / 2 * t * t + b;
        
        t--;
        return -c / 2 * (t * (t - 2) - 1) + b;
    }
    
    
    double easeInCubic(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t + b;
    }
    
    
    double easeOutCubic(double t, double b, double c, double d)
    {
        t /= d;
        t--;
        return c * (t * t * t + 1) + b;
    }
    
    
    double easeInOutCubic(double t, double b, double c, double d)
    {
        t /= d / 2;
        
        if ( t < 1 ) return c / 2 * t * t * t + b;
        
        t -= 2;
        return c / 2 * (t * t * t + 2) + b;
    }
    
    
    double easeInQuart(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t * t + b;
    }
    
    
    double easeOutQuart(double t, double b, double c, double d)
    {
        t /= d;
        t--;
        return -c * (t * t * t * t - 1) + b;
    }
    
    
    double easeInOutQuart(double t, double b, double c, double d)
    {
        t /= d / 2;
        
        if ( t < 1 ) return c / 2 * t * t * t * t + b;
        
        t -= 2;
        return -c / 2 * (t * t * t * t - 2) + b;
    }
    
    
    double easeInQuint(double t, double b, double c, double d)
    {
        t /= d;
        return c * t * t * t * t * t + b;
    }
    
    
    double easeOutQuint(double t, double b, double c, double d)
    {
        t /= d;
        t--;
        return c * (t * t * t * t * t + 1) + b;
    }
    
    
    double easeInOutQuint(double t, double b, double c, double d)
    {
        t /= d / 2;
        
        if ( t < 1 ) return c / 2 * t * t * t * t * t + b;
        
        t -= 2;
        return c / 2 * (t * t * t * t * t + 2) + b;
    }
    
    
    double easeInSine(double t, double b, double c, double d)
    {
        return -c * cos(t / d * (PI / 2)) + c + b;
    }
    
    
    double easeOutSine(double t, double b, double c, double d)
    {
        return c * sin(t / d * (PI / 2)) + b;
    }
    
    
    double easeInOutSine(double t, double b, double c, double d)
    {
        return -c / 2 * (cos(PI * t / d) - 1) + b;
    }
    
    
    double easeInExpo(double t, double b, double c, double d)
    {
        return c *  pow(2, 10 * (t / d - 1) ) + b;
    }
    
    
    double easeOutExpo(double t, double b, double c, double d)
    {
        return c * (-pow(2, -10 * t / d) + 1) + b;
    }
    
    
    double easeInOutExpo(double t, double b, double c, double d)
    {
        t /= d / 2;
        
        if ( t < 1 ) return c / 2 * pow(2, 10 * (t - 1) ) + b;
        
        t--;
        return c / 2 * (-pow(2, -10 * t) + 2) + b;
    }
    
    
    double easeInCirc(double t, double b, double c, double d)
    {
        t /= d;
        return -c * (sqrt(1 - t * t) - 1) + b;
    }
    
    
    double easeOutCirc(double t, double b, double c, double d)
    {
        t /= d;
        t--;
        return c * sqrt(1 - t * t) + b;
    }
    
    
    double easeInOutCirc(double t, double b, double c, double d)
    {
        t /= d / 2;
        
        if ( t < 1 ) return -c / 2 * (sqrt(1 - t * t) - 1) + b;
        
        t -= 2;
        return c / 2 * (sqrt(1 - t * t) + 1) + b;
    }
    
    
    PlotAnimator();
};


#endif /* PlotAnimator_hpp */
