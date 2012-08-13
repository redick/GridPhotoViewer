//
//  MyModelController.h
//  GridPhotoViewer
//
//  Created by Shen Steven on 8/13/12.
//  Copyright (c) 2012 syshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModelController : NSObject

@property (nonatomic, readonly) NSUInteger numberOfPhotos;

- (id) initWithCompletionBlock:(void(^)(void))callback;
- (UIImage*) imageAtIndex:(NSUInteger) index;

@end
