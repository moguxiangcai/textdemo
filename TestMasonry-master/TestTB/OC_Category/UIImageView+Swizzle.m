//
//  UIImageView+Swizzle.m
//  RRArt-iOS
//
//  Created by wtj on 16/5/11.
//  Copyright © 2016年 YiBei. All rights reserved.
//

#import "UIImageView+Swizzle.h"
#import "ObjcRuntime.h"
#import <objc/runtime.h>
#import <ImageIO/ImageIO.h>

static const void *wtjImageViewGiFKey = "wtjImageViewGiFKey";
@implementation UIImageView (Swizzle)

-(void)setGif:(NSMutableDictionary *)Gif{
    objc_setAssociatedObject(self, wtjImageViewGiFKey, Gif, OBJC_ASSOCIATION_COPY);
    
}

-(NSMutableDictionary *)Gif{
    
    return  objc_getAssociatedObject(self,wtjImageViewGiFKey);
}

+(void)load{
    
    Swizzle([UIImageView class], @selector(sd_setImageWithURL:placeholderImage:), @selector(wtj_setImageWithURL:placeholderImage:));
    
}

- (void)wtj_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    
    NSMutableDictionary *imageDic = [[NSMutableDictionary alloc]init];
    self.Gif = imageDic;
    
    if (url ==nil) {
        self.image = placeholder;
        
    }else{
        if ([url.absoluteString.lowercaseString rangeOfString:@".gif"].location !=NSNotFound ) {
             self.image = placeholder;
            
//            __weak UIImageView *wself = self;
//            
//            if (!wself) return;
//            [self wtj_animatedGIF:url andBackImage:^(UIImage *image) {
//                
//                wself.image = image;
//            }];
            
        }else{
            
            [self wtj_setImageWithURL:url placeholderImage:placeholder];
        }
        
    }
    
}

- (void)wtj_animatedGIF:(NSURL *)url andBackImage:(void (^)(UIImage *))Icon{
    
    __block UIImage *image=nil;
    __weak UIImageView *wself = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        image = [wself wtj_setGIFImage:url];
        
        @synchronized (wself.Gif) {
            [wself.Gif setObject:image forKey:[NSString stringWithFormat:@"%@",url.absoluteString.lowercaseString]];
        }
        dispatch_main_sync_safe(^{
            
            if (wself.Gif[[NSString stringWithFormat:@"%@",url.absoluteString.lowercaseString]]) {
                
                Icon(wself.Gif[[NSString stringWithFormat:@"%@",url.absoluteString.lowercaseString]]);
            }
     
        });
    });
    
}

- (UIImage *)wtj_setGIFImage:(NSURL *)url{
    
    if (url ==nil) {
        return  nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)[NSData dataWithContentsOfURL:url], NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        
        animatedImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    }else{
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, 0, NULL);
        
        animatedImage=[UIImage imageWithCGImage:image];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

@end
