//
//  UIStoryboardSegue+M5LinkedStoryboard.m
//  UIStoryboardSegue+M5LinkedStoryboard
//

#import "UIStoryboardSegue+M5LinkedStoryboard.h"

#import <objc/runtime.h>

@implementation UIStoryboardSegue (M5LinkedStoryboard)

#pragma mark - UIStoryboardSegue+M5LinkedStoryboard (Private) -

#pragma mark Methods

+ (UIViewController *)M5_sceneWithStoryboard:(NSString *)storyboardName scene:(NSString *)sceneName {
    UIStoryboard *storyboard;
    
    if (!storyboardName.length || !(storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil])) {
        return nil;
    }
    
    UIViewController *scene;
    if (sceneName.length) {
        scene = [storyboard instantiateViewControllerWithIdentifier:sceneName];
        
        NSAssert(scene, @"Couldn't find scene with name %@.", sceneName);
    } else {
        scene = [storyboard instantiateInitialViewController];
    }
    
    return scene;
}

#pragma mark -

#pragma mark - NSObject -

#pragma mark Methods

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selector = @selector(initWithIdentifier:source:destination:);
        
        __block IMP oldImp = nil;
        IMP newImp = imp_implementationWithBlock(^id(id self, NSString *identifier, UIViewController *source, UIViewController *destination) {
            if (oldImp) {
                NSArray *segueInfo;
                UIViewController *newDestination;
                if (identifier.length && (segueInfo = [identifier componentsSeparatedByString:@"@"]) && segueInfo.count == 2) {
                    newDestination = [UIStoryboardSegue M5_sceneWithStoryboard:segueInfo[0] scene:segueInfo[1]];
                }
                
                return ((id(*)(id, SEL, NSString*, UIViewController*, UIViewController*))oldImp)(self, selector, identifier, source, newDestination ?: destination);
            }
            
            return nil;
        });
        
        Method method = class_getInstanceMethod(self, selector);
        if (method) {
            oldImp = method_setImplementation(method, newImp);
        } else {
            const char *methodTypes = [NSString stringWithFormat:@"%s%s%s%s%s%s", @encode(id), @encode(id), @encode(SEL), @encode(NSString*), @encode(UIViewController*), @encode(UIViewController*)].UTF8String;
            
            class_addMethod(self, selector, newImp, methodTypes);
        }
    });
}

#pragma mark -

@end
