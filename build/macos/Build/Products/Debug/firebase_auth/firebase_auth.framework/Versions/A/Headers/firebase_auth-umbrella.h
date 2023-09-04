#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FLTAuthStateChannelStreamHandler.h"
#import "FLTIdTokenChannelStreamHandler.h"
#import "FLTPhoneNumberVerificationStreamHandler.h"
#import "PigeonParser.h"
#import "CustomPigeonHeader.h"
#import "FLTFirebaseAuthPlugin.h"
#import "messages.g.h"

FOUNDATION_EXPORT double firebase_authVersionNumber;
FOUNDATION_EXPORT const unsigned char firebase_authVersionString[];
