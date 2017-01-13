//
//  UIImage+Common.m
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/4/13.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+ (UIImage *)imageWithColor:(UIColor *)aColor
{
    return [UIImage imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame
{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//对图片尺寸进行压缩--
- (UIImage*)scaledToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetSize.width / imageSize.width;
        CGFloat heightFactor = targetSize.height / imageSize.height;
        if (widthFactor < heightFactor)
            scaleFactor = heightFactor; // scale to fit height
        else
            scaleFactor = widthFactor; // scale to fit width
    }
    scaleFactor = MIN(scaleFactor, 1.0);
    CGFloat targetWidth = imageSize.width* scaleFactor;
    CGFloat targetHeight = imageSize.height* scaleFactor;

    targetSize = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
    UIGraphicsBeginImageContext(targetSize); // this will crop
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        DebugLog(@"could not scale image");
        newImage = sourceImage;
    }
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality
{
    if (highQuality) {
        targetSize = CGSizeMake(2*targetSize.width, 2*targetSize.height);
    }
    return [self scaledToSize:targetSize];
}

+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:(UIImageOrientation)assetRep.orientation];
//    UIImage *img = [UIImage imageWithCGImage:imgRef];
    return img;
}

- (UIImage *)scaledToSize:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage*)setImageBySize:(UIImage*)srcimg size:(CGSize)size
{
    UIImage *img = srcimg;
    float h = img.size.height;
    float w = img.size.width;
    
    float b = 1;
    if(w >= h) {
        b= h/size.height;
    }
    else {
        b= w/size.width;
    }
    
    //等比缩放
    CGSize itemSize = CGSizeMake(w/b, h/b);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [img drawInRect:imageRect];
    UIImage *bigImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGRect smallRect;
    if(w > h) {
        smallRect = CGRectMake((itemSize.width-size.width)/2, 0, size.width, size.height);
    } else {
        smallRect = CGRectMake(0,(itemSize.height-size.height)/2, size.width, size.height);
    }
    //对图片进行截取
    CGImageRef imgref = CGImageCreateWithImageInRect([bigImage CGImage], smallRect);
    UIImage *tmpImg = [UIImage imageWithCGImage:imgref];
    CGImageRelease(imgref);
    
    UIGraphicsEndImageContext();
    
    return tmpImg;
}

//2G环境下的等比压缩
+ (UIImage*)setImageFor2G:(UIImage*)srcimg
{
    UIImage *img = srcimg;
    float h = img.size.height;
    float w = img.size.width;
    
    float b = 1;
    
    if ((w > 640) || (h > 640)) {
        if (w >= h) {
            b = 640/w;
        } else {
            b = 640/h;
        }
        
        w *= b;
        h *= b;
    }
    
    
    //等比缩放
    CGSize itemSize = CGSizeMake(w, h);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [img drawInRect:imageRect];
    UIImage *bigImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGRect smallRect;
    smallRect = CGRectMake(0,0, w, h);
    
    //对图片进行截取
    CGImageRef imgref = CGImageCreateWithImageInRect([bigImage CGImage], smallRect);
    UIImage *tmpImg = [UIImage imageWithCGImage:imgref];
    CGImageRelease(imgref);
    
    UIGraphicsEndImageContext();
    
    return tmpImg;
}

//从相册里边选择图片的压缩算法
+ (UIImage *)rotateImageForPhoto:(CGImageRef )aImage isWifi:(BOOL)isWifi rotate:(UIImageOrientation)imageOrientation
{
    CGImageRef imgRef = aImage;
    UIImageOrientation orient = imageOrientation;
    UIImageOrientation newOrient = UIImageOrientationUp;
    
    switch (orient) {
        case 3://竖拍 home键在下
            newOrient = UIImageOrientationRight;
            break;
        case 2://倒拍 home键在上
            newOrient = UIImageOrientationLeft;
            break;
        case 0://左拍 home键在右
            newOrient = UIImageOrientationUp;
            break;
        case 1://右拍 home键在左
            newOrient = UIImageOrientationDown;
            break;
        default:
            newOrient = UIImageOrientationRight;
            break;
    }
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGFloat ratio = 0;
    
    //解决长微博压缩的问题
    CGFloat whratio = 0;
    
    if(newOrient == 0 || newOrient == 1) {
        whratio = height/width;
    }else {
        whratio = width/height;
    }
    
    //该算法是宽高为1200 和1600 的算法
    if(isWifi) {
        //竖屏
        if(newOrient == 0 || newOrient == 1) {
            if (width > 1200) {
                if (width >= height) {
                    ratio = 1600/width;
                } else {
                    ratio = 1200/height;
                }
                
                width *= ratio;
                height *= ratio;
            }
        }else {
            //横屏
            if (height > 1200) {
                if (width >= height) {
                    ratio = 1600/width;
                } else {
                    ratio = 1200/height;
                }
                
                width *= ratio;
                height *= ratio;
            }
        }
    }else {
        if(newOrient == 0 || newOrient == 1) {
            if (width > 480) {
                if (width >= height) {
                    ratio = 640/width;
                } else {
                    ratio = 480/height;
                }
                
                //长微博的时候不压缩
                if (whratio >= 8) {
                    ratio = 1;
                }
                
                width *= ratio;
                height *= ratio;
            }
        }else {
            if (height > 480) {
                if (width >= height) {
                    ratio = 640/width;
                } else {
                    ratio = 480/height;
                }
                
                //长微博的时候不压缩
                if (whratio >= 8) {
                    ratio = 1;
                }
                
                width *= ratio;
                height *= ratio;
            }
        }
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    
    switch(newOrient) {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (newOrient == UIImageOrientationRight || newOrient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

//调整图片转向
+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}


- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    if (!tintColor) {
        return self;
    }
    
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn)
    {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}



@end
