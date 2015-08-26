//
//  Define.h
//  Fakruddin
//
//  Created by Mahboob on 6/11/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#ifndef Fakruddin_Define_h
#define Fakruddin_Define_h

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]




#endif
