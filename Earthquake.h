//
//  Earthquake.h
//  Epicenters
//
//  Created by Saiteja Samudrala on 7/22/14.
//  Copyright (c) 2014 edu.foothill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Earthquake : NSObject

@property float longitude;
@property float latitude;
@property float magnitude;
@property NSString *place; 

@end
