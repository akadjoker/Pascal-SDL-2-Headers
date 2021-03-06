unit SDL;

{
  Simple DirectMedia Layer
  Copyright (C) 1997-2013 Sam Lantinga <slouken@libsdl.org>

  Pascal-Header-Conversion
  Copyright (C) 2012/13 Tim Blume aka End

  SDL.pas is based on the files:
    "sdl.h",
 	  "sdl_main.h",
    "sdltype_s.h",
	  "sdl_stdinc.h",
	  "sdl_events.h",
    "sdl_keyboard.h",
    "sdl_keycode.h",
    "sdl_scancode.h",
    "sdl_mouse.h",
    "sdl_video.h",
    "sdl_pixels.h",
    "sdl_surface.h",
    "sdl_rwops.h"

  Parts of the SDL.pas are from the SDL-1.2-Headerconversion from the JEDI-Team,
  written by Domenique Louis and others.

  I've changed the names of the dll for 32 & 64-Bit, so theres no conflict,
  between 32 & 64 bit Libraries.

  This software is provided 'as-is', without any express or implied
  warranty.  In no case will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
}

{
  Changelog:
  ----------
  v.1.0; XX.04.2013: Initial Release.
}

{$DEFINE SDL}

{$I sdl.inc}

interface

//uses

const

  {$IFDEF WINDOWS}
    {$IFDEF WIN32}
      SDL_LibName = 'SDL2_x86.dll';
	{$ENDIF}
	{$IFDEF WIN64}
	  SDL_LibName = 'SDL2_x86_x64.dll';
	{$ENDIF}
  {$ENDIF}

  {$IFDEF UNIX}
    {$IFDEF DARWIN}
      SDL_LibName = 'libSDL-2.dylib';
    {$ELSE}
      {$IFDEF FPC}
        SDL_LibName = 'libSDL-2.so';
      {$ELSE}
        SDL_LibName = 'libSDL-2.so.0';
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}

  {$IFDEF MACOS}
    SDL_LibName = 'SDL2';
    {$linklib libSDL}
  {$ENDIF}

  //types from SDLtype_s.h / SDL_stdinc.h
type

  TSDLBool = (SDL_FALSE,SDL_TRUE);

  PUInt8Array = ^TUInt8Array;
  PUInt8 = ^UInt8;
  UInt8 = Byte;
  {$EXTERNALSYM UInt8}
  TUInt8Array = array [0..MAXINT shr 1] of UInt8;

  PUInt16 = ^UInt16;
  UInt16 = word;
  {$EXTERNALSYM UInt16}

  PSInt8 = ^SInt8;
  SInt8 = Shortint;
  {$EXTERNALSYM SInt8}

  PSInt16 = ^SInt16;
  SInt16 = smallint;
  {$EXTERNALSYM SInt16}

  PUInt32 = ^UInt32;
  UInt32 = Cardinal;
  {$EXTERNALSYM UInt32}

  SInt32 = LongInt;
  {$EXTERNALSYM SInt32}

  PInt = ^LongInt;

  PShortInt = ^ShortInt;

  PUInt64 = ^UInt64;
  UInt64 = record
    hi: UInt32;
    lo: UInt32;
  end;
  {$EXTERNALSYM UInt64}

  PSInt64 = ^SInt64;
  SInt64 = record
    hi: UInt32;
    lo: UInt32;
  end;
  {$EXTERNALSYM SInt64}

  Float = Single;
  {$EXTERNALSYM Float}


  //from "sdl_pixels.h"

  {**
   *  Transparency definitions
   *
   *  These define alpha as the opacity of a surface.
   *}

  const
    SDL_ALPHA_OPAQUE = 255;
    SDL_ALPHA_TRANSPARENT = 0;

    {** Pixel type. *}
    
    SDL_PIXELTYPE_UNKNOWN = 0;
    SDL_PIXELTYPE_INDEX1 = 1;
    SDL_PIXELTYPE_INDEX4 = 2;
    SDL_PIXELTYPE_INDEX8 = 3;
    SDL_PIXELTYPE_PACKED8 = 4;
    SDL_PIXELTYPE_PACKED16 = 5;
    SDL_PIXELTYPE_PACKED32 = 6;
    SDL_PIXELTYPE_ARRAYU8 = 7;
    SDL_PIXELTYPE_ARRAYU16 = 8;
    SDL_PIXELTYPE_ARRAYU32 = 9;
    SDL_PIXELTYPE_ARRAYF16 = 10;
    SDL_PIXELTYPE_ARRAYF32 = 11;

    {** Bitmap pixel order, high bit -> low bit. *}

    SDL_BITMAPORDER_NONE = 0;
    SDL_BITMAPORDER_4321 = 1;
    SDL_BITMAPORDER_1234 = 2;

    {** Packed component order, high bit -> low bit. *}

    SDL_PACKEDORDER_NONE = 0;
    SDL_PACKEDORDER_XRGB = 1;
    SDL_PACKEDORDER_RGBX = 2;
    SDL_PACKEDORDER_ARGB = 3;
    SDL_PACKEDORDER_RGBA = 4;
    SDL_PACKEDORDER_XBGR = 5;
    SDL_PACKEDORDER_BGRX = 6;
    SDL_PACKEDORDER_ABGR = 7;
    SDL_PACKEDORDER_BGRA = 8;

    {** Array component order, low byte -> high byte. *}

    SDL_ARRAYORDER_NONE = 0;
    SDL_ARRAYORDER_RGB = 1;
    SDL_ARRAYORDER_RGBA = 2;
    SDL_ARRAYORDER_ARGB = 3;
    SDL_ARRAYORDER_BGR = 4;
    SDL_ARRAYORDER_BGRA = 5;
    SDL_ARRAYORDER_ABGR = 6;

    {** Packed component layout. *}

    SDL_PACKEDLAYOUT_NONE = 0;
    SDL_PACKEDLAYOUT_332 = 1;
    SDL_PACKEDLAYOUT_4444 = 2;
    SDL_PACKEDLAYOUT_1555 = 3;
    SDL_PACKEDLAYOUT_5551 = 4;
    SDL_PACKEDLAYOUT_565 = 5;
    SDL_PACKEDLAYOUT_8888 = 6;
    SDL_PACKEDLAYOUT_2101010 = 7;
    SDL_PACKEDLAYOUT_1010102 = 8;

    {

function SDL_DEFINE_PIXELFOURCC(A,B,C,D: Variant): Variant;

#define SDL_DEFINE_PIXELFORMAT(type, order, layout, bits, bytes) \
    ((1 << 28) | ((type) << 24) | ((order) << 20) | ((layout) << 16) | \
     ((bits) << 8) | ((bytes) << 0))

#define SDL_PIXELFLAG(X)	(((X) >> 28) & 0x0F)
#define SDL_PIXELTYPE(X)	(((X) >> 24) & 0x0F)
#define SDL_PIXELORDER(X)	(((X) >> 20) & 0x0F)
#define SDL_PIXELLAYOUT(X)	(((X) >> 16) & 0x0F)
#define SDL_BITSPERPIXEL(X)	(((X) >> 8) & 0xFF)
#define SDL_BYTESPERPIXEL(X) \
    (SDL_ISPIXELFORMAT_FOURCC(X) ? \
        ((((X) == SDL_PIXELFORMAT_YUY2) || \
          ((X) == SDL_PIXELFORMAT_UYVY) || \
          ((X) == SDL_PIXELFORMAT_YVYU)) ? 2 : 1) : (((X) >> 0) & 0xFF))

#define SDL_ISPIXELFORMAT_INDEXED(format)   \
    (!SDL_ISPIXELFORMAT_FOURCC(format) && \
     ((SDL_PIXELTYPE(format) == SDL_PIXELTYPE_INDEX1) || \
      (SDL_PIXELTYPE(format) == SDL_PIXELTYPE_INDEX4) || \
      (SDL_PIXELTYPE(format) == SDL_PIXELTYPE_INDEX8)))

#define SDL_ISPIXELFORMAT_ALPHA(format)   \
    (!SDL_ISPIXELFORMAT_FOURCC(format) && \
     ((SDL_PIXELORDER(format) == SDL_PACKEDORDER_ARGB) || \
      (SDL_PIXELORDER(format) == SDL_PACKEDORDER_RGBA) || \
      (SDL_PIXELORDER(format) == SDL_PACKEDORDER_ABGR) || \
      (SDL_PIXELORDER(format) == SDL_PACKEDORDER_BGRA)))

  function SDL_IsPixelFormat_FOURCC(format: Variant);

  {* Note: If you modify this list, update SDL_GetPixelFormatName() *}
           
    SDL_PIXELFORMAT_UNKNOWN = 0;
    SDL_PIXELFORMAT_INDEX1LSB = (1 shl 28)                    or
                                (SDL_PIXELTYPE_INDEX1 shl 24) or
                                (SDL_BITMAPORDER_4321 shl 20) or
                                (0 shl 16)                    or
                                (1 shl 8)                     or
                                (0 shl 0);

    SDL_PIXELFORMAT_INDEX1MSB = (1 shl 28)                    or
                                (SDL_PIXELTYPE_INDEX1 shl 24) or
                                (SDL_BITMAPORDER_1234 shl 20) or
                                (0 shl 16)                    or
                                (1 shl 8)                     or
                                (0 shl 0);

    SDL_PIXELFORMAT_INDEX4LSB = (1 shl 28)                    or
                                (SDL_PIXELTYPE_INDEX4 shl 24) or
                                (SDL_BITMAPORDER_4321 shl 20) or
                                (0 shl 16)                    or
                                (4 shl 8)                     or
                                (0 shl 0);

    SDL_PIXELFORMAT_INDEX4MSB = (1 shl 28)                    or
                                (SDL_PIXELTYPE_INDEX4 shl 24) or
                                (SDL_BITMAPORDER_1234 shl 20) or
                                (0 shl 16)                    or
                                (4 shl 8)                     or
                                (0 shl 0);

    SDL_PIXELFORMAT_INDEX8 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED8 shl 24)  or
                                (0 shl 20)                      or
                                (0 shl 16)                      or
                                (8 shl 8)                       or
                                (1 shl 0);
                                
    SDL_PIXELFORMAT_RGB332 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED8 shl 24)  or
                                (SDL_PACKEDORDER_XRGB shl 20)   or
                                (SDL_PACKEDLAYOUT_332 shl 16)   or
                                (8 shl 8)                       or
                                (1 shl 0);

    SDL_PIXELFORMAT_RGB444 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_XRGB shl 20)   or
                                (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                (12 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_RGB555 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_XRGB shl 20)   or
                                (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                (15 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_BGR555 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_XBGR shl 20)   or
                                (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                (15 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_ARGB4444 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_ARGB shl 20)   or
                                (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_RGBA4444 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_RGBA shl 20)   or
                                (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_ABGR4444 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_ABGR shl 20)   or
                                (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_BGRA4444 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_BGRA shl 20)   or
                                (SDL_PACKEDLAYOUT_4444 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_ARGB1555 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_ARGB shl 20)   or
                                (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_RGBA5551 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_RGBA shl 20)   or
                                (SDL_PACKEDLAYOUT_5551 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_ABGR1555 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_ABGR shl 20)   or
                                (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_BGRA5551 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_BGRA shl 20)   or
                                (SDL_PACKEDLAYOUT_5551 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_RGB565 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_XRGB shl 20)   or
                                (SDL_PACKEDLAYOUT_565 shl 16)   or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_BGR565 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED16 shl 24) or
                                (SDL_PACKEDORDER_XBGR shl 20)   or
                                (SDL_PACKEDLAYOUT_1555 shl 16)  or
                                (16 shl 8)                      or
                                (2 shl 0);

    SDL_PIXELFORMAT_RGB24 =     (1 shl 28)                      or
                                (SDL_PIXELTYPE_ARRAYU8 shl 24)  or
                                (SDL_ARRAYORDER_RGB shl 20)     or
                                (0 shl 16)                      or
                                (24 shl 8)                      or
                                (3 shl 0);

    SDL_PIXELFORMAT_BGR24 =     (1 shl 28)                      or
                                (SDL_PIXELTYPE_ARRAYU8 shl 24)  or
                                (SDL_ARRAYORDER_BGR shl 20)     or
                                (0 shl 16)                      or
                                (24 shl 8)                      or
                                (3 shl 0);

    SDL_PIXELFORMAT_RGB888 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED32 shl 24) or
                                (SDL_PACKEDORDER_XRGB shl 20)   or
                                (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                (24 shl 8)                      or
                                (4 shl 0);

    SDL_PIXELFORMAT_RGBX8888 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED32 shl 24) or
                                (SDL_PACKEDORDER_RGBX shl 20)   or
                                (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                (24 shl 8)                      or
                                (4 shl 0);

    SDL_PIXELFORMAT_BGR888 =    (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED32 shl 24) or
                                (SDL_PACKEDORDER_XBGR shl 20)   or
                                (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                (24 shl 8)                      or
                                (4 shl 0);

    SDL_PIXELFORMAT_BGRX8888 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED32 shl 24) or
                                (SDL_PACKEDORDER_BGRX shl 20)   or
                                (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                (24 shl 8)                      or
                                (4 shl 0);

    SDL_PIXELFORMAT_ARGB8888 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED32 shl 24) or
                                (SDL_PACKEDORDER_ARGB shl 20)   or
                                (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                (32 shl 8)                      or
                                (4 shl 0);

    SDL_PIXELFORMAT_RGBA8888 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED32 shl 24) or
                                (SDL_PACKEDORDER_RGBA shl 20)   or
                                (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                (32 shl 8)                      or
                                (4 shl 0);

    SDL_PIXELFORMAT_ABGR8888 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED32 shl 24) or
                                (SDL_PACKEDORDER_ABGR shl 20)   or
                                (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                (32 shl 8)                      or
                                (4 shl 0);

    SDL_PIXELFORMAT_BGRA8888 =  (1 shl 28)                      or
                                (SDL_PIXELTYPE_PACKED32 shl 24) or
                                (SDL_PACKEDORDER_RGBX shl 20)   or
                                (SDL_PACKEDLAYOUT_8888 shl 16)  or
                                (32 shl 8)                      or
                                (4 shl 0);

    SDL_PIXELFORMAT_ARGB2101010 = (1 shl 28)                       or
                                  (SDL_PIXELTYPE_PACKED32 shl 24)  or
                                  (SDL_PACKEDORDER_ARGB shl 20)    or
                                  (SDL_PACKEDLAYOUT_2101010 shl 16)or
                                  (32 shl 8)                       or
                                  (4 shl 0);

    {SDL_PIXELFORMAT_YV12 =      {**< Planar mode: Y + V + U  (3 planes) *}
     {   SDL_DEFINE_PIXELFOURCC('Y', 'V', '1', '2'),
    SDL_PIXELFORMAT_IYUV =      {**< Planar mode: Y + U + V  (3 planes) *}
    {    SDL_DEFINE_PIXELFOURCC('I', 'Y', 'U', 'V'),
    SDL_PIXELFORMAT_YUY2 =      {**< Packed mode: Y0+U0+Y1+V0 (1 plane) *}
     {   SDL_DEFINE_PIXELFOURCC('Y', 'U', 'Y', '2'),
    SDL_PIXELFORMAT_UYVY =      {**< Packed mode: U0+Y0+V0+Y1 (1 plane) *}
    {    SDL_DEFINE_PIXELFOURCC('U', 'Y', 'V', 'Y'),
    SDL_PIXELFORMAT_YVYU =      {**< Packed mode: Y0+V0+Y1+U0 (1 plane) *}
     {   SDL_DEFINE_PIXELFOURCC('Y', 'V', 'Y', 'U')     }



type
  PSDLColor = ^TSDLColor;
  TSDLColor = record
    r: UInt8;
    g: UInt8;
    b: UInt8;
    unused: UInt8;
  end;

  TSDLColour = TSDLColor;
  PSDLColour = ^TSDLColour;

  PSDLPalette = ^TSDLPalette;
  TSDLPalette = record
    ncolors: SInt32;
    colors: PSDLColor;
    version: UInt32;
    refcount: SInt32;
  end;

  {**
   *  Everything in the pixel format structure is read-only.
   *}

  PSDLPixelFormat = ^TSDLPixelFormat;
  TSDLPixelFormat = record
    format: UInt32;
    palette: PSDLPalette;
    BitsPerPixel: UInt8;
    BytesPerPixel: UInt8;
    padding: array[0..1] of UInt8;
    Rmask: UInt32;
    Gmask: UInt32;
    Bmask: UInt32;
    Amask: UInt32;
    Rloss: UInt8;
    Gloss: UInt8;
    Bloss: UInt8;
    Aloss: UInt8;
    Rshift: UInt8;
    Gshift: UInt8;
    Bshift: UInt8;
    Ashift: UInt8;
    refcount: SInt32;
    next: PSDLPixelFormat;
  end;

  {**
   *  Get the human readable name of a pixel format
   *}

function SDL_GetPixelFormatName(format: UInt32): PChar cdecl external {$IFDEF GPC} name 'SDL_GetPixelFormatName' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Convert one of the enumerated pixel formats to a bpp and RGBA masks.
   *
   *  SDL_TRUE, or SDL_FALSE if the conversion wasn't possible.
   *
   *  SDL_MasksToPixelFormatEnum()
   *}

function SDL_PixelFormatEnumToMasks(format: UInt32; bpp: PInt; Rmask: PUInt32; Gmask: PUInt32; Bmask: PUInt32; Amask: PUInt32): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_PixelFormatEnumToMasks' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Convert a bpp and RGBA masks to an enumerated pixel format.
   *
   *  The pixel format, or SDL_PIXELFORMAT_UNKNOWN if the conversion
   *  wasn't possible.
   *
   *  SDL_PixelFormatEnumToMasks()
   *}

function SDL_MasksToPixelFormatEnum(bpp: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): UInt32;

  {**
   *  Create an SDL_PixelFormat structure from a pixel format enum.
   *}

function SDL_AllocFormat(pixel_format: UInt32): PSDLPixelFormat cdecl external {$IFDEF GPC} name 'SDL_AllocFormat' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Free an SDL_PixelFormat structure.
   *}

procedure SDL_FreeFormat(format: PSDLPixelFormat) cdecl external {$IFDEF GPC} name 'SDL_FreeFormat' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Create a palette structure with the specified number of color
   *  entries.
   *
   *  A new palette, or nil if there wasn't enough memory.
   *
   *  The palette entries are initialized to white.
   *  
   *  SDL_FreePalette()
   *}

function SDL_AllocPalette(ncolors: SInt32): PSDLPalette cdecl external {$IFDEF GPC} name 'SDL_AllocPalette' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the palette for a pixel format structure.
   *}

function SDL_SetPixelFormatPalette(format: PSDLPixelFormat; palette: PSDLPalette): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetPixelFormatPalette' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set a range of colors in a palette.
   *
   *  palette    The palette to modify.
   *  colors     An array of colors to copy into the palette.
   *  firstcolor The index of the first palette entry to modify.
   *  ncolors    The number of entries to modify.
   *
   *  0 on success, or -1 if not all of the colors could be set.
   *}

function SDL_SetPaletteColors(palette: PSDLPalette; const colors: PSDLColor; firstcolor: SInt32; ncolors: SInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetPaletteColors' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Free a palette created with SDL_AllocPalette().
   *
   *  SDL_AllocPalette()
   *}

procedure SDL_FreePalette(palette: PSDLPalette) cdecl external {$IFDEF GPC} name 'SDL_FreePalette' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Maps an RGB triple to an opaque pixel value for a given pixel format.
   *
   *  SDL_MapRGBA
   *}

function SDL_MapRGB(const format: PSDLPixelFormat; r: UInt8; g: UInt8; b: UInt8): UInt32 cdecl external {$IFDEF GPC} name 'SDL_MapRGB' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Maps an RGBA quadruple to a pixel value for a given pixel format.
   *
   *  SDL_MapRGB
   *}

function SDL_MapRGBA(const format: PSDLPixelFormat; r: UInt8; g: UInt8; b: UInt8; a: UInt8): UInt32 cdecl external {$IFDEF GPC} name 'SDL_MapRGBA' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the RGB components from a pixel of the specified format.
   *
   *  SDL_GetRGBA
   *}

procedure SDL_GetRGB(pixel: UInt32; const format: PSDLPixelFormat; r: PUInt8; g: PUInt8; b: PUInt8) cdecl external {$IFDEF GPC} name 'SDL_GetRGB' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the RGBA components from a pixel of the specified format.
   *
   *  SDL_GetRGB
   *}

procedure SDL_GetRGBA(pixel: UInt32; const format: PSDLPixelFormat; r: PUInt8; g: PUInt8; b: PUInt8; a: PUInt8) cdecl external {$IFDEF GPC} name 'SDL_GetRGBA' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Calculate a 256 entry gamma ramp for a gamma value.
   *}

procedure SDL_CalculateGammaRamp(gamma: Float; ramp: PUInt16) cdecl external {$IFDEF GPC} name 'SDL_CalculateGammaRamp' {$ELSE} SDL_LibName {$ENDIF};

//from "sdl_rect.h"

type
  {**
   *  The structure that defines a point
   *
   *  SDL_EnclosePoints
   *}

  PSDLPoint = ^TSDLPoint;
  TSDLPoint = record
    x: SInt32;
    y: SInt32;
  end;

  {**
   *  A rectangle, with the origin at the upper left.
   *
   *  SDL_RectEmpty
   *  SDL_RectEquals
   *  SDL_HasIntersection
   *  SDL_IntersectRect
   *  SDL_UnionRect
   *  SDL_EnclosePoints
   *}

  PSDLRect = ^TSDLRect;
  TSDLRect = record
    x,y: SInt32;
    w,h: SInt32;
  end;

  {**
   *  Returns true if the rectangle has no area.
   *}

//changed from variant(b�����h!) to TSDLRect
//maybe PSDLRect?
function SDL_RectEmpty(X: TSDLRect): Boolean;

  {**
   *  Returns true if the two rectangles are equal.
   *}

function SDL_RectEquals(A: TSDLRect; B: TSDLRect): Boolean;

{**
 *  Determine whether two rectangles intersect.
 *  
 *  SDL_TRUE if there is an intersection, SDL_FALSE otherwise.
 *}

function SDL_HasIntersection(const A: PSDLRect; const B: PSDLRect): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_HasIntersection' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Calculate the intersection of two rectangles.
 *  
 *  SDL_TRUE if there is an intersection, SDL_FALSE otherwise.
 *}

function SDL_IntersectRect(const A: PSDLRect; const B: PSDLRect; result: PSDLRect): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_IntersectRect' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Calculate the union of two rectangles.
 *}

procedure SDL_UnionRect(const A: PSDLRect; const B: PSDLRect; result: PSDLRect) cdecl external {$IFDEF GPC} name 'SDL_UnionRect' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Calculate a minimal rectangle enclosing a set of points
 *
 *  SDL_TRUE if any points were within the clipping rect
 *}

function SDL_EnclosePoints(const points: PSDLPoint; count: SInt32; const clip: PSDLRect; result: PSDLRect): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_EnclosePoints' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Calculate the intersection of a rectangle and line segment.
 *
 *  SDL_TRUE if there is an intersection, SDL_FALSE otherwise.
 *}

function SDL_IntersectRectAndLine(const rect: PSDLRect; X1: PInt; Y1: PInt; X2: PInt; Y2: PInt): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_IntersectRectAndLine' {$ELSE} SDL_LibName {$ENDIF};

//from "sdl_rwops"

const
  {* RWops Types *}
  SDL_RWOPS_UNKNOWN	  = 0	{* Unknown stream type *}
  SDL_RWOPS_WINFILE	  = 1	{* Win32 file *}
  SDL_RWOPS_STDFILE	  = 2	{* Stdio file *}
  SDL_RWOPS_JNIFILE	  = 3	{* Android asset *}
  SDL_RWOPS_MEMORY    =	4	{* Memory stream *}
  SDL_RWOPS_MEMORY_RO =	5	{* Read-Only memory stream *}

type
  {**
   * This is the read/write operation structure -- very basic.
   *}

  {**
   *  Return the size of the file in this rwops, or -1 if unknown
   *}
  TSize = function(context: PSDLRWops): SInt64;
  
  {**
   *  Seek to offset relative to whence, one of stdio's whence values:
   *  RW_SEEK_SET, RW_SEEK_CUR, RW_SEEK_END
   *
   *  the final offset in the data stream, or -1 on error.
   *}
  TSeek = function(context: PSDLRWops; offset: SInt64; whence: SInt32): SInt64;
                   
  {**
   *  Read up to maxnum objects each of size size from the data
   *  stream to the area pointed at by ptr.
   *
   *  the number of objects read, or 0 at error or end of file.
   *}

   TSize_t = function(context: PSDLRWops; ptr: Pointer; size);

  TSDLRWops = packed record;
    size: TSize;
    seek: TSeek;
    read:

    size_t (SDLCALL * read) (struct SDL_RWops * context, void *ptr,
                             size_t size, size_t maxnum);

    {**
     *  Write exactly num objects each of size size from the area
     *  pointed at by ptr to data stream.
     *  
     *  the number of objects written, or 0 at error or end of file.
     *}
    size_t (SDLCALL * write) (struct SDL_RWops * context, const void *ptr,
                              size_t size, size_t num);

    {**
     *  Close and free an allocated SDL_RWops structure.
     *  
     *  0 if successful or -1 on write error when flushing data.
     *}
    int (SDLCALL * close) (struct SDL_RWops * context);

    Uint32 type;
    union
    {
#if defined(ANDROID)
        struct
        {
            void *fileNameRef;
            void *inputStreamRef;
            void *readableByteChannelRef;
            void *readMethod;
            void *assetFileDescriptorRef;
            long position;
            long size;
            long offset;
            int fd;
        } androidio;
#elif defined(__WIN32__)
        struct
        {
            SDL_bool append;
            void *h;
            struct
            {
                void *data;
                size_t size;
                size_t left;
            } buffer;
        } windowsio;
#endif

#ifdef HAVE_STDIO_H
        struct
        {
            SDL_bool autoclose;
            FILE *fp;
        } stdio;
#endif
        struct
        {
            Uint8 *base;
            Uint8 *here;
            Uint8 *stop;
        } mem;
        struct
        {
            void *data1;
        } unknown;
    } hidden;

} SDL_RWops;


{**
 *  RWFrom functions
 *  
 *  Functions to create SDL_RWops structures from various data streams.
 *}

extern DECLSPEC SDL_RWops *SDLCALL SDL_RWFromFile(const char *file,
                                                  const char *mode);

#ifdef HAVE_STDIO_H
extern DECLSPEC SDL_RWops *SDLCALL SDL_RWFromFP(FILE * fp,
                                                SDL_bool autoclose);
#else
extern DECLSPEC SDL_RWops *SDLCALL SDL_RWFromFP(void * fp,
                                                SDL_bool autoclose);
#endif

extern DECLSPEC SDL_RWops *SDLCALL SDL_RWFromMem(void *mem, int size);
extern DECLSPEC SDL_RWops *SDLCALL SDL_RWFromConstMem(const void *mem,
                                                      int size);

/*@}*//*RWFrom functions*/


extern DECLSPEC SDL_RWops *SDLCALL SDL_AllocRW(void);
extern DECLSPEC void SDLCALL SDL_FreeRW(SDL_RWops * area);

#define RW_SEEK_SET	0       /**< Seek from the beginning of data */
#define RW_SEEK_CUR	1       /**< Seek relative to current read point */
#define RW_SEEK_END	2       /**< Seek relative to the end of data */

/**
 *  \name Read/write macros
 *  
 *  Macros to easily read and write from an SDL_RWops structure.
 */
/*@{*/
#define SDL_RWsize(ctx)	        (ctx)->size(ctx)
#define SDL_RWseek(ctx, offset, whence)	(ctx)->seek(ctx, offset, whence)
#define SDL_RWtell(ctx)			(ctx)->seek(ctx, 0, RW_SEEK_CUR)
#define SDL_RWread(ctx, ptr, size, n)	(ctx)->read(ctx, ptr, size, n)
#define SDL_RWwrite(ctx, ptr, size, n)	(ctx)->write(ctx, ptr, size, n)
#define SDL_RWclose(ctx)		(ctx)->close(ctx)
/*@}*//*Read/write macros*/


/** 
 *  \name Read endian functions
 *  
 *  Read an item of the specified endianness and return in native format.
 */
/*@{*/
extern DECLSPEC Uint8 SDLCALL SDL_ReadU8(SDL_RWops * src);
extern DECLSPEC Uint16 SDLCALL SDL_ReadLE16(SDL_RWops * src);
extern DECLSPEC Uint16 SDLCALL SDL_ReadBE16(SDL_RWops * src);
extern DECLSPEC Uint32 SDLCALL SDL_ReadLE32(SDL_RWops * src);
extern DECLSPEC Uint32 SDLCALL SDL_ReadBE32(SDL_RWops * src);
extern DECLSPEC Uint64 SDLCALL SDL_ReadLE64(SDL_RWops * src);
extern DECLSPEC Uint64 SDLCALL SDL_ReadBE64(SDL_RWops * src);
/*@}*//*Read endian functions*/

/** 
 *  \name Write endian functions
 *  
 *  Write an item of native format to the specified endianness.
 */
/*@{*/
extern DECLSPEC size_t SDLCALL SDL_WriteU8(SDL_RWops * dst, Uint8 value);
extern DECLSPEC size_t SDLCALL SDL_WriteLE16(SDL_RWops * dst, Uint16 value);
extern DECLSPEC size_t SDLCALL SDL_WriteBE16(SDL_RWops * dst, Uint16 value);
extern DECLSPEC size_t SDLCALL SDL_WriteLE32(SDL_RWops * dst, Uint32 value);
extern DECLSPEC size_t SDLCALL SDL_WriteBE32(SDL_RWops * dst, Uint32 value);
extern DECLSPEC size_t SDLCALL SDL_WriteLE64(SDL_RWops * dst, Uint64 value);
extern DECLSPEC size_t SDLCALL SDL_WriteBE64(SDL_RWops * dst, Uint64 value);
/*@}*//*Write endian functions*/

const
  {**
   *  Surface flags
   *
   *  These are the currently supported flags for the ::SDL_surface.
   *
   *  Used internally (read-only).
   *}

  SDL_SWSURFACE = 0;          {**< Just here for compatibility *}
  SDL_PREALLOC  = $00000001;  {**< Surface uses preallocated memory *}
  SDL_RLEACCEL  = $00000002;  {**< Surface is RLE encoded *}
  SDL_DONTFREE  = $00000004;  {**< Surface is referenced internally *}

  {*Surface flags*}

  {**
   *  Evaluates to true if the surface needs to be locked before access.
   *}

  //SDL_MUSTLOCK(S)	(((S)->flags & SDL_RLEACCEL) != 0)

type
  {**
   *  A collection of pixels used in software blitting.
   *
   *  This structure should be treated as read-only, except for \c pixels,
   *  which, if not NULL, contains the raw pixel data for the surface.
   *}

  PSDLBlitMap = ^TSDLBlitMap;
  TSDLBlitMap = record
    map: Pointer;
  end;

  PSDLSurface = ^TSDLSurface;
  TSDLSurface = record
    flags: UInt32;              {**< Read-only *}
    format: PSDLPixelFormat;    {**< Read-only *}
    w, h: SInt32;               {**< Read-only *}
    pitch: SInt32;              {**< Read-only *}
    pixels: Pointer;            {**< Read-write *}

    {** Application data associated with the surface *}
    userdata: Pointer;          {**< Read-write *}

    {** information needed for surfaces requiring locks *}
    locked: SInt32;             {**< Read-only *}
    lock_data: Pointer;         {**< Read-only *}

    {** clipping information *}
    clip_rect: PSDLRect;        {**< Read-only *}

    {** info for fast blit mapping to other surfaces *}
    map: Pointer;               {**< Private *} //SDL_BlitMap

    {** Reference count -- used when freeing surface *}
    refcount: SInt32;           {**< Read-mostly *}
  end;

  {**
   *  The type of function used for surface blitting functions.
   *}

   TSDLBlit = function(src: PSDLSurface; srcrect: PSDLRect; dst: PSDLSurface; dstrect: PSDLRect): SInt32;

  {**
   *  Allocate and free an RGB surface.
   *
   *  If the depth is 4 or 8 bits, an empty palette is allocated for the surface.
   *  If the depth is greater than 8 bits, the pixel format is set using the
   *  flags '[RGB]mask'.
   *
   *  If the function runs out of memory, it will return NULL.
   *
   *  flags The flags are obsolete and should be set to 0.
   *}

  function SDL_CreateRGBSurface(flags: UInt32; width: SInt32; height: SInt32; depth: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): PSDLSurface cdecl external {$IFDEF GPC} name 'SDL_CreateRGBSurface' {$ELSE} SDL_LibName {$ENDIF};
  function SDL_CreateRGBSurfaceFrom(pixels: Pointer; width: SInt32; height: SInt32; depth: SInt32; pitch: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): PSDLSurface cdecl external {$IFDEF GPC} name 'SDL_CreateRGBSurfaceFrom' {$ELSE} SDL_LibName {$ENDIF};
  procedure SDL_FreeSurface(surface: PSDLSurface) cdecl external {$IFDEF GPC} name 'SDL_FreeSurface' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the palette used by a surface.
   *
   *  0, or -1 if the surface format doesn't use a palette.
   *
   *  A single palette can be shared with many surfaces.
   *}

  function SDL_SetSurfacePalette(surface: PSDLSurface; palette: PSDLPalette): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetSurfacePalette' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Sets up a surface for directly accessing the pixels.
   *
   *  Between calls to SDL_LockSurface() / SDL_UnlockSurface(), you can write
   *  to and read from surface.pixels, using the pixel format stored in
   *  surface.format. Once you are done accessing the surface, you should
   *  use SDL_UnlockSurface() to release it.
   *
   *  Not all surfaces require locking.  If SDL_MUSTLOCK(surface) evaluates
   *  to 0, then you can read and write to the surface at any time, and the
   *  pixel format of the surface will not change.
   *
   *  No operating system or library calls should be made between lock/unlock
   *  pairs, as critical system locks may be held during this time.
   *
   *  SDL_LockSurface() returns 0, or -1 if the surface couldn't be locked.
   *
   *  SDL_UnlockSurface()
   *}

  function SDL_LockSurface(surface: PSDLSurface): SInt32 cdecl external {$IFDEF GPC} name 'SDL_LockSurface' {$ELSE} SDL_LibName {$ENDIF};

  {** SDL_LockSurface() *}

  procedure SDL_UnlockSurface(surface: PSDLSurface) cdecl external {$IFDEF GPC} name 'SDL_UnlockSurface' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Load a surface from a seekable SDL data stream (memory or file).
   *
   *  If freesrc is non-zero, the stream will be closed after being read.
   *
   *  The new surface should be freed with SDL_FreeSurface().
   *
   *  the new surface, or NULL if there was an error.
   *}

  function SDL_LoadBMP_RW(src: PSDLRWops; freesrc: SInt32): PSDLSurface cdecl external {$IFDEF GPC} name 'SDL_LoadBMP_RW' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Load a surface from a file.
   *
   *  Convenience macro.
   *}

  function SDL_LoadBMP(file: AnsiString): PSDLSurface;

  {**
   *  Save a surface to a seekable SDL data stream (memory or file).
   *
   *  If freedst is non-zero, the stream will be closed after being written.
   *
   *  0 if successful or -1 if there was an error.
   *}

function SDL_SaveBMP_RW(surface: PSDLSurface; dst: PSDLRWops; freedst: SInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_LoadBMP_RW' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Save a surface to a file.
   *
   *  Convenience macro.
   *}

#define SDL_SaveBMP(surface, file) \
		SDL_SaveBMP_RW(surface, SDL_RWFromFile(file, "wb"), 1)

{**
 *  Sets the RLE acceleration hint for a surface.
 *  
 *  0 on success, or -1 if the surface is not valid
 *  
 *  If RLE is enabled, colorkey and alpha blending blits are much faster,
 *  but the surface must be locked before directly accessing the pixels.
 *}

function SDL_SetSurfaceRLE(surface: PSDLSurface; flag: SInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetSurfaceRLE' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Sets the color key (transparent pixel) in a blittable surface.
 *
 *  surface The surface to update
 *  flag Non-zero to enable colorkey and 0 to disable colorkey
 *  key The transparent pixel in the native surface format
 *  
 *  0 on success, or -1 if the surface is not valid
 *
 *  You can pass SDL_RLEACCEL to enable RLE accelerated blits.
 *}

function SDL_SetColorKey(surface: PSDLSurface; flag: SInt32; key: UInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetColorKey' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Gets the color key (transparent pixel) in a blittable surface.
 *  
 *  surface The surface to update
 *  key A pointer filled in with the transparent pixel in the native
 *      surface format
 *  
 *  0 on success, or -1 if the surface is not valid or colorkey is not
 *  enabled.
 *}

function SDL_GetColorKey(surface: PSDLSurface; key: PUInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetColorKey' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Set an additional color value used in blit operations.
 *  
 *  surface The surface to update.
 *  r The red color value multiplied into blit operations.
 *  g The green color value multiplied into blit operations.
 *  b The blue color value multiplied into blit operations.
 *
 *  0 on success, or -1 if the surface is not valid.
 *
 *  SDL_GetSurfaceColorMod()
 *}

function SDL_SetSurfaceColorMod(surface: PSDLSurface; r: UInt8; g: UInt8; b: UInt8): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetSurfaceColorMod' {$ELSE} SDL_LibName {$ENDIF};


{**
 *  Get the additional color value used in blit operations.
 *  
 *  surface The surface to query.
 *  r A pointer filled in with the current red color value.
 *  g A pointer filled in with the current green color value.
 *  b A pointer filled in with the current blue color value.
 *  
 *  0 on success, or -1 if the surface is not valid.
 *  
 *  SDL_SetSurfaceColorMod()
 *}

function SDL_GetSurfaceColorMod(surface: PSDLSurface; r: UInt8; g: UInt8; b: UInt8): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetSurfaceColorMod' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Set an additional alpha value used in blit operations.
 *  
 *  surface The surface to update.
 *  alpha The alpha value multiplied into blit operations.
 *  
 *  0 on success, or -1 if the surface is not valid.
 *
 *  SDL_GetSurfaceAlphaMod()
 *}

function SDL_SetSurfaceAlphaMod(surface: PSDLSurface; alpha: UInt8): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetSurfaceAlphaMod' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Get the additional alpha value used in blit operations.
 *  
 *  surface The surface to query.
 *  alpha A pointer filled in with the current alpha value.
 *  
 *  0 on success, or -1 if the surface is not valid.
 *  
 *  SDL_SetSurfaceAlphaMod()
 *}

function SDL_GetSurfaceAlphaMod(surface: PSDLSurface; alpha: PUInt8): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetSurfaceAlphaMod' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Set the blend mode used for blit operations.
 *  
 *  surface The surface to update.
 *  blendMode ::SDL_BlendMode to use for blit blending.
 *  
 *  0 on success, or -1 if the parameters are not valid.
 *  
 *  SDL_GetSurfaceBlendMode()
 *}

function SDL_SetSurfaceBlendMode(surface: PSDLSurface; blendMode: TSDLBlendMode): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetSurfaceBlendMode' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Get the blend mode used for blit operations.
 *  
 *  surface   The surface to query.
 *  blendMode A pointer filled in with the current blend mode.
 *  
 *  0 on success, or -1 if the surface is not valid.
 *  
 *  SDL_SetSurfaceBlendMode()
 *}

function SDL_GetSurfaceBlendMode(surface: PSDLSurface; blendMode: PSDLBlendMode): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetSurfaceBlendMode' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Sets the clipping rectangle for the destination surface in a blit.
 *  
 *  If the clip rectangle is NULL, clipping will be disabled.
 *  
 *  If the clip rectangle doesn't intersect the surface, the function will
 *  return SDL_FALSE and blits will be completely clipped.  Otherwise the
 *  function returns SDL_TRUE and blits to the surface will be clipped to
 *  the intersection of the surface area and the clipping rectangle.
 *
 *  Note that blits are automatically clipped to the edges of the source
 *  and destination surfaces.
 *}

function SDL_SetClipRect(surface: PSDLSurface; const rect: PSDLRect): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_SetClipRect' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Gets the clipping rectangle for the destination surface in a blit.
 *
 *  rect must be a pointer to a valid rectangle which will be filled
 *  with the correct values.
 *}

procedure SDL_GetClipRect(surface: PSDLSurface; rect: PSDLRect) cdecl external {$IFDEF GPC} name 'SDL_GetClipRect' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Creates a new surface of the specified format, and then copies and maps
 *  the given surface to it so the blit of the converted surface will be as
 *  fast as possible.  If this function fails, it returns NULL.
 *
 *  The flags parameter is passed to SDL_CreateRGBSurface() and has those
 *  semantics.  You can also pass SDL_RLEACCEL in the flags parameter and
 *  SDL will try to RLE accelerate colorkey and alpha blits in the resulting
 *  surface.
 *}

function SDL_ConvertSurface(src: PSDLSurface; fmt: PSDLPixelFormat; flags: UInt32): PSDLSurface cdecl external {$IFDEF GPC} name 'SDL_ConvertSurface' {$ELSE} SDL_LibName {$ENDIF};
function SDL_ConvertSurfaceFormat(src: PSDLSurface; pixel_format: UInt32; flags: UInt32): PSDLSurface cdecl external {$IFDEF GPC} name 'SDL_ConvertSurfaceFormat' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Copy a block of pixels of one format to another format
 *
 *  0 on success, or -1 if there was an error
 *}

function SDL_ConvertPixels(width: SInt32; height: SInt32; src_format: UInt32; const src: Pointer; src_pitch: SInt32; Uint32 dst_format; dst: Pointer; dst_pitch: SInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_ConvertPixels' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Performs a fast fill of the given rectangle with color.
 *  
 *  If rect is NULL, the whole surface will be filled with color.
 *  
 *  The color should be a pixel of the format used by the surface, and 
 *  can be generated by the SDL_MapRGB() function.
 *  
 *  0 on success, or -1 on error.
 *}

function SDL_FillRect(dst: PSDLSurface; const rect: PSDLRect; color: UInt32): SInt32;
function SDL_FillRects(dst: PSDLSurface; const rects: PSDLRect; count: SInt32; color: UInt32): SInt32;

{**
 *  Performs a fast blit from the source surface to the destination surface.
 *  
 *  This assumes that the source and destination rectangles are
 *  the same size.  If either \c srcrect or \c dstrect are NULL, the entire
 *  surface ( src or  dst) is copied.  The final blit rectangles are saved
 *  in srcrect and dstrect after all clipping is performed.
 *  
 *  If the blit is successful, it returns 0, otherwise it returns -1.
 *
 *  The blit function should not be called on a locked surface.
 *
 *  The blit semantics for surfaces with and without alpha and colorkey
 *  are defined as follows:
 *
    RGBA->RGB:
      SDL_SRCALPHA set:
        alpha-blend (using alpha-channel).
        SDL_SRCCOLORKEY ignored.
      SDL_SRCALPHA not set:
        copy RGB.
        if SDL_SRCCOLORKEY set, only copy the pixels matching the
        RGB values of the source colour key, ignoring alpha in the
        comparison.
   
    RGB->RGBA:
      SDL_SRCALPHA set:
        alpha-blend (using the source per-surface alpha value);
        set destination alpha to opaque.
      SDL_SRCALPHA not set:
        copy RGB, set destination alpha to source per-surface alpha value.
      both:
        if SDL_SRCCOLORKEY set, only copy the pixels matching the
        source colour key.
   
    RGBA->RGBA:
      SDL_SRCALPHA set:
        alpha-blend (using the source alpha channel) the RGB values;
        leave destination alpha untouched. [Note: is this correct?]
        SDL_SRCCOLORKEY ignored.
      SDL_SRCALPHA not set:
        copy all of RGBA to the destination.
        if SDL_SRCCOLORKEY set, only copy the pixels matching the
        RGB values of the source colour key, ignoring alpha in the
       comparison.
   
    RGB->RGB: 
      SDL_SRCALPHA set:
        alpha-blend (using the source per-surface alpha value).
      SDL_SRCALPHA not set:
        copy RGB.
      both:
        if SDL_SRCCOLORKEY set, only copy the pixels matching the
        source colour key.r
 *  
 *  You should call SDL_BlitSurface() unless you know exactly how SDL
 *  blitting works internally and how to use the other blit functions.
 *}

SDL_BlitSurface = SDL_UpperBlit;

{**
 *  This is the public blit function, SDL_BlitSurface(), and it performs
 *  rectangle validation and clipping before passing it to SDL_LowerBlit()
 *}

function SDL_UpperBlit(src: PSDLSurface; const srcrect: PSDLRect; dst: PSDLSurface; dstrect: PSDLRect): SInt32 cdecl external {$IFDEF GPC} name 'SDL_UpperBlit' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  This is a semi-private blit function and it performs low-level surface
 *  blitting only.
 *}

function SDL_LowerBlit(src: PSDLSurface; srcrect: PSDLRect; dst: PSDLSurface; dstrect: PSDLRect): SInt32 cdecl external {$IFDEF GPC} name 'SDL_LowerBlit' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  Perform a fast, low quality, stretch blit between two surfaces of the
 *  same pixel format.
 *  
 *  This function uses a static buffer, and is not thread-safe.
 *}

function SDL_SoftStretch(src: PSDLSurface; const srcrect: PSDLRect; dst: PSDLSurface; const dstrect: PSDLSurface) cdecl external {$IFDEF GPC} name 'SDL_SoftStretch' {$ELSE} SDL_LibName {$ENDIF};

SDL_BlitScaled = SDL_UpperBlitScaled;

{**
 *  This is the public scaled blit function, SDL_BlitScaled(), and it performs
 *  rectangle validation and clipping before passing it to SDL_LowerBlitScaled()
 *}

extern DECLSPEC int SDLCALL SDL_UpperBlitScaled
    (SDL_Surface * src, const SDL_Rect * srcrect,
    SDL_Surface * dst, SDL_Rect * dstrect);

{**
 *  This is a semi-private blit function and it performs low-level surface
 *  scaled blitting only.
 *}

extern DECLSPEC int SDLCALL SDL_LowerBlitScaled
    (SDL_Surface * src, SDL_Rect * srcrect,
    SDL_Surface * dst, SDL_Rect * dstrect);

//from "sdl_video.h"
type
  {**
   *  The structure that defines a display mode
   *
   *   SDL_GetNumDisplayModes()
   *   SDL_GetDisplayMode()
   *   SDL_GetDesktopDisplayMode()
   *   SDL_GetCurrentDisplayMode()
   *   SDL_GetClosestDisplayMode()
   *   SDL_SetWindowDisplayMode()
   *   SDL_GetWindowDisplayMode()
   *}

  PSDLDisplayMode = ^TSDLDisplayMode;
  TSDLDisplayMode = record
    format: Uint32;              {**< pixel format *}
    w: SInt32;                   {**< width *}
    h: SInt32;                   {**< height *}
    refresh_rate: SInt32;        {**< refresh rate (or zero for unspecified) *}
    driverdata: Pointer;         {**< driver-specific data, initialize to 0 *}
  end;

  {**
   *  The type used to identify a window
   *  
   *   SDL_CreateWindow()
   *   SDL_CreateWindowFrom()
   *   SDL_DestroyWindow()
   *   SDL_GetWindowData()
   *   SDL_GetWindowFlags()
   *   SDL_GetWindowGrab()
   *   SDL_GetWindowPosition()
   *   SDL_GetWindowSize()
   *   SDL_GetWindowTitle()
   *   SDL_HideWindow()
   *   SDL_MaximizeWindow()
   *   SDL_MinimizeWindow()
   *   SDL_RaiseWindow()
   *   SDL_RestoreWindow()
   *   SDL_SetWindowData()
   *   SDL_SetWindowFullscreen()
   *   SDL_SetWindowGrab()
   *   SDL_SetWindowIcon()
   *   SDL_SetWindowPosition()
   *   SDL_SetWindowSize()
   *   SDL_SetWindowBordered()
   *   SDL_SetWindowTitle()
   *   SDL_ShowWindow()
   *}

  //typedef struct SDL_Window SDL_Window;

const
  {**
   *  The flags on a window
   *  
   *   SDL_GetWindowFlags()
   *}

  SDL_WINDOW_FULLSCREEN = $00000001;         {**< fullscreen window *}
  SDL_WINDOW_OPENGL = $00000002;             {**< window usable with OpenGL context *}
  SDL_WINDOW_SHOWN = $00000004;              {**< window is visible *}
  SDL_WINDOW_HIDDEN = $00000008;             {**< window is not visible *}
  SDL_WINDOW_BORDERLESS = $00000010;         {**< no window decoration *}
  SDL_WINDOW_RESIZABLE = $00000020;          {**< window can be resized *}
  SDL_WINDOW_MINIMIZED = $00000040;          {**< window is minimized *}
  SDL_WINDOW_MAXIMIZED = $00000080;          {**< window is maximized *}
  SDL_WINDOW_INPUT_GRABBED = $00000100;      {**< window has grabbed input focus *}
  SDL_WINDOW_INPUT_FOCUS = $00000200;        {**< window has input focus *}
  SDL_WINDOW_MOUSE_FOCUS = $00000400;        {**< window has mouse focus *}
  SDL_WINDOW_FULLSCREEN_DESKTOP = SDL_WINDOW_FULLSCREEN or $00001000;
  SDL_WINDOW_FOREIGN = $00000800;            {**< window not created by SDL *}

type
  TSDL_WindowFlags = DWord;

function SDL_WindowPos_IsUndefined(X: Variant): Variant;
function SDL_WindowPos_IsCentered(X: Variant): Variant;

const
   {**
   *  Used to indicate that you don't care what the window position is.
   *}

  SDL_WINDOWPOS_UNDEFINED_MASK = $1FFF0000;
  SDL_WINDOWPOS_UNDEFINED = SDL_WINDOWPOS_UNDEFINED_MASK or 0;


  {**
   *  Used to indicate that the window position should be centered.
   *}

  SDL_WINDOWPOS_CENTERED_MASK = $2FFF0000;
  SDL_WINDOWPOS_CENTERED = SDL_WINDOWPOS_CENTERED_MASK or 0;

  {**
   *  Event subtype for window events
   *}

  SDL_WINDOWEVENT_NONE = 0;           {**< Never used *}
  SDL_WINDOWEVENT_SHOWN = 1;          {**< Window has been shown *}
  SDL_WINDOWEVENT_HIDDEN = 2;         {**< Window has been hidden *}
  SDL_WINDOWEVENT_EXPOSED = 3;        {**< Window has been exposed and should be redrawn *}
  SDL_WINDOWEVENT_MOVED = 4;          {**< Window has been moved to data1; data2 *}
  SDL_WINDOWEVENT_RESIZED = 5;        {**< Window has been resized to data1xdata2 *}
  SDL_WINDOWEVENT_SIZE_CHANGED = 6;   {**< The window size has changed; either as a result of an API call or through the system or user changing the window size. *}
  SDL_WINDOWEVENT_MINIMIZED = 7;      {**< Window has been minimized *}
  SDL_WINDOWEVENT_MAXIMIZED = 8;      {**< Window has been maximized *}
  SDL_WINDOWEVENT_RESTORED = 9;       {**< Window has been restored to normal size and position *}
  SDL_WINDOWEVENT_ENTER = 10;          {**< Window has gained mouse focus *}
  SDL_WINDOWEVENT_LEAVE = 11;          {**< Window has lost mouse focus *}
  SDL_WINDOWEVENT_FOCUS_GAINED = 12;   {**< Window has gained keyboard focus *}
  SDL_WINDOWEVENT_FOCUS_LOST = 13;     {**< Window has lost keyboard focus *}
  SDL_WINDOWEVENT_CLOSE = 14;          {**< The window manager requests that the window be closed *}

type
  TSDLWindowEventID = DWord;

  {**
   *  An opaque handle to an OpenGL context.
   *}

  TSDLGLContext = Pointer;

  {**
   *  OpenGL configuration attributes
   *}
   
const
  SDL_GL_RED_SIZE = 0;
  SDL_GL_GREEN_SIZE = 1;
  SDL_GL_BLUE_SIZE = 2;
  SDL_GL_ALPHA_SIZE = 3;
  SDL_GL_BUFFER_SIZE = 4;
  SDL_GL_DOUBLEBUFFER = 5;
  SDL_GL_DEPTH_SIZE = 6;
  SDL_GL_STENCIL_SIZE = 7;
  SDL_GL_ACCUM_RED_SIZE = 8;
  SDL_GL_ACCUM_GREEN_SIZE = 9;
  SDL_GL_ACCUM_BLUE_SIZE = 10;
  SDL_GL_ACCUM_ALPHA_SIZE = 11;
  SDL_GL_STEREO = 12;
  SDL_GL_MULTISAMPLEBUFFERS = 13;
  SDL_GL_MULTISAMPLESAMPLES = 14;
  SDL_GL_ACCELERATED_VISUAL = 15;
  SDL_GL_RETAINED_BACKING = 16;
  SDL_GL_CONTEXT_MAJOR_VERSION = 17;
  SDL_GL_CONTEXT_MINOR_VERSION = 18;
  SDL_GL_CONTEXT_EGL = 19;
  SDL_GL_CONTEXT_FLAGS = 20;
  SDL_GL_CONTEXT_PROFILE_MASK = 21;
  SDL_GL_SHARE_WITH_CURRENT_CONTEXT = 22;

type
  TSDL_GLattr = DWord;

const
  SDL_GL_CONTEXT_PROFILE_CORE           = $0001;
  SDL_GL_CONTEXT_PROFILE_COMPATIBILITY  = $0002;
  SDL_GL_CONTEXT_PROFILE_ES             = $0004;

type
  TSDL_GLprofile = DWord;

const
  SDL_GL_CONTEXT_DEBUG_FLAG              = $0001;
  SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = $0002;
  SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG      = $0004;
  SDL_GL_CONTEXT_RESET_ISOLATION_FLAG    = $0008;

type
  TSDL_GLcontextFlag = DWord;

  {* Function prototypes *}

  {**
   *  Get the number of video drivers compiled into SDL
   *
   *  SDL_GetVideoDriver()
   *}

  function SDL_GetNumVideoDrivers: SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetNumVideoDrivers' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the name of a built in video driver.
   *
   *  The video drivers are presented in the order in which they are
   *  normally checked during initialization.
   *
   *  SDL_GetNumVideoDrivers()
   *}

  function SDL_GetVideoDriver(index: SInt32): PChar cdecl external {$IFDEF GPC} name 'SDL_GetVideoDriver' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Initialize the video subsystem, optionally specifying a video driver.
   *  
   *  driver_name Initialize a specific driver by name, or nil for the
   *  default video driver.
   *  
   *  0 on success, -1 on error
   *  
   *  This function initializes the video subsystem; setting up a connection
   *  to the window manager, etc, and determines the available display modes
   *  and pixel formats, but does not initialize a window or graphics mode.
   *  
   *  SDL_VideoQuit()
   *}

  function SDL_VideoInit(const driver_name: PChar): SInt32 cdecl external {$IFDEF GPC} name 'SDL_VideoInit' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Shuts down the video subsystem.
   *  
   *  function closes all windows, and restores the original video mode.
   *  
   *  SDL_VideoInit()
   *}
  procedure SDL_VideoQuit cdecl external {$IFDEF GPC} name 'SDL_VideoQuit' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Returns the name of the currently initialized video driver.
   *
   *  The name of the current video driver or nil if no driver
   *  has been initialized
   *  
   *  SDL_GetNumVideoDrivers()
   *  SDL_GetVideoDriver()
   *}

  function SDL_GetCurrentVideoDriver: PChar cdecl external {$IFDEF GPC} name 'SDL_GetCurrentVideoDriver' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Returns the number of available video displays.
   *  
   *  SDL_GetDisplayBounds()
   *}

  function SDL_GetNumVideoDisplays: SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetNumVideoDisplays' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the name of a display in UTF-8 encoding
   *
   *  The name of a display, or nil for an invalid display index.
   *  
   *  SDL_GetNumVideoDisplays()
   *}

  function SDL_GetDisplayName(displayIndex: SInt32): PChar cdecl external {$IFDEF GPC} name 'SDL_GetDisplayName' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the desktop area represented by a display, with the primary
   *  display located at 0,0
   *  
   *  0 on success, or -1 if the index is out of range.
   *  
   *  SDL_GetNumVideoDisplays()
   *}

  function SDL_GetDisplayBounds(displayIndex: SInt32; rect: PSDLRect): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetDisplayBounds' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Returns the number of available display modes.
   *  
   *  SDL_GetDisplayMode()
   *}

  function SDL_GetNumDisplayModes(displayIndex: SInt32): SInt32;

  {**
   *  Fill in information about a specific display mode.
   *
   *  The display modes are sorted in this priority:
   *        bits per pixel -> more colors to fewer colors
   *        width -> largest to smallest
   *        height -> largest to smallest
   *        refresh rate -> highest to lowest
   *
   *  SDL_GetNumDisplayModes()
   *}

  function SDL_GetDisplayMode(displayIndex: SInt32; modeIndex: SInt32; mode: PSDLDisplayMode): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetDisplayMode' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Fill in information about the desktop display mode.
   *}

  function SDL_GetDesktopDisplayMode(displayIndex: SInt32; mode: PSDLDisplayMode): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetDesktopDisplayMode' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Fill in information about the current display mode.
   *}

  function SDL_GetCurrentDisplayMode(displayIndex: SInt32; mode: PSDLDisplayMode): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetCurrentDisplayIndex' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the closest match to the requested display mode.
   *  
   *  mode The desired display mode
   *  closest A pointer to a display mode to be filled in with the closest
   *  match of the available display modes.
   *  
   *  The passed in value closest, or nil if no matching video mode
   *  was available.
   *  
   *  The available display modes are scanned, and closest is filled in with the
   *  closest mode matching the requested mode and returned.  The mode format and 
   *  refresh_rate default to the desktop mode if they are 0.  The modes are 
   *  scanned with size being first priority, format being second priority, and 
   *  finally checking the refresh_rate.  If all the available modes are too 
   *  small, then nil is returned.
   *  
   *  SDL_GetNumDisplayModes()
   *  SDL_GetDisplayMode()
   *}

  function SDL_GetClosestDisplayMode(displayIndex: SInt32; const mode: PSDLDisplayMode; closest: PSDLDisplayMode): PSDLDisplayMode cdecl external {$IFDEF GPC} name 'SDL_GetClosestDisplayMode' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the display index associated with a window.
   *  
   *  the display index of the display containing the center of the
   *  window, or -1 on error.
   *}

  function SDL_GetWindowDisplayIndex(window: PSDLWindow): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetWindowDisplayIndex' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the display mode used when a fullscreen window is visible.
   *
   *  By default the window's dimensions and the desktop format and refresh rate
   *  are used.
   *  
   *  mode The mode to use, or nil for the default mode.
   *  
   *  0 on success, or -1 if setting the display mode failed.
   *  
   *  SDL_GetWindowDisplayMode()
   *  SDL_SetWindowFullscreen()
   *}

  function SDL_SetWindowDisplayMode(window: PSDLWindow; const mode: PSDLDisplayMode): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetWindowDisplayMode' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Fill in information about the display mode used when a fullscreen
   *  window is visible.
   *
   *  SDL_SetWindowDisplayMode()
   *  SDL_SetWindowFullscreen()
   *}

  function SDL_GetWindowDisplayMode(window: PSDLWindow; mode: PSDLDisplayMode): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetWindowDisplayMode' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the pixel format associated with the window.
   *}

  function SDL_GetWindowPixelFormat(window: PSDLWindow): UInt32 cdecl external {$IFDEF GPC} name 'SDL_GetWindowPixelFormat' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Create a window with the specified position, dimensions, and flags.
   *  
   *  title The title of the window, in UTF-8 encoding.
   *  x     The x position of the window, ::SDL_WINDOWPOS_CENTERED, or
   *               ::SDL_WINDOWPOS_UNDEFINED.
   *  y     The y position of the window, ::SDL_WINDOWPOS_CENTERED, or
   *               ::SDL_WINDOWPOS_UNDEFINED.
   *  w     The width of the window.
   *  h     The height of the window.
   *  flags The flags for the window, a mask of any of the following:
   *               ::SDL_WINDOW_FULLSCREEN, ::SDL_WINDOW_OPENGL, 
   *               ::SDL_WINDOW_SHOWN,      ::SDL_WINDOW_BORDERLESS, 
   *               ::SDL_WINDOW_RESIZABLE,  ::SDL_WINDOW_MAXIMIZED, 
   *               ::SDL_WINDOW_MINIMIZED,  ::SDL_WINDOW_INPUT_GRABBED.
   *  
   *  The id of the window created, or zero if window creation failed.
   *  
   *  SDL_DestroyWindow()
   *}

  function SDL_CreateWindow(const title: PChar; x: SInt32; y: SInt32; w: SInt32; h: SInt32; flags: UInt32): PSDLWindow cdecl external {$IFDEF GPC} name 'SDL_CreateWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Create an SDL window from an existing native window.
   *  
   *  data A pointer to driver-dependent window creation data
   *  
   *  The id of the window created, or zero if window creation failed.
   *
   *  SDL_DestroyWindow()
   *}

  function SDL_CreateWindowFrom(const data: Pointer): PSDLWindow cdecl external {$IFDEF GPC} name 'SDL_CreateWindowFrom' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the numeric ID of a window, for logging purposes.
   *}

  function SDL_GetWindowID(window: PSDLWindow): UInt32 cdecl external {$IFDEF GPC} name 'SDL_GetWindowID' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get a window from a stored ID, or nil if it doesn't exist.
   *}

  function SDL_GetWindowFromID(id: UInt32): PSDLWindow cdecl external {$IFDEF GPC} name 'SDL_GetWindowFromID' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the window flags.
   *}

  function SDL_GetWindowFlags(window: PSDLWindow): UInt32 cdecl external {$IFDEF GPC} name 'SDL_GetWindowFlags' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the title of a window, in UTF-8 format.
   *  
   *  SDL_GetWindowTitle()
   *}

  procedure SDL_SetWindowTitle(window: PSDLWindow; const title: PChar) cdecl external {$IFDEF GPC} name 'SDL_GetWindowTitle' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the title of a window, in UTF-8 format.
   *  
   *  SDL_SetWindowTitle()
   *}

  function SDL_GetWindowTitle(window: PSDLWindow): PChar cdecl external {$IFDEF GPC} name 'SDL_GetWindowTitle' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the icon for a window.
   *  
   *  icon The icon for the window.
   *}

  procedure SDL_SetWindowIcon(window: PSDLWindow; icon: PSDLSurface) cdecl external {$IFDEF GPC} name 'SDL_SetWindowIcon' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Associate an arbitrary named pointer with a window.
   *  
   *  window   The window to associate with the pointer.
   *  name     The name of the pointer.
   *  userdata The associated pointer.
   *
   *  The previous value associated with 'name'
   *
   *  The name is case-sensitive.
   *
   *  SDL_GetWindowData()
   *}

  function SDL_SetWindowData(window: PSDLWindow; const name: PChar; userdata: Pointer): Pointer cdecl external {$IFDEF GPC} name 'SDL_SetWindowData' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Retrieve the data pointer associated with a window.
   *  
   *  window   The window to query.
   *  name     The name of the pointer.
   *
   *  The value associated with 'name'
   *  
   *  SDL_SetWindowData()
   *}

  function SDL_GetWindowData(window: PSDLWindow; const name: PChar): Pointer cdecl external {$IFDEF GPC} name 'SDL_GetWindowData' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the position of a window.
   *  
   *  window   The window to reposition.
   *  x        The x coordinate of the window, SDL_WINDOWPOS_CENTERED, or
   *                  SDL_WINDOWPOS_UNDEFINED.
   *  y        The y coordinate of the window, SDL_WINDOWPOS_CENTERED, or
   *                  SDL_WINDOWPOS_UNDEFINED.
   *  
   *  The window coordinate origin is the upper left of the display.
   *  
   *  SDL_GetWindowPosition()
   *}

  procedure SDL_SetWindowPosition(window: PSDLWindow; x: SInt32; y: SInt32) cdecl external {$IFDEF GPC} name 'SDL_SetWindowPosition' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the position of a window.
   *  
   *  x        Pointer to variable for storing the x position, may be nil
   *  y        Pointer to variable for storing the y position, may be nil
   *
   *  SDL_SetWindowPosition()
   *}

  procedure SDL_GetWindowPosition(window: PSDLWindow; x: PInt; y: PInt) cdecl external {$IFDEF GPC} name 'SDL_GetWindowPosition' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the size of a window's client area.
   *  
   *  w        The width of the window, must be >0
   *  h        The height of the window, must be >0
   *
   *  You can't change the size of a fullscreen window, it automatically
   *  matches the size of the display mode.
   *  
   *  SDL_GetWindowSize()
   *}

  procedure SDL_SetWindowSize(window: PSDLWindow; w: SInt32; h: SInt32) cdecl external {$IFDEF GPC} name 'SDL_SetWindowSize' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the size of a window's client area.
   *  
   *  w        Pointer to variable for storing the width, may be nil
   *  h        Pointer to variable for storing the height, may be nil
   *  
   *  SDL_SetWindowSize()
   *}

  procedure SDL_GetWindowSize(window: PSDLWindow; w: PInt; h: PInt) cdecl external {$IFDEF GPC} name 'SDL_GetWindowSize' {$ELSE} SDL_LibName {$ENDIF};
    
  {**
   *  Set the minimum size of a window's client area.
   *  
   *  min_w     The minimum width of the window, must be >0
   *  min_h     The minimum height of the window, must be >0
   *
   *  You can't change the minimum size of a fullscreen window, it
   *  automatically matches the size of the display mode.
   *
   *  SDL_GetWindowMinimumSize()
   *  SDL_SetWindowMaximumSize()
   *}

  procedure SDL_SetWindowMinimumSize(window: PSDLWindow; min_w: SInt32; min_h: SInt32) cdecl external {$IFDEF GPC} name 'SDL_SetWindowMinimumSize' {$ELSE} SDL_LibName {$ENDIF};
    
  {**
   *  Get the minimum size of a window's client area.
   *  
   *  w        Pointer to variable for storing the minimum width, may be nil
   *  h        Pointer to variable for storing the minimum height, may be nil
   *  
   *  SDL_GetWindowMaximumSize()
   *  SDL_SetWindowMinimumSize()
   *}

  procedure SDL_GetWindowMinimumSize(window: PSDLWindow; w: PInt; h: PInt) cdecl external {$IFDEF GPC} name 'SDL_GetWindowMinimumSize' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the maximum size of a window's client area.
   *
   *  max_w     The maximum width of the window, must be >0
   *  max_h     The maximum height of the window, must be >0
   *
   *  You can't change the maximum size of a fullscreen window, it
   *  automatically matches the size of the display mode.
   *
   *  SDL_GetWindowMaximumSize()
   *  SDL_SetWindowMinimumSize()
   *}

  procedure SDL_SetWindowMaximumSize(window: PSDLWindow; max_w: SInt32; max_h: SInt32) cdecl external {$IFDEF GPC} name 'SDL_SetWindowMaximumSize' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the maximum size of a window's client area.
   *  
   *  w        Pointer to variable for storing the maximum width, may be nil
   *  h        Pointer to variable for storing the maximum height, may be nil
   *
   *  SDL_GetWindowMinimumSize()
   *  SDL_SetWindowMaximumSize()
   *}

  procedure SDL_GetWindowMaximumSize(window: PSDLWindow; w: PInt; h: PInt) cdecl external {$IFDEF GPC} name 'SDL_GetWindowMaximumSize' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the border state of a window.
   *
   *  This will add or remove the window's SDL_WINDOW_BORDERLESS flag and
   *  add or remove the border from the actual window. This is a no-op if the
   *  window's border already matches the requested state.
   *
   *  window The window of which to change the border state.
   *  bordered SDL_FALSE to remove border, SDL_TRUE to add border.
   *
   *  You can't change the border state of a fullscreen window.
   *  
   *  SDL_GetWindowFlags()
   *}

  procedure SDL_SetWindowBordered(window: PSDLWindow; bordered: TSDLBool) cdecl external {$IFDEF GPC} name 'SDL_SetWindowBordered' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Show a window.
   *  
   *  SDL_HideWindow()
   *}

  procedure SDL_ShowWindow(window: PSDLWindow) cdecl external {$IFDEF GPC} name 'SDL_ShowWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Hide a window.
   *  
   *  SDL_ShowWindow()
   *}

  procedure SDL_HideWindow(window: PSDLWindow) cdecl external {$IFDEF GPC} name 'SDL_HideWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Raise a window above other windows and set the input focus.
   *}

  procedure SDL_RaiseWindow(window: PSDLWindow) cdecl external {$IFDEF GPC} name 'SDL_RaiseWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Make a window as large as possible.
   *  
   *  SDL_RestoreWindow()
   *}

  procedure SDL_MaximizeWindow(window: PSDLWindow) cdecl external {$IFDEF GPC} name 'SDL_MaximizeWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Minimize a window to an iconic representation.
   *  
   *  SDL_RestoreWindow()
   *}

  procedure SDL_MinimizeWindow(window: PSDLWindow) cdecl external {$IFDEF GPC} name 'SDL_MinimizeWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Restore the size and position of a minimized or maximized window.
   *  
   *  SDL_MaximizeWindow()
   *  SDL_MinimizeWindow()
   *}

  procedure SDL_RestoreWindow(window: PSDLWindow) cdecl external {$IFDEF GPC} name 'SDL_RestoreWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set a window's fullscreen state.
   *  
   *  0 on success, or -1 if setting the display mode failed.
   *  
   *  SDL_SetWindowDisplayMode()
   *  SDL_GetWindowDisplayMode()
   *}

  function SDL_SetWindowFullscreen(window: PSDLWindow; flags: UInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetWindowFullscreen' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the SDL surface associated with the window.
   *
   *  The window's framebuffer surface, or nil on error.
   *
   *  A new surface will be created with the optimal format for the window,
   *  if necessary. This surface will be freed when the window is destroyed.
   *
   *  You may not combine this with 3D or the rendering API on this window.
   *
   *  SDL_UpdateWindowSurface()
   *  SDL_UpdateWindowSurfaceRects()
   *}

  function SDL_GetWindowSurface(window: PSDLWindow): PSDLWindow cdecl external {$IFDEF GPC} name 'SDL_GetWindowSurface' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Copy the window surface to the screen.
   *
   *  0 on success, or -1 on error.
   *
   *  SDL_GetWindowSurface()
   *  SDL_UpdateWindowSurfaceRects()
   *}

  function SDL_UpdateWindowSurface(window: PSDLWindow): SInt32 cdecl external {$IFDEF GPC} name 'SDL_UpdateWindowSurface' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Copy a number of rectangles on the window surface to the screen.
   *
   *  0 on success, or -1 on error.
   *
   *  SDL_GetWindowSurface()
   *  SDL_UpdateWindowSurfaceRect()
   *}

  function SDL_UpdateWindowSurfaceRects(window: PSDLWindow; rects: PSDLRect; numrects: SInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_UpdateWindowSurfaceRects' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set a window's input grab mode.
   *  
   *  grabbed This is SDL_TRUE to grab input, and SDL_FALSE to release input.
   *  
   *  SDL_GetWindowGrab()
   *}

  procedure SDL_SetWindowGrab(window: PSDLWindow; grabbed: TSDLBool) cdecl external {$IFDEF GPC} name 'SDL_SetWindowGrab' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get a window's input grab mode.
   *  
   *  This returns SDL_TRUE if input is grabbed, and SDL_FALSE otherwise.
   *
   *  SDL_SetWindowGrab()
   *}

  function SDL_GetWindowGrab(window: PSDLWindow): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_GetWindowGrab' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the brightness (gamma correction) for a window.
   *
   *  0 on success, or -1 if setting the brightness isn't supported.
   *  
   *  SDL_GetWindowBrightness()
   *  SDL_SetWindowGammaRamp()
   *}

  function SDL_SetWindowBrightness(window: PSDLWindow; brightness: Float): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetWindowBrightness' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the brightness (gamma correction) for a window.
   *  
   *  The last brightness value passed to SDL_SetWindowBrightness()
   *  
   *  SDL_SetWindowBrightness()
   *}

  function SDL_GetWindowBrightness(window: PSDLWindow): Float cdecl external {$IFDEF GPC} name 'SDL_GetWindowBrightness' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the gamma ramp for a window.
   *  
   *  red The translation table for the red channel, or nil.
   *  green The translation table for the green channel, or nil.
   *  blue The translation table for the blue channel, or nil.
   *
   *  0 on success, or -1 if gamma ramps are unsupported.
   *  
   *  Set the gamma translation table for the red, green, and blue channels
   *  of the video hardware.  Each table is an array of 256 16-bit quantities,
   *  representing a mapping between the input and output for that channel.
   *  The input is the index into the array, and the output is the 16-bit
   *  gamma value at that index, scaled to the output color precision.
   *
   *  SDL_GetWindowGammaRamp()
   *}

  function SDL_SetWindowGammaRamp(window: PSDLWindow; const red: PUInt16; const green: PUInt16; const blue: PUInt16): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetWindowGammaRamp' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the gamma ramp for a window.
   *  
   *  red   A pointer to a 256 element array of 16-bit quantities to hold
   *        the translation table for the red channel, or nil.
   *  green A pointer to a 256 element array of 16-bit quantities to hold
   *        the translation table for the green channel, or nil.
   *  blue  A pointer to a 256 element array of 16-bit quantities to hold
   *        the translation table for the blue channel, or nil.
   *   
   *  0 on success, or -1 if gamma ramps are unsupported.
   *  
   *  SDL_SetWindowGammaRamp()
   *}

  function SDL_GetWindowGammaRamp(window: PSDLWindow; red: PUInt16; green: PUInt16; blue: PUInt16): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GetWindowGammaRamp' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Destroy a window.
   *}

  procedure SDL_DestroyWindow(window: PSDLWindow) cdecl external {$IFDEF GPC} name 'SDL_DestroyWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Returns whether the screensaver is currently enabled (default on).
   *  
   *  SDL_EnableScreenSaver()
   *  SDL_DisableScreenSaver()
   *}

  function SDL_IsScreenSaverEnabled: TSDLBool cdecl external {$IFDEF GPC} name 'SDL_IsScreenSaverEnabled' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Allow the screen to be blanked by a screensaver
   *  
   *  SDL_IsScreenSaverEnabled()
   *  SDL_DisableScreenSaver()
   *}

  procedure SDL_EnableScreenSaver cdecl external {$IFDEF GPC} name 'SDL_EnableScreenSaver' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Prevent the screen from being blanked by a screensaver
   *  
   *  SDL_IsScreenSaverEnabled()
   *  SDL_EnableScreenSaver()
   *}

  procedure SDL_DisableScreenSaver cdecl external {$IFDEF GPC} name 'SDL_DisableScreenSaver' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  OpenGL support functions
   *}

  {**
   *  Dynamically load an OpenGL library.
   *  
   *  path The platform dependent OpenGL library name, or nil to open the
   *              default OpenGL library.
   *  
   *  0 on success, or -1 if the library couldn't be loaded.
   *
   *  This should be done after initializing the video driver, but before
   *  creating any OpenGL windows.  If no OpenGL library is loaded, the default
   *  library will be loaded upon creation of the first OpenGL window.
   *  
   *  If you do this, you need to retrieve all of the GL functions used in
   *  your program from the dynamic library using SDL_GL_GetProcAddress().
   *  
   *  SDL_GL_GetProcAddress()
   *  SDL_GL_UnloadLibrary()
   *}

  function SDL_GL_LoadLibrary(const path: PChar): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GL_LoadLibrary' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the address of an OpenGL function.
   *}

  function SDL_GL_GetProcAddress(const proc: PChar): Pointer cdecl external {$IFDEF GPC} name 'SDL_GL_GetProcAddress' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Unload the OpenGL library previously loaded by SDL_GL_LoadLibrary().
   *  
   *  SDL_GL_LoadLibrary()
   *}

  procedure SDL_GL_UnloadLibrary cdecl external {$IFDEF GPC} name 'SDL_GL_UnloadLibrary' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Return true if an OpenGL extension is supported for the current
   *  context.
   *}

  function SDL_GL_ExtensionSupported(const extension: PChar): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_GL_ExtensionSupported' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set an OpenGL window attribute before window creation.
   *}

  function SDL_GL_SetAttribute(SDL_GLattr attr, int value): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GL_SetAttribute' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the actual value for an attribute from the current context.
   *}

  function SDL_GL_GetAttribute(SDL_GLattr attr, int *value): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GL_GetAttribute' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Create an OpenGL context for use with an OpenGL window, and make it
   *  current.
   *
   *  SDL_GL_DeleteContext()
   *}

  function SDL_GL_CreateContext(window: PSDLWindow): TSDLGLContext cdecl external {$IFDEF GPC} name 'SDL_GL_CreateContext' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set up an OpenGL context for rendering into an OpenGL window.
   *  
   *  The context must have been created with a compatible window.
   *}

  function SDL_GL_MakeCurrent(window: PSDLWindow; context: TSDLGLContext): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GL_MakeCurrent' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the swap interval for the current OpenGL context.
   *  
   *  interval 0 for immediate updates, 1 for updates synchronized with the
   *  vertical retrace. If the system supports it, you may
   *  specify -1 to allow late swaps to happen immediately
   *  instead of waiting for the next retrace.
   *
   *  0 on success, or -1 if setting the swap interval is not supported.
   *  
   *  SDL_GL_GetSwapInterval()
   *}

  function SDL_GL_SetSwapInterval(interval: SInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_GL_SetSwapInterval' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the swap interval for the current OpenGL context.
   *  
   *  0 if there is no vertical retrace synchronization, 1 if the buffer
   *  swap is synchronized with the vertical retrace, and -1 if late
   *  swaps happen immediately instead of waiting for the next retrace.
   *  If the system can't determine the swap interval, or there isn't a
   *  valid current context, this will return 0 as a safe default.
   *  
   *  SDL_GL_SetSwapInterval()
   *}

  function SDL_GL_GetSwapInterval: SInt32 cdecl external {$IFDEF GPC} name 'SDL_GL_GetSwapInterval' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Swap the OpenGL buffers for a window, if double-buffering is
   *  supported.
   *}

  procedure SDL_GL_SwapWindow(window: PSDLWindow) cdecl external {$IFDEF GPC} name 'SDL_GL_SwapWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Delete an OpenGL context.
   *  
   *  SDL_GL_CreateContext()
   *}

  procedure SDL_GL_DeleteContext(context: TSDLGLContext) cdecl external {$IFDEF GPC} name 'SDL_GL_DeleteContext' {$ELSE} SDL_LibName {$ENDIF};

  {*OpenGL support functions*}

  //from "sdl_scancode.h"

  {**
   *  The SDL keyboard scancode representation.
   *
   *  Values of this type are used to represent keyboard keys, among other places
   *  in the SDL_Keysym.scancode key.keysym.scancode \endlink field of the
   *  SDL_Event structure.
   *
   *  The values in this enumeration are based on the USB usage page standard:
   *  http://www.usb.org/developers/devclass_docs/Hut1_12v2.pdf
   *}

const
  SDL_SCANCODE_UNKNOWN = 0;

  {**
   *  Usage page $07
   *
   *  These values are from usage page $07 (USB keyboard page).
   *}

  SDL_SCANCODE_A = 4;
  SDL_SCANCODE_B = 5;
  SDL_SCANCODE_C = 6;
  SDL_SCANCODE_D = 7;
  SDL_SCANCODE_E = 8;
  SDL_SCANCODE_F = 9;
  SDL_SCANCODE_G = 10;
  SDL_SCANCODE_H = 11;
  SDL_SCANCODE_I = 12;
  SDL_SCANCODE_J = 13;
  SDL_SCANCODE_K = 14;
  SDL_SCANCODE_L = 15;
  SDL_SCANCODE_M = 16;
  SDL_SCANCODE_N = 17;
  SDL_SCANCODE_O = 18;
  SDL_SCANCODE_P = 19;
  SDL_SCANCODE_Q = 20;
  SDL_SCANCODE_R = 21;
  SDL_SCANCODE_S = 22;
  SDL_SCANCODE_T = 23;
  SDL_SCANCODE_U = 24;
  SDL_SCANCODE_V = 25;
  SDL_SCANCODE_W = 26;
  SDL_SCANCODE_X = 27;
  SDL_SCANCODE_Y = 28;
  SDL_SCANCODE_Z = 29;

  SDL_SCANCODE_1 = 30;
  SDL_SCANCODE_2 = 31;
  SDL_SCANCODE_3 = 32;
  SDL_SCANCODE_4 = 33;
  SDL_SCANCODE_5 = 34;
  SDL_SCANCODE_6 = 35;
  SDL_SCANCODE_7 = 36;
  SDL_SCANCODE_8 = 37;
  SDL_SCANCODE_9 = 38;
  SDL_SCANCODE_0 = 39;

  SDL_SCANCODE_RETURN = 40;
  SDL_SCANCODE_ESCAPE = 41;
  SDL_SCANCODE_BACKSPACE = 42;
  SDL_SCANCODE_TAB = 43;
  SDL_SCANCODE_SPACE = 44;

  SDL_SCANCODE_MINUS = 45;
  SDL_SCANCODE_EQUALS = 46;
  SDL_SCANCODE_LEFTBRACKET = 47;
  SDL_SCANCODE_RIGHTBRACKET = 48;
  SDL_SCANCODE_BACKSLASH = 49; {**< Located at the lower left of the return
                                *   key on ISO keyboards and at the right end
                                *   of the QWERTY row on ANSI keyboards.
                                *   Produces REVERSE SOLIDUS (backslash) and
                                *   VERTICAL LINE in a US layout; REVERSE 
                                *   SOLIDUS and VERTICAL LINE in a UK Mac
                                *   layout; NUMBER SIGN and TILDE in a UK 
                                *   Windows layout; DOLLAR SIGN and POUND SIGN
                                *   in a Swiss German layout; NUMBER SIGN and
                                *   APOSTROPHE in a German layout; GRAVE
                                *   ACCENT and POUND SIGN in a French Mac 
                                *   layout; and ASTERISK and MICRO SIGN in a
                                *   French Windows layout.
                                *}
  SDL_SCANCODE_NONUSHASH = 50; {**< ISO USB keyboards actually use this code
                                *   instead of 49 for the same key; but all
                                *   OSes I've seen treat the two codes 
                                *   identically. So; as an implementor; unless
                                *   your keyboard generates both of those 
                                *   codes and your OS treats them differently;
                                *   you should generate SDL_SCANCODE_BACKSLASH
                                *   instead of this code. As a user; you
                                *   should not rely on this code because SDL
                                *   will never generate it with most (all?)
                                *   keyboards.
                                *}
  SDL_SCANCODE_SEMICOLON = 51;
  SDL_SCANCODE_APOSTROPHE = 52;
  SDL_SCANCODE_GRAVE = 53; {**< Located in the top left corner (on both ANSI
                            *   and ISO keyboards). Produces GRAVE ACCENT and
                            *   TILDE in a US Windows layout and in US and UK
                            *   Mac layouts on ANSI keyboards; GRAVE ACCENT
                            *   and NOT SIGN in a UK Windows layout; SECTION
                            *   SIGN and PLUS-MINUS SIGN in US and UK Mac
                            *   layouts on ISO keyboards; SECTION SIGN and
                            *   DEGREE SIGN in a Swiss German layout (Mac:
                            *   only on ISO keyboards); CIRCUMFLEX ACCENT and
                            *   DEGREE SIGN in a German layout (Mac: only on
                            *   ISO keyboards); SUPERSCRIPT TWO and TILDE in a
                            *   French Windows layout; COMMERCIAL AT and
                            *   NUMBER SIGN in a French Mac layout on ISO
                            *   keyboards; and LESS-THAN SIGN and GREATER-THAN
                            *   SIGN in a Swiss German; German; or French Mac
                            *   layout on ANSI keyboards.
                            *}
  SDL_SCANCODE_COMMA = 54;
  SDL_SCANCODE_PERIOD = 55;
  SDL_SCANCODE_SLASH = 56;

  SDL_SCANCODE_CAPSLOCK = 57;

  SDL_SCANCODE_F1 = 58;
  SDL_SCANCODE_F2 = 59;
  SDL_SCANCODE_F3 = 60;
  SDL_SCANCODE_F4 = 61;
  SDL_SCANCODE_F5 = 62;
  SDL_SCANCODE_F6 = 63;
  SDL_SCANCODE_F7 = 64;
  SDL_SCANCODE_F8 = 65;
  SDL_SCANCODE_F9 = 66;
  SDL_SCANCODE_F10 = 67;
  SDL_SCANCODE_F11 = 68;
  SDL_SCANCODE_F12 = 69;

  SDL_SCANCODE_PRINTSCREEN = 70;
  SDL_SCANCODE_SCROLLLOCK = 71;
  SDL_SCANCODE_PAUSE = 72;
  SDL_SCANCODE_INSERT = 73; {**< insert on PC; help on some Mac keyboards (but
                                 does send code 73; not 117) *}
  SDL_SCANCODE_HOME = 74;
  SDL_SCANCODE_PAGEUP = 75;
  SDL_SCANCODE_DELETE = 76;
  SDL_SCANCODE_END = 77;
  SDL_SCANCODE_PAGEDOWN = 78;
  SDL_SCANCODE_RIGHT = 79;
  SDL_SCANCODE_LEFT = 80;
  SDL_SCANCODE_DOWN = 81;
  SDL_SCANCODE_UP = 82;

  SDL_SCANCODE_NUMLOCKCLEAR = 83; {**< num lock on PC; clear on Mac keyboards
                                   *}
  SDL_SCANCODE_KP_DIVIDE = 84;
  SDL_SCANCODE_KP_MULTIPLY = 85;
  SDL_SCANCODE_KP_MINUS = 86;
  SDL_SCANCODE_KP_PLUS = 87;
  SDL_SCANCODE_KP_ENTER = 88;
  SDL_SCANCODE_KP_1 = 89;
  SDL_SCANCODE_KP_2 = 90;
  SDL_SCANCODE_KP_3 = 91;
  SDL_SCANCODE_KP_4 = 92;
  SDL_SCANCODE_KP_5 = 93;
  SDL_SCANCODE_KP_6 = 94;
  SDL_SCANCODE_KP_7 = 95;
  SDL_SCANCODE_KP_8 = 96;
  SDL_SCANCODE_KP_9 = 97;
  SDL_SCANCODE_KP_0 = 98;
  SDL_SCANCODE_KP_PERIOD = 99;

  SDL_SCANCODE_NONUSBACKSLASH = 100; {**< This is the additional key that ISO
                                      *   keyboards have over ANSI ones; 
                                      *   located between left shift and Y. 
                                      *   Produces GRAVE ACCENT and TILDE in a
                                      *   US or UK Mac layout; REVERSE SOLIDUS
                                      *   (backslash) and VERTICAL LINE in a 
                                      *   US or UK Windows layout; and 
                                      *   LESS-THAN SIGN and GREATER-THAN SIGN
                                      *   in a Swiss German; German; or French
                                      *   layout. *}
  SDL_SCANCODE_APPLICATION = 101; {**< windows contextual menu; compose *}
  SDL_SCANCODE_POWER = 102; {**< The USB document says this is a status flag;
                             *   not a physical key - but some Mac keyboards 
                             *   do have a power key. *}
  SDL_SCANCODE_KP_EQUALS = 103;
  SDL_SCANCODE_F13 = 104;
  SDL_SCANCODE_F14 = 105;
  SDL_SCANCODE_F15 = 106;
  SDL_SCANCODE_F16 = 107;
  SDL_SCANCODE_F17 = 108;
  SDL_SCANCODE_F18 = 109;
  SDL_SCANCODE_F19 = 110;
  SDL_SCANCODE_F20 = 111;
  SDL_SCANCODE_F21 = 112;
  SDL_SCANCODE_F22 = 113;
  SDL_SCANCODE_F23 = 114;
  SDL_SCANCODE_F24 = 115;
  SDL_SCANCODE_EXECUTE = 116;
  SDL_SCANCODE_HELP = 117;
  SDL_SCANCODE_MENU = 118;
  SDL_SCANCODE_SELECT = 119;
  SDL_SCANCODE_STOP = 120;
  SDL_SCANCODE_AGAIN = 121;   {**< redo *}
  SDL_SCANCODE_UNDO = 122;
  SDL_SCANCODE_CUT = 123;
  SDL_SCANCODE_COPY = 124;
  SDL_SCANCODE_PASTE = 125;
  SDL_SCANCODE_FIND = 126;
  SDL_SCANCODE_MUTE = 127;
  SDL_SCANCODE_VOLUMEUP = 128;
  SDL_SCANCODE_VOLUMEDOWN = 129;
  {* not sure whether there's a reason to enable these *}
  {*     SDL_SCANCODE_LOCKINGCAPSLOCK = 130;  *}
  {*     SDL_SCANCODE_LOCKINGNUMLOCK = 131; *}
  {*     SDL_SCANCODE_LOCKINGSCROLLLOCK = 132; *}
  SDL_SCANCODE_KP_COMMA = 133;
  SDL_SCANCODE_KP_EQUALSAS400 = 134;

  SDL_SCANCODE_INTERNATIONAL1 = 135; {**< used on Asian keyboards; see footnotes in USB doc *}
  SDL_SCANCODE_INTERNATIONAL2 = 136;
  SDL_SCANCODE_INTERNATIONAL3 = 137; {**< Yen *}
  SDL_SCANCODE_INTERNATIONAL4 = 138;
  SDL_SCANCODE_INTERNATIONAL5 = 139;
  SDL_SCANCODE_INTERNATIONAL6 = 140;
  SDL_SCANCODE_INTERNATIONAL7 = 141;
  SDL_SCANCODE_INTERNATIONAL8 = 142;
  SDL_SCANCODE_INTERNATIONAL9 = 143;
  SDL_SCANCODE_LANG1 = 144; {**< Hangul{English toggle *}
  SDL_SCANCODE_LANG2 = 145; {**< Hanja conversion *}
  SDL_SCANCODE_LANG3 = 146; {**< Katakana *}
  SDL_SCANCODE_LANG4 = 147; {**< Hiragana *}
  SDL_SCANCODE_LANG5 = 148; {**< Zenkaku{Hankaku *}
  SDL_SCANCODE_LANG6 = 149; {**< reserved *}
  SDL_SCANCODE_LANG7 = 150; {**< reserved *}
  SDL_SCANCODE_LANG8 = 151; {**< reserved *}
  SDL_SCANCODE_LANG9 = 152; {**< reserved *}

  SDL_SCANCODE_ALTERASE = 153; {**< Erase-Eaze *}
  SDL_SCANCODE_SYSREQ = 154;
  SDL_SCANCODE_CANCEL = 155;
  SDL_SCANCODE_CLEAR = 156;
  SDL_SCANCODE_PRIOR = 157;
  SDL_SCANCODE_RETURN2 = 158;
  SDL_SCANCODE_SEPARATOR = 159;
  SDL_SCANCODE_OUT = 160;
  SDL_SCANCODE_OPER = 161;
  SDL_SCANCODE_CLEARAGAIN = 162;
  SDL_SCANCODE_CRSEL = 163;
  SDL_SCANCODE_EXSEL = 164;

  SDL_SCANCODE_KP_00 = 176;
  SDL_SCANCODE_KP_000 = 177;
  SDL_SCANCODE_THOUSANDSSEPARATOR = 178;
  SDL_SCANCODE_DECIMALSEPARATOR = 179;
  SDL_SCANCODE_CURRENCYUNIT = 180;
  SDL_SCANCODE_CURRENCYSUBUNIT = 181;
  SDL_SCANCODE_KP_LEFTPAREN = 182;
  SDL_SCANCODE_KP_RIGHTPAREN = 183;
  SDL_SCANCODE_KP_LEFTBRACE = 184;
  SDL_SCANCODE_KP_RIGHTBRACE = 185;
  SDL_SCANCODE_KP_TAB = 186;
  SDL_SCANCODE_KP_BACKSPACE = 187;
  SDL_SCANCODE_KP_A = 188;
  SDL_SCANCODE_KP_B = 189;
  SDL_SCANCODE_KP_C = 190;
  SDL_SCANCODE_KP_D = 191;
  SDL_SCANCODE_KP_E = 192;
  SDL_SCANCODE_KP_F = 193;
  SDL_SCANCODE_KP_XOR = 194;
  SDL_SCANCODE_KP_POWER = 195;
  SDL_SCANCODE_KP_PERCENT = 196;
  SDL_SCANCODE_KP_LESS = 197;
  SDL_SCANCODE_KP_GREATER = 198;
  SDL_SCANCODE_KP_AMPERSAND = 199;
  SDL_SCANCODE_KP_DBLAMPERSAND = 200;
  SDL_SCANCODE_KP_VERTICALBAR = 201;
  SDL_SCANCODE_KP_DBLVERTICALBAR = 202;
  SDL_SCANCODE_KP_COLON = 203;
  SDL_SCANCODE_KP_HASH = 204;
  SDL_SCANCODE_KP_SPACE = 205;
  SDL_SCANCODE_KP_AT = 206;
  SDL_SCANCODE_KP_EXCLAM = 207;
  SDL_SCANCODE_KP_MEMSTORE = 208;
  SDL_SCANCODE_KP_MEMRECALL = 209;
  SDL_SCANCODE_KP_MEMCLEAR = 210;
  SDL_SCANCODE_KP_MEMADD = 211;
  SDL_SCANCODE_KP_MEMSUBTRACT = 212;
  SDL_SCANCODE_KP_MEMMULTIPLY = 213;
  SDL_SCANCODE_KP_MEMDIVIDE = 214;
  SDL_SCANCODE_KP_PLUSMINUS = 215;
  SDL_SCANCODE_KP_CLEAR = 216;
  SDL_SCANCODE_KP_CLEARENTRY = 217;
  SDL_SCANCODE_KP_BINARY = 218;
  SDL_SCANCODE_KP_OCTAL = 219;
  SDL_SCANCODE_KP_DECIMAL = 220;
  SDL_SCANCODE_KP_HEXADECIMAL = 221;

  SDL_SCANCODE_LCTRL = 224;
  SDL_SCANCODE_LSHIFT = 225;
  SDL_SCANCODE_LALT = 226; {**< alt; option *}
  SDL_SCANCODE_LGUI = 227; {**< windows; command (apple); meta *}
  SDL_SCANCODE_RCTRL = 228;
  SDL_SCANCODE_RSHIFT = 229;
  SDL_SCANCODE_RALT = 230; {**< alt gr; option *}
  SDL_SCANCODE_RGUI = 231; {**< windows; command (apple); meta *}

  SDL_SCANCODE_MODE = 257;    {**< I'm not sure if this is really not covered 
                               *   by any of the above; but since there's a 
                               *   special KMOD_MODE for it I'm adding it here
                               *}
    
  {*Usage page $07*}

  {**
   *  Usage page $0C
   *
   *  These values are mapped from usage page $0C (USB consumer page).
   *}

  SDL_SCANCODE_AUDIONEXT = 258;
  SDL_SCANCODE_AUDIOPREV = 259;
  SDL_SCANCODE_AUDIOSTOP = 260;
  SDL_SCANCODE_AUDIOPLAY = 261;
  SDL_SCANCODE_AUDIOMUTE = 262;
  SDL_SCANCODE_MEDIASELECT = 263;
  SDL_SCANCODE_WWW = 264;
  SDL_SCANCODE_MAIL = 265;
  SDL_SCANCODE_CALCULATOR = 266;
  SDL_SCANCODE_COMPUTER = 267;
  SDL_SCANCODE_AC_SEARCH = 268;
  SDL_SCANCODE_AC_HOME = 269;
  SDL_SCANCODE_AC_BACK = 270;
  SDL_SCANCODE_AC_FORWARD = 271;
  SDL_SCANCODE_AC_STOP = 272;
  SDL_SCANCODE_AC_REFRESH = 273;
  SDL_SCANCODE_AC_BOOKMARKS = 274;

  {*Usage page $0C*}

  {**
   *  Walther keys
   *
   *  These are values that Christian Walther added (for mac keyboard?).
   *}

  SDL_SCANCODE_BRIGHTNESSDOWN = 275;
  SDL_SCANCODE_BRIGHTNESSUP = 276;
  SDL_SCANCODE_DISPLAYSWITCH = 277; {**< display mirroring{dual display
                                         switch; video mode switch *}
  SDL_SCANCODE_KBDILLUMTOGGLE = 278;
  SDL_SCANCODE_KBDILLUMDOWN = 279;
  SDL_SCANCODE_KBDILLUMUP = 280;
  SDL_SCANCODE_EJECT = 281;
  SDL_SCANCODE_SLEEP = 282;

	SDL_SCANCODE_APP1 = 283;
	SDL_SCANCODE_APP2 = 284;

  {*Walther keys*}

  {* Add any other keys here. *}

  SDL_NUM_SCANCODES = 512; {**< not a key, just marks the number of scancodes
                               for array bounds *}

type
  TSDL_ScanCode = DWord;

  //from "sdl_keycode.h"


  {**
   *  The SDL virtual key representation.
   *
   *  Values of this type are used to represent keyboard keys using the current
   *  layout of the keyboard.  These values include Unicode values representing
   *  the unmodified character that would be generated by pressing the key, or
   *  an SDLK_* constant for those keys that do not generate characters.
   *}

  TSDL_KeyCode = SInt32;

const
  SDLK_SCANCODE_MASK = 1 shl 30;

  SDLK_UNKNOWN = 0;

  SDLK_RETURN = '\r';
  SDLK_ESCAPE = '\033';
  SDLK_BACKSPACE = '\b';
  SDLK_TAB = '\t';
  SDLK_SPACE = ' ';
  SDLK_EXCLAIM = '!';
  SDLK_QUOTEDBL = '"';
  SDLK_HASH = '#';
  SDLK_PERCENT = '%';
  SDLK_DOLLAR = '$';
  SDLK_AMPERSAND = '&';
  SDLK_QUOTE = '\';
  SDLK_LEFTPAREN = '(';
  SDLK_RIGHTPAREN = ')';
  SDLK_ASTERISK = '*';
  SDLK_PLUS = '+';
  SDLK_COMMA = ';';
  SDLK_MINUS = '-';
  SDLK_PERIOD = '.';
  SDLK_SLASH = '/';
  SDLK_0 = '0';
  SDLK_1 = '1';
  SDLK_2 = '2';
  SDLK_3 = '3';
  SDLK_4 = '4';
  SDLK_5 = '5';
  SDLK_6 = '6';
  SDLK_7 = '7';
  SDLK_8 = '8';
  SDLK_9 = '9';
  SDLK_COLON = ':';
  SDLK_SEMICOLON = ';';
  SDLK_LESS = '<';
  SDLK_EQUALS = '=';
  SDLK_GREATER = '>';
  SDLK_QUESTION = '?';
  SDLK_AT = '@';
  {*
     Skip uppercase letters
   *}
  SDLK_LEFTBRACKET = '[';
  SDLK_BACKSLASH = '\\';
  SDLK_RIGHTBRACKET = ']';
  SDLK_CARET = '^';
  SDLK_UNDERSCORE = '_';
  SDLK_BACKQUOTE = '`';
  SDLK_a = 'a';
  SDLK_b = 'b';
  SDLK_c = 'c';
  SDLK_d = 'd';
  SDLK_e = 'e';
  SDLK_f = 'f';
  SDLK_g = 'g';
  SDLK_h = 'h';
  SDLK_i = 'i';
  SDLK_j = 'j';
  SDLK_k = 'k';
  SDLK_l = 'l';
  SDLK_m = 'm';
  SDLK_n = 'n';
  SDLK_o = 'o';
  SDLK_p = 'p';
  SDLK_q = 'q';
  SDLK_r = 'r';
  SDLK_s = 's';
  SDLK_t = 't';
  SDLK_u = 'u';
  SDLK_v = 'v';
  SDLK_w = 'w';
  SDLK_x = 'x';
  SDLK_y = 'y';
  SDLK_z = 'z';

  SDLK_CAPSLOCK = SDL_SCANCODE_CAPSLOCK or SDLK_SCANCODE_MASK;

  SDLK_F1 = SDL_SCANCODE_F1 or SDLK_SCANCODE_MASK;
  SDLK_F2 = SDL_SCANCODE_F2 or SDLK_SCANCODE_MASK;
  SDLK_F3 = SDL_SCANCODE_F3 or SDLK_SCANCODE_MASK;
  SDLK_F4 = SDL_SCANCODE_F4 or SDLK_SCANCODE_MASK;
  SDLK_F5 = SDL_SCANCODE_F5 or SDLK_SCANCODE_MASK;
  SDLK_F6 = SDL_SCANCODE_F6 or SDLK_SCANCODE_MASK;
  SDLK_F7 = SDL_SCANCODE_F7 or SDLK_SCANCODE_MASK;
  SDLK_F8 = SDL_SCANCODE_F8 or SDLK_SCANCODE_MASK;
  SDLK_F9 = SDL_SCANCODE_F9 or SDLK_SCANCODE_MASK;
  SDLK_F10 = SDL_SCANCODE_F10 or SDLK_SCANCODE_MASK;
  SDLK_F11 = SDL_SCANCODE_F11 or SDLK_SCANCODE_MASK;
  SDLK_F12 = SDL_SCANCODE_F12 or SDLK_SCANCODE_MASK;

  SDLK_PRINTSCREEN = SDL_SCANCODE_PRINTSCREEN or SDLK_SCANCODE_MASK;
  SDLK_SCROLLLOCK = SDL_SCANCODE_SCROLLLOCK or SDLK_SCANCODE_MASK;
  SDLK_PAUSE = SDL_SCANCODE_PAUSE or SDLK_SCANCODE_MASK;
  SDLK_INSERT = SDL_SCANCODE_INSERT or SDLK_SCANCODE_MASK;
  SDLK_HOME = SDL_SCANCODE_HOME or SDLK_SCANCODE_MASK;
  SDLK_PAGEUP = SDL_SCANCODE_PAGEUP or SDLK_SCANCODE_MASK;
  SDLK_DELETE = '\177';
  SDLK_END = SDL_SCANCODE_END or SDLK_SCANCODE_MASK;
  SDLK_PAGEDOWN = SDL_SCANCODE_PAGEDOWN or SDLK_SCANCODE_MASK;
  SDLK_RIGHT = SDL_SCANCODE_RIGHT or SDLK_SCANCODE_MASK;
  SDLK_LEFT = SDL_SCANCODE_LEFT or SDLK_SCANCODE_MASK;
  SDLK_DOWN = SDL_SCANCODE_DOWN or SDLK_SCANCODE_MASK;
  SDLK_UP = SDL_SCANCODE_UP or SDLK_SCANCODE_MASK;

  SDLK_NUMLOCKCLEAR = SDL_SCANCODE_NUMLOCKCLEAR or SDLK_SCANCODE_MASK;
  SDLK_KP_DIVIDE = SDL_SCANCODE_KP_DIVIDE or SDLK_SCANCODE_MASK;
  SDLK_KP_MULTIPLY = SDL_SCANCODE_KP_MULTIPLY or SDLK_SCANCODE_MASK;
  SDLK_KP_MINUS = SDL_SCANCODE_KP_MINUS or SDLK_SCANCODE_MASK;
  SDLK_KP_PLUS = SDL_SCANCODE_KP_PLUS or SDLK_SCANCODE_MASK;
  SDLK_KP_ENTER = SDL_SCANCODE_KP_ENTER or SDLK_SCANCODE_MASK;
  SDLK_KP_1 = SDL_SCANCODE_KP_1 or SDLK_SCANCODE_MASK;
  SDLK_KP_2 = SDL_SCANCODE_KP_2 or SDLK_SCANCODE_MASK;
  SDLK_KP_3 = SDL_SCANCODE_KP_3 or SDLK_SCANCODE_MASK;
  SDLK_KP_4 = SDL_SCANCODE_KP_4 or SDLK_SCANCODE_MASK;
  SDLK_KP_5 = SDL_SCANCODE_KP_5 or SDLK_SCANCODE_MASK;
  SDLK_KP_6 = SDL_SCANCODE_KP_6 or SDLK_SCANCODE_MASK;
  SDLK_KP_7 = SDL_SCANCODE_KP_7 or SDLK_SCANCODE_MASK;
  SDLK_KP_8 = SDL_SCANCODE_KP_8 or SDLK_SCANCODE_MASK;
  SDLK_KP_9 = SDL_SCANCODE_KP_9 or SDLK_SCANCODE_MASK;
  SDLK_KP_0 = SDL_SCANCODE_KP_0 or SDLK_SCANCODE_MASK;
  SDLK_KP_PERIOD = SDL_SCANCODE_KP_PERIOD or SDLK_SCANCODE_MASK;

  SDLK_APPLICATION = SDL_SCANCODE_APPLICATION or SDLK_SCANCODE_MASK;
  SDLK_POWER = SDL_SCANCODE_POWER or SDLK_SCANCODE_MASK;
  SDLK_KP_EQUALS = SDL_SCANCODE_KP_EQUALS or SDLK_SCANCODE_MASK;
  SDLK_F13 = SDL_SCANCODE_F13 or SDLK_SCANCODE_MASK;
  SDLK_F14 = SDL_SCANCODE_F14 or SDLK_SCANCODE_MASK;
  SDLK_F15 = SDL_SCANCODE_F15 or SDLK_SCANCODE_MASK;
  SDLK_F16 = SDL_SCANCODE_F16 or SDLK_SCANCODE_MASK;
  SDLK_F17 = SDL_SCANCODE_F17 or SDLK_SCANCODE_MASK;
  SDLK_F18 = SDL_SCANCODE_F18 or SDLK_SCANCODE_MASK;
  SDLK_F19 = SDL_SCANCODE_F19 or SDLK_SCANCODE_MASK;
  SDLK_F20 = SDL_SCANCODE_F20 or SDLK_SCANCODE_MASK;
  SDLK_F21 = SDL_SCANCODE_F21 or SDLK_SCANCODE_MASK;
  SDLK_F22 = SDL_SCANCODE_F22 or SDLK_SCANCODE_MASK;
  SDLK_F23 = SDL_SCANCODE_F23 or SDLK_SCANCODE_MASK;
  SDLK_F24 = SDL_SCANCODE_F24 or SDLK_SCANCODE_MASK;
  SDLK_EXECUTE = SDL_SCANCODE_EXECUTE or SDLK_SCANCODE_MASK;
  SDLK_HELP = SDL_SCANCODE_HELP or SDLK_SCANCODE_MASK;
  SDLK_MENU = SDL_SCANCODE_MENU or SDLK_SCANCODE_MASK;
  SDLK_SELECT = SDL_SCANCODE_SELECT or SDLK_SCANCODE_MASK;
  SDLK_STOP = SDL_SCANCODE_STOP or SDLK_SCANCODE_MASK;
  SDLK_AGAIN = SDL_SCANCODE_AGAIN or SDLK_SCANCODE_MASK;
  SDLK_UNDO = SDL_SCANCODE_UNDO or SDLK_SCANCODE_MASK;
  SDLK_CUT = SDL_SCANCODE_CUT or SDLK_SCANCODE_MASK;
  SDLK_COPY = SDL_SCANCODE_COPY or SDLK_SCANCODE_MASK;
  SDLK_PASTE = SDL_SCANCODE_PASTE or SDLK_SCANCODE_MASK;
  SDLK_FIND = SDL_SCANCODE_FIND or SDLK_SCANCODE_MASK;
  SDLK_MUTE = SDL_SCANCODE_MUTE or SDLK_SCANCODE_MASK;
  SDLK_VOLUMEUP = SDL_SCANCODE_VOLUMEUP or SDLK_SCANCODE_MASK;
  SDLK_VOLUMEDOWN = SDL_SCANCODE_VOLUMEDOWN or SDLK_SCANCODE_MASK;
  SDLK_KP_COMMA = SDL_SCANCODE_KP_COMMA or SDLK_SCANCODE_MASK;
  SDLK_KP_EQUALSAS400 = SDL_SCANCODE_KP_EQUALSAS400 or SDLK_SCANCODE_MASK;

  SDLK_ALTERASE = SDL_SCANCODE_ALTERASE or SDLK_SCANCODE_MASK;
  SDLK_SYSREQ = SDL_SCANCODE_SYSREQ or SDLK_SCANCODE_MASK;
  SDLK_CANCEL = SDL_SCANCODE_CANCEL or SDLK_SCANCODE_MASK;
  SDLK_CLEAR = SDL_SCANCODE_CLEAR or SDLK_SCANCODE_MASK;
  SDLK_PRIOR = SDL_SCANCODE_PRIOR or SDLK_SCANCODE_MASK;
  SDLK_RETURN2 = SDL_SCANCODE_RETURN2 or SDLK_SCANCODE_MASK;
  SDLK_SEPARATOR = SDL_SCANCODE_SEPARATOR or SDLK_SCANCODE_MASK;
  SDLK_OUT = SDL_SCANCODE_OUT or SDLK_SCANCODE_MASK;
  SDLK_OPER = SDL_SCANCODE_OPER or SDLK_SCANCODE_MASK;
  SDLK_CLEARAGAIN = SDL_SCANCODE_CLEARAGAIN or SDLK_SCANCODE_MASK;
  SDLK_CRSEL = SDL_SCANCODE_CRSEL or SDLK_SCANCODE_MASK;
  SDLK_EXSEL = SDL_SCANCODE_EXSEL or SDLK_SCANCODE_MASK;

  SDLK_KP_00 = SDL_SCANCODE_KP_00 or SDLK_SCANCODE_MASK;
  SDLK_KP_000 = SDL_SCANCODE_KP_000 or SDLK_SCANCODE_MASK;
  SDLK_THOUSANDSSEPARATOR = SDL_SCANCODE_THOUSANDSSEPARATOR or SDLK_SCANCODE_MASK;
  SDLK_DECIMALSEPARATOR = SDL_SCANCODE_DECIMALSEPARATOR or SDLK_SCANCODE_MASK;
  SDLK_CURRENCYUNIT = SDL_SCANCODE_CURRENCYUNIT or SDLK_SCANCODE_MASK;
  SDLK_CURRENCYSUBUNIT = SDL_SCANCODE_CURRENCYSUBUNIT or SDLK_SCANCODE_MASK;
  SDLK_KP_LEFTPAREN = SDL_SCANCODE_KP_LEFTPAREN or SDLK_SCANCODE_MASK;
  SDLK_KP_RIGHTPAREN = SDL_SCANCODE_KP_RIGHTPAREN or SDLK_SCANCODE_MASK;
  SDLK_KP_LEFTBRACE = SDL_SCANCODE_KP_LEFTBRACE or SDLK_SCANCODE_MASK;
  SDLK_KP_RIGHTBRACE = SDL_SCANCODE_KP_RIGHTBRACE or SDLK_SCANCODE_MASK;
  SDLK_KP_TAB = SDL_SCANCODE_KP_TAB or SDLK_SCANCODE_MASK;
  SDLK_KP_BACKSPACE = SDL_SCANCODE_KP_BACKSPACE or SDLK_SCANCODE_MASK;
  SDLK_KP_A = SDL_SCANCODE_KP_A or SDLK_SCANCODE_MASK;
  SDLK_KP_B = SDL_SCANCODE_KP_B or SDLK_SCANCODE_MASK;
  SDLK_KP_C = SDL_SCANCODE_KP_C or SDLK_SCANCODE_MASK;
  SDLK_KP_D = SDL_SCANCODE_KP_D or SDLK_SCANCODE_MASK;
  SDLK_KP_E = SDL_SCANCODE_KP_E or SDLK_SCANCODE_MASK;
  SDLK_KP_F = SDL_SCANCODE_KP_F or SDLK_SCANCODE_MASK;
  SDLK_KP_XOR = SDL_SCANCODE_KP_XOR or SDLK_SCANCODE_MASK;
  SDLK_KP_POWER = SDL_SCANCODE_KP_POWER or SDLK_SCANCODE_MASK;
  SDLK_KP_PERCENT = SDL_SCANCODE_KP_PERCENT or SDLK_SCANCODE_MASK;
  SDLK_KP_LESS = SDL_SCANCODE_KP_LESS or SDLK_SCANCODE_MASK;
  SDLK_KP_GREATER = SDL_SCANCODE_KP_GREATER or SDLK_SCANCODE_MASK;
  SDLK_KP_AMPERSAND = SDL_SCANCODE_KP_AMPERSAND or SDLK_SCANCODE_MASK;
  SDLK_KP_DBLAMPERSAND = SDL_SCANCODE_KP_DBLAMPERSAND or SDLK_SCANCODE_MASK;
  SDLK_KP_VERTICALBAR = SDL_SCANCODE_KP_VERTICALBAR or SDLK_SCANCODE_MASK;
  SDLK_KP_DBLVERTICALBAR = SDL_SCANCODE_KP_DBLVERTICALBAR or SDLK_SCANCODE_MASK;
  SDLK_KP_COLON = SDL_SCANCODE_KP_COLON or SDLK_SCANCODE_MASK;
  SDLK_KP_HASH = SDL_SCANCODE_KP_HASH or SDLK_SCANCODE_MASK;
  SDLK_KP_SPACE = SDL_SCANCODE_KP_SPACE or SDLK_SCANCODE_MASK;
  SDLK_KP_AT = SDL_SCANCODE_KP_AT or SDLK_SCANCODE_MASK;
  SDLK_KP_EXCLAM = SDL_SCANCODE_KP_EXCLAM or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMSTORE = SDL_SCANCODE_KP_MEMSTORE or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMRECALL = SDL_SCANCODE_KP_MEMRECALL or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMCLEAR = SDL_SCANCODE_KP_MEMCLEAR or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMADD = SDL_SCANCODE_KP_MEMADD or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMSUBTRACT = SDL_SCANCODE_KP_MEMSUBTRACT or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMMULTIPLY = SDL_SCANCODE_KP_MEMMULTIPLY or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMDIVIDE = SDL_SCANCODE_KP_MEMDIVIDE or SDLK_SCANCODE_MASK;
  SDLK_KP_PLUSMINUS = SDL_SCANCODE_KP_PLUSMINUS or SDLK_SCANCODE_MASK;
  SDLK_KP_CLEAR = SDL_SCANCODE_KP_CLEAR or SDLK_SCANCODE_MASK;
  SDLK_KP_CLEARENTRY = SDL_SCANCODE_KP_CLEARENTRY or SDLK_SCANCODE_MASK;
  SDLK_KP_BINARY = SDL_SCANCODE_KP_BINARY or SDLK_SCANCODE_MASK;
  SDLK_KP_OCTAL = SDL_SCANCODE_KP_OCTAL or SDLK_SCANCODE_MASK;
  SDLK_KP_DECIMAL = SDL_SCANCODE_KP_DECIMAL or SDLK_SCANCODE_MASK;
  SDLK_KP_HEXADECIMAL = SDL_SCANCODE_KP_HEXADECIMAL or SDLK_SCANCODE_MASK;

  SDLK_LCTRL = SDL_SCANCODE_LCTRL or SDLK_SCANCODE_MASK;
  SDLK_LSHIFT = SDL_SCANCODE_LSHIFT or SDLK_SCANCODE_MASK;
  SDLK_LALT = SDL_SCANCODE_LALT or SDLK_SCANCODE_MASK;
  SDLK_LGUI = SDL_SCANCODE_LGUI or SDLK_SCANCODE_MASK;
  SDLK_RCTRL = SDL_SCANCODE_RCTRL or SDLK_SCANCODE_MASK;
  SDLK_RSHIFT = SDL_SCANCODE_RSHIFT or SDLK_SCANCODE_MASK;
  SDLK_RALT = SDL_SCANCODE_RALT or SDLK_SCANCODE_MASK;
  SDLK_RGUI = SDL_SCANCODE_RGUI or SDLK_SCANCODE_MASK;

  SDLK_MODE = SDL_SCANCODE_MODE or SDLK_SCANCODE_MASK;

  SDLK_AUDIONEXT = SDL_SCANCODE_AUDIONEXT or SDLK_SCANCODE_MASK;
  SDLK_AUDIOPREV = SDL_SCANCODE_AUDIOPREV or SDLK_SCANCODE_MASK;
  SDLK_AUDIOSTOP = SDL_SCANCODE_AUDIOSTOP or SDLK_SCANCODE_MASK;
  SDLK_AUDIOPLAY = SDL_SCANCODE_AUDIOPLAY or SDLK_SCANCODE_MASK;
  SDLK_AUDIOMUTE = SDL_SCANCODE_AUDIOMUTE or SDLK_SCANCODE_MASK;
  SDLK_MEDIASELECT = SDL_SCANCODE_MEDIASELECT or SDLK_SCANCODE_MASK;
  SDLK_WWW = SDL_SCANCODE_WWW or SDLK_SCANCODE_MASK;
  SDLK_MAIL = SDL_SCANCODE_MAIL or SDLK_SCANCODE_MASK;
  SDLK_CALCULATOR = SDL_SCANCODE_CALCULATOR or SDLK_SCANCODE_MASK;
  SDLK_COMPUTER = SDL_SCANCODE_COMPUTER or SDLK_SCANCODE_MASK;
  SDLK_AC_SEARCH = SDL_SCANCODE_AC_SEARCH or SDLK_SCANCODE_MASK;
  SDLK_AC_HOME = SDL_SCANCODE_AC_HOME or SDLK_SCANCODE_MASK;
  SDLK_AC_BACK = SDL_SCANCODE_AC_BACK or SDLK_SCANCODE_MASK;
  SDLK_AC_FORWARD = SDL_SCANCODE_AC_FORWARD or SDLK_SCANCODE_MASK;
  SDLK_AC_STOP = SDL_SCANCODE_AC_STOP or SDLK_SCANCODE_MASK;
  SDLK_AC_REFRESH = SDL_SCANCODE_AC_REFRESH or SDLK_SCANCODE_MASK;
  SDLK_AC_BOOKMARKS = SDL_SCANCODE_AC_BOOKMARKS or SDLK_SCANCODE_MASK;

  SDLK_BRIGHTNESSDOWN = SDL_SCANCODE_BRIGHTNESSDOWN or SDLK_SCANCODE_MASK;
  SDLK_BRIGHTNESSUP = SDL_SCANCODE_BRIGHTNESSUP or SDLK_SCANCODE_MASK;
  SDLK_DISPLAYSWITCH = SDL_SCANCODE_DISPLAYSWITCH or SDLK_SCANCODE_MASK;
  SDLK_KBDILLUMTOGGLE = SDL_SCANCODE_KBDILLUMTOGGLE or SDLK_SCANCODE_MASK;
  SDLK_KBDILLUMDOWN = SDL_SCANCODE_KBDILLUMDOWN or SDLK_SCANCODE_MASK;
  SDLK_KBDILLUMUP = SDL_SCANCODE_KBDILLUMUP or SDLK_SCANCODE_MASK;
  SDLK_EJECT = SDL_SCANCODE_EJECT or SDLK_SCANCODE_MASK;
  SDLK_SLEEP = SDL_SCANCODE_SLEEP or SDLK_SCANCODE_MASK;

  {**
   *  Enumeration of valid key mods (possibly OR'd together).
   *}

  KMOD_NONE = $0000;
  KMOD_LSHIFT = $0001;
  KMOD_RSHIFT = $0002;
  KMOD_LCTRL = $0040;
  KMOD_RCTRL = $0080;
  KMOD_LALT = $0100;
  KMOD_RALT = $0200;
  KMOD_LGUI = $0400;
  KMOD_RGUI = $0800;
  KMOD_NUM = $1000;
  KMOD_CAPS = $2000;
  KMOD_MODE = $4000;
  KMOD_RESERVED = $8000;

type

  TSDL_KeyMod = Word;

const
  KMOD_CTRL	 = KMOD_LCTRL  or KMOD_RCTRL;
  KMOD_SHIFT = KMOD_LSHIFT or KMOD_RSHIFT;
  KMOD_ALT	 = KMOD_LALT   or KMOD_RALT;
  KMOD_GUI	 = KMOD_LGUI   or KMOD_RGUI;

  //from "sdl_keyboard.h"

type  
  {**
   *  The SDL keysym structure, used in key events.
   *}

  TSDL_Keysym = record
    scancode: TSDL_ScanCode;      // SDL physical key code - see SDL_Scancode for details
    sym: TSDL_KeyCode;            // SDL virtual key code - see SDL_Keycode for details
    _mod: UInt16;                 // current key modifiers
    unicode: UInt32;              // (deprecated) use SDL_TextInputEvent instead
  end;

  {**
   *  Get the window which currently has keyboard focus.
   *}

  function SDL_GetKeyboardFocus: PSDL_Window cdecl external {$IFDEF GPC} name 'SDL_GetKeyboardFocus' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get a snapshot of the current state of the keyboard.
   *
   *  numkeys if non-nil, receives the length of the returned array.
   *  
   *  An array of key states. Indexes into this array are obtained by using SDL_Scancode values.
   *
   *}

  function SDL_GetKeyboardState(numkeys: PInt): PUInt8 cdecl external {$IFDEF GPC} name 'SDL_GetKeyboardState' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the current key modifier state for the keyboard.
   *}

  function SDL_GetModState: TSDL_KeyMod cdecl external {$IFDEF GPC} name 'SDL_GetModState' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the current key modifier state for the keyboard.
   *  
   *  This does not change the keyboard state, only the key modifier flags.
   *}

  procedure SDL_SetModState(modstate: TSDL_KeyMod) cdecl external {$IFDEF GPC} name 'SDL_SetModState' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the key code corresponding to the given scancode according
   *         to the current keyboard layout.
   *
   *  See SDL_Keycode for details.
   *  
   *  SDL_GetKeyName()
   *}

  function SDL_GetKeyFromScancode(scancode: TSDL_ScanCode): TSDL_KeyCode cdecl external {$IFDEF GPC} name 'SDL_GetKeyFromScancode' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get the scancode corresponding to the given key code according to the
   *         current keyboard layout.
   *
   *  See SDL_Scancode for details.
   *
   *  SDL_GetScancodeName()
   *}

  function SDL_GetScancodeFromKey(key: TSDL_KeyCode): TSDL_ScanCode cdecl external {$IFDEF GPC} name 'SDL_GetScancodeFromKey' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get a human-readable name for a scancode.
   *
   *  A pointer to the name for the scancode.
   *
   *  If the scancode doesn't have a name, this function returns
   *  an empty string ("").
   *
   *}

  function SDL_GetScancodeName(scancode: TSDL_ScanCode): PChar cdecl external {$IFDEF GPC} name 'SDL_GetScancodeName' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get a scancode from a human-readable name
   *
   *  scancode, or SDL_SCANCODE_UNKNOWN if the name wasn't recognized
   *
   *  SDL_Scancode
   *}

  function SDL_GetScancodeFromName(const name: PChar): TSDL_ScanCode cdecl external {$IFDEF GPC} name 'SDL_GetScancodeFromName' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get a human-readable name for a key.
   *
   *  A pointer to a UTF-8 string that stays valid at least until the next
   *  call to this function. If you need it around any longer, you must
   *  copy it.  If the key doesn't have a name, this function returns an
   *  empty string ("").
   *  
   *  SDL_Key
   *}

  function SDL_GetKeyName(key: TSDL_ScanCode): PChar cdecl external {$IFDEF GPC} name 'SDL_GetKeyName' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Get a key code from a human-readable name
   *
   *  key code, or SDLK_UNKNOWN if the name wasn't recognized
   *
   *  SDL_Keycode
   *}

  function SDL_GetKeyFromName(const char *name): TSDL_KeyCode cdecl external {$IFDEF GPC} name 'SDL_GetKeyFromName' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Start accepting Unicode text input events.
   *  This function will show the on-screen keyboard if supported.
   *  
   *  SDL_StopTextInput()
   *  SDL_SetTextInputRect()
   *  SDL_HasScreenKeyboardSupport()
   *}

  procedure SDL_StartTextInput cdecl external {$IFDEF GPC} name 'SDL_StartTextInput' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Return whether or not Unicode text input events are enabled.
   *
   *  SDL_StartTextInput()
   *  SDL_StopTextInput()
   *}

  function SDL_IsTextInputActive: TSDLBool cdecl external {$IFDEF GPC} name 'SDL_IsTextInputActive' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Stop receiving any text input events.
   *  This function will hide the on-screen keyboard if supported.
   *  
   *  SDL_StartTextInput()
   *  SDL_HasScreenKeyboardSupport()
   *}

  procedure SDL_StopTextInput cdecl external {$IFDEF GPC} name 'SDL_StopTextInput' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the rectangle used to type Unicode text inputs.
   *  This is used as a hint for IME and on-screen keyboard placement.
   *  
   *  SDL_StartTextInput()
   *}

  procedure SDL_SetTextInputRect(rect: PSDLRect) cdecl external {$IFDEF GPC} name 'SDL_SetTextInputRect' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Returns whether the platform has some screen keyboard support.
   *  
   *  SDL_TRUE if some keyboard support is available else SDL_FALSE.
   *
   *  Not all screen keyboard functions are supported on all platforms.
   *
   *  SDL_IsScreenKeyboardShown()
   *}

  function SDL_HasScreenKeyboardSupport: TSDLBool cdecl external {$IFDEF GPC} name 'SDL_HasScreenKeyboardSupport' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Returns whether the screen keyboard is shown for given window.
   *
   *  window The window for which screen keyboard should be queried.
   *
   *  Result - SDL_TRUE if screen keyboard is shown else SDL_FALSE.
   *
   *  SDL_HasScreenKeyboardSupport()
   *}

  function SDL_IsScreenKeyboardShown(SDL_Window *window): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_IsScreenKeyboardShown' {$ELSE} SDL_LibName {$ENDIF};

  //from "sdl_mouse.h"

const
  {**
   *  Cursor types for SDL_CreateSystemCursor.
   *}

  SDL_SYSTEM_CURSOR_ARROW = 0;     // Arrow
  SDL_SYSTEM_CURSOR_IBEAM = 1;     // I-beam
  SDL_SYSTEM_CURSOR_WAIT = 2;      // Wait
  SDL_SYSTEM_CURSOR_CROSSHAIR = 3; // Crosshair
  SDL_SYSTEM_CURSOR_WAITARROW = 4; // Small wait cursor (or Wait if not available)
  SDL_SYSTEM_CURSOR_SIZENWSE = 5;  // Double arrow pointing northwest and southeast
  SDL_SYSTEM_CURSOR_SIZENESW = 6;  // Double arrow pointing northeast and southwest
  SDL_SYSTEM_CURSOR_SIZEWE = 7;    // Double arrow pointing west and east
  SDL_SYSTEM_CURSOR_SIZENS = 8;    // Double arrow pointing north and south
  SDL_SYSTEM_CURSOR_SIZEALL = 9;   // Four pointed arrow pointing north, south, east, and west
  SDL_SYSTEM_CURSOR_NO = 10;        // Slashed circle or crossbones
  SDL_SYSTEM_CURSOR_HAND = 11;      // Hand
  SDL_NUM_SYSTEM_CURSORS = 12;

type

  TSDL_SystemCursor = Word;

  {* Function prototypes *}

  {**
   *  Get the window which currently has mouse focus.
   *}

  function SDL_GetMouseFocus: PSDL_Window cdecl external {$IFDEF GPC} name 'SDL_GetMouseFocus' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Retrieve the current state of the mouse.
   *  
   *  The current button state is returned as a button bitmask, which can
   *  be tested using the SDL_BUTTON(X) macros, and x and y are set to the
   *  mouse cursor position relative to the focus window for the currently
   *  selected mouse.  You can pass nil for either x or y.
   *
   * SDL_Button = 1 shl ((X)-1)
   *}

  function SDL_GetMouseState(x: PInt; y: PInt): UInt32 cdecl external {$IFDEF GPC} name 'SDL_GetMouseState' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Retrieve the relative state of the mouse.
   *
   *  The current button state is returned as a button bitmask, which can
   *  be tested using the SDL_BUTTON(X) macros, and x and y are set to the
   *  mouse deltas since the last call to SDL_GetRelativeMouseState().
   *}

  function SDL_GetRelativeMouseState(x: PInt; y: PInt): UInt32 cdecl external {$IFDEF GPC} name 'SDL_GetRelativeMouseState' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Moves the mouse to the given position within the window.
   *
   *   window The window to move the mouse into, or nil for the current mouse focus
   *   x The x coordinate within the window
   *   y The y coordinate within the window
   *
   *  This function generates a mouse motion event
   *}

  procedure SDL_WarpMouseInWindow(window: PSDL_Window; x: SInt32; y: SInt32) cdecl external {$IFDEF GPC} name 'SDL_WarpMouseInWindow' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set relative mouse mode.
   *
   *  enabled Whether or not to enable relative mode
   *
   *  0 on success, or -1 if relative mode is not supported.
   *
   *  While the mouse is in relative mode, the cursor is hidden, and the
   *  driver will try to report continuous motion in the current window.
   *  Only relative motion events will be delivered, the mouse position
   *  will not change.
   *  
   *  This function will flush any pending mouse motion.
   *  
   *  SDL_GetRelativeMouseMode()
   *}

  function SDL_SetRelativeMouseMode(enabled: TSDLBool): SInt32 cdecl external {$IFDEF GPC} name 'SDL_SetRelativeMouseMode' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Query whether relative mouse mode is enabled.
   *  
   *  SDL_SetRelativeMouseMode()
   *}

  function SDL_GetRelativeMouseMode: TSDLBool cdecl external {$IFDEF GPC} name 'SDL_GetRelativeMouseMode' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Create a cursor, using the specified bitmap data and
   *  mask (in MSB format).
   *
   *  The cursor width must be a multiple of 8 bits.
   *
   *  The cursor is created in black and white according to the following:
   *  <table>
   *  <tr><td> data </td><td> mask </td><td> resulting pixel on screen </td></tr>
   *  <tr><td>  0   </td><td>  1   </td><td> White </td></tr>
   *  <tr><td>  1   </td><td>  1   </td><td> Black </td></tr>
   *  <tr><td>  0   </td><td>  0   </td><td> Transparent </td></tr>
   *  <tr><td>  1   </td><td>  0   </td><td> Inverted color if possible, black 
   *                                         if not. </td></tr>
   *  </table>
   *  
   *  SDL_FreeCursor()
   *}

  function SDL_CreateCursor(const Uint8 * data,
                            const Uint8 * mask,
                            int w, int h, int hot_x,
                            int hot_y): PSDLCursor cdecl external {$IFDEF GPC} name 'SDL_CreateCursor' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Create a color cursor.
   *
   *  SDL_FreeCursor()
   *}

  function SDL_CreateColorCursor(SDL_Surface *surface,
                                 int hot_x,
                                 int hot_y): PSDL_Cursor cdecl external {$IFDEF GPC} name 'SDL_CreateColorCursor' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Create a system cursor.
   *
   *  SDL_FreeCursor()
   *}

  function SDL_CreateSystemCursor(SDL_SystemCursor id): PSDL_Cursor cdecl external {$IFDEF GPC} name 'SDL_CreateSystemCursor' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Set the active cursor.
   *}

  procedure SDL_SetCursor(cursor: PSDL_Cursor) cdecl external {$IFDEF GPC} name 'SDL_SetCursor' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Return the active cursor.
   *}

  function SDL_GetCursor: PSDL_Cursor cdecl external {$IFDEF GPC} name 'SDL_GetCursor' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Frees a cursor created with SDL_CreateCursor().
   *
   *  SDL_CreateCursor()
   *}

  procedure SDL_FreeCursor(cursor: PSDL_Cursor);

  {**
   *  Toggle whether or not the cursor is shown.
   *
   *  toggle 1 to show the cursor, 0 to hide it, -1 to query the current
   *                state.
   *  
   *  1 if the cursor is shown, or 0 if the cursor is hidden.
   *}

  function SDL_ShowCursor(toggle: SInt32): SInt32;

const
  {**
   *  Used as a mask when testing buttons in buttonstate.
   *   - Button 1:  Left mouse button
   *   - Button 2:  Middle mouse button
   *   - Button 3:  Right mouse button
   *}

  SDL_BUTTON_LEFT	  =	1
  SDL_BUTTON_MIDDLE	= 2
  SDL_BUTTON_RIGHT	= 3
  SDL_BUTTON_X1	    =	4
  SDL_BUTTON_X2	    =	5
  SDL_BUTTON_LMASK  =	1 shl ((SDL_BUTTON_LEFT) - 1);
  SDL_BUTTON_MMASK  =	1 shl ((SDL_BUTTON_MIDDLE) - 1);
  SDL_BUTTON_RMASK  =	1 shl ((SDL_BUTTON_RIGHT) - 1);
  SDL_BUTTON_X1MASK =	1 shl ((SDL_BUTTON_X1) - 1);
  SDL_BUTTON_X2MASK =	1 shl ((SDL_BUTTON_X2) - 1);

  //from "sdl_events.h"

  {**
   *  The types of events that can be delivered.
   *}

const

  SDL_FIRSTEVENT       = 0;     // Unused (do not remove) (needed in pascal?)

  { Application events }
  SDL_QUITEV           = $100;  // User-requested quit (originally SDL_QUIT, but changed, cause theres a method called SDL_QUIT)

  { Window events }
  SDL_WINDOWEVENT      = $200;  // Window state change
  SDL_SYSWMEVENT       = $201;  // System specific event 

  { Keyboard events }
  SDL_KEYDOWN          = $300;  // Key pressed 
  SDL_KEYUP            = $301;  // Key released
  SDL_TEXTEDITING      = $302;  // Keyboard text editing (composition) 
  SDL_TEXTINPUT        = $303;  // Keyboard text input 

  { Mouse events }
  SDL_MOUSEMOTION      = $400;  // Mouse moved 
  SDL_MOUSEBUTTONDOWN  = $401;  // Mouse button pressed 
  SDL_MOUSEBUTTONUP    = $402;  // Mouse button released 
  SDL_MOUSEWHEEL       = $403;  // Mouse wheel motion 

  { Joystick events }
  SDL_JOYAXISMOTION    = $600;  // Joystick axis motion 
  SDL_JOYBALLMOTION    = $601;  // Joystick trackball motion 
  SDL_JOYHATMOTION     = $602;  // Joystick hat position change 
  SDL_JOYBUTTONDOWN    = $603;  // Joystick button pressed 
  SDL_JOYBUTTONUP      = $604;  // Joystick button released 
  SDL_JOYDEVICEADDED   = $605;  // A new joystick has been inserted into the system 
  SDL_JOYDEVICEREMOVED = $606;  // An opened joystick has been removed 

  { Game controller events }
  SDL_CONTROLLERAXISMOTION     = $650;  // Game controller axis motion
  SDL_CONTROLLERBUTTONDOWN     = $651;  // Game controller button pressed 
  SDL_CONTROLLERBUTTONUP       = $652;  // Game controller button released 
  SDL_CONTROLLERDEVICEADDED    = $653;  // A new Game controller has been inserted into the system 
  SDL_CONTROLLERDEVICEREMOVED  = $654;  // An opened Game controller has been removed 
  SDL_CONTROLLERDEVICEREMAPPED = $655;  // The controller mapping was updated 

  { Touch events }
  SDL_FINGERDOWN      = $700;
  SDL_FINGERUP        = $701;
  SDL_FINGERMOTION    = $702;

  { Gesture events }
  SDL_DOLLARGESTURE   = $800;
  SDL_DOLLARRECORD    = $801;
  SDL_MULTIGESTURE    = $802;

  { Clipboard events }
  SDL_CLIPBOARDUPDATE = $900; // The clipboard changed

  { Drag and drop events }
  SDL_DROPFILE        = $1000; // The system requests a file open

  {** Events SDL_USEREVENT through SDL_LASTEVENT are for your use,
   *  and should be allocated with SDL_RegisterEvents()
   *}
  SDL_USEREVENT    = $8000;

  {**
   *  This last event is only for bounding internal arrays (needed in pascal ??)
   *}
  SDL_LASTEVENT    = $FFFF;

type

  TSDLEventType = Word;

  {**
   *  Fields shared by every event
   *}

  TSDLGenericEvent = record
    type_: UInt32;
    timestamp: UInt32;
  end;

  {**
   *  Window state change event data (event.window.*)
   *}

  TSDLWindowEvent = record
    type_: UInt32;       // SDL_WINDOWEVENT 
    timestamp: UInt32;
    windowID: UInt32;    // The associated window 
    event: UInt8;        // SDL_WindowEventID 
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    data1: SInt32;       // event dependent data
    data2: SInt32;       // event dependent data 
  end;

  {**
   *  Keyboard button event structure (event.key.*)
   *}
  TSDLKeyboardEvent = record
    type_: UInt32;        // SDL_KEYDOWN or SDL_KEYUP 
    timestamp: UInt32;
    windowID: UInt32;     // The window with keyboard focus, if any 
    state: UInt8;         // SDL_PRESSED or SDL_RELEASED 
    _repeat: UInt8;       // Non-zero if this is a key repeat
    padding2: UInt8;
    padding3: UInt8;
    keysym: TSDLKeySym;  // The key that was pressed or released
  end;

const
  SDL_TEXTEDITINGEVENT_TEXT_SIZE = 32;
  
type
 
  {**
   *  Keyboard text editing event structure (event.edit.*)
   *}
 
  TSDLTextEditingEvent = record
    type_: UInt32;                               // SDL_TEXTEDITING 
    timestamp: UInt32;
    windowID: UInt32;                            // The window with keyboard focus, if any
    text: array[0..SDL_TEXTEDITINGEVENT_TEXT_SIZE] of Char;  // The editing text 
    start: SInt32;                               // The start cursor of selected editing text 
    length: SInt32;                              // The length of selected editing text
  end;

const
  SDL_TEXTINPUTEVENT_TEXT_SIZE = 32;

type

  {**
   *  Keyboard text input event structure (event.text.*)
   *}
 
  TSDLTextInputEvent = record
    type_: UInt32;                                          // SDL_TEXTINPUT 
    timestamp: UInt32;
    windowID: UInt32;                                       // The window with keyboard focus, if any
    text: array[0..SDL_TEXTINPUTEVENT_TEXT_SIZE] of Char;   // The input text 
  end;

  {**
   *  Mouse motion event structure (event.motion.*)
   *}
 
  TSDLMouseMotionEvent = record
    type_: UInt32;       // SDL_MOUSEMOTION
    timestamp: UInt32;
    windowID: UInt32;    // The window with mouse focus, if any 
    which: UInt32;       // The mouse instance id, or SDL_TOUCH_MOUSEID
    state: UInt8;        // The current button state 
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    x: SInt32;           // X coordinate, relative to window 
    y: SInt32;           // Y coordinate, relative to window
    xrel: SInt32;        // The relative motion in the X direction 
    yrel: SInt32;        // The relative motion in the Y direction 
  end;

  {**
   *  Mouse button event structure (event.button.*)
   *}
 
  TSDLMouseButtonEvent = record
    type_: UInt32;       // SDL_MOUSEBUTTONDOWN or SDL_MOUSEBUTTONUP 
    timestamp: UInt32;
    windowID: UInt32;    // The window with mouse focus, if any
    which: UInt32;       // The mouse instance id, or SDL_TOUCH_MOUSEID 
    button: UInt8;       // The mouse button index 
    state: UInt8;        // SDL_PRESSED or SDL_RELEASED
    padding1: UInt8;
    padding2: UInt8;
    x: SInt32;           // X coordinate, relative to window
    y: SInt32;           // Y coordinate, relative to window 
  end;

  {**
   *  Mouse wheel event structure (event.wheel.*)
   *}
 
  TSDLMouseWheelEvent = record
    type_: UInt32;        // SDL_MOUSEWHEEL
    timestamp: UInt32;
    windowID: UInt32;    // The window with mouse focus, if any 
    which: UInt32;       // The mouse instance id, or SDL_TOUCH_MOUSEID
    x: SInt32;           // The amount scrolled horizontally 
    y: SInt32;           // The amount scrolled vertically 
  end;

  {**
   *  Joystick axis motion event structure (event.jaxis.*)
   *}
 
  TSDLJoyAxisEvent = record
    type_: UInt32;         // SDL_JOYAXISMOTION 
    timestamp: UInt32;
    which: TSDLJoystickID; // The joystick instance id
    axis: UInt8;           // The joystick axis index 
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    value: SInt16;         // The axis value (range: -32768 to 32767) 
    padding4: UInt16;
  end;

  {**
   *  Joystick trackball motion event structure (event.jball.*)
   *}

  TSDLJoyBallEvent = record
    type_: UInt32;         // SDL_JOYBALLMOTION
    timestamp: UInt32;
    which: TSDLJoystickID; // The joystick instance id
    ball: UInt8;           // The joystick trackball index
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    xrel: SInt16;          // The relative motion in the X direction
    yrel: SInt16;          // The relative motion in the Y direction
  end;

  {**
   *  Joystick hat position change event structure (event.jhat.*)
   *}

  TSDLJoyHatEvent = record
    type_: UInt32;         // SDL_JOYHATMOTION
    timestamp: UInt32;
    which: TSDLJoystickID; // The joystick instance id
    hat: UInt8;            // The joystick hat index
    value: UInt8;         {*  The hat position value.
                           *  SDL_HAT_LEFTUP   SDL_HAT_UP       SDL_HAT_RIGHTUP
                           *  SDL_HAT_LEFT     SDL_HAT_CENTERED SDL_HAT_RIGHT
                           *  SDL_HAT_LEFTDOWN SDL_HAT_DOWN     SDL_HAT_RIGHTDOWN
                           *
                           *  Note that zero means the POV is centered.
                           *}
    padding1: UInt8;
    padding2: UInt8;
  end;

  {**
   *  Joystick button event structure (event.jbutton.*)
   *}

  TSDLJoyButtonEvent = record
    type_: UInt32;        // SDL_JOYBUTTONDOWN or SDL_JOYBUTTONUP
    timestamp: UInt32;
    which: TSDLJoystickID; // The joystick instance id 
    button: UInt8;         // The joystick button index 
    state: UInt8;          // SDL_PRESSED or SDL_RELEASED
    padding1: UInt8;
    padding2: UInt8;
  end;

  {**
   *  Joystick device event structure (event.jdevice.*)
   *}

  TSDLJoyDeviceEvent = record
    type_: UInt32;      // SDL_JOYDEVICEADDED or SDL_JOYDEVICEREMOVED
    timestamp: UInt32;
    which: SInt32;      // The joystick device index for the ADDED event, instance id for the REMOVED event
  end;

  {**
   *  Game controller axis motion event structure (event.caxis.*)
   *}

  TSDLControllerAxisEvent = record
    type_: UInt32;         // SDL_CONTROLLERAXISMOTION
    timestamp: UInt32;
    which: TSDLJoystickID; // The joystick instance id
    axis: UInt8;           // The controller axis (SDL_GameControllerAxis)
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    value: SInt16;         // The axis value (range: -32768 to 32767)
    padding4: UInt16;
  end;

  {**
   *  Game controller button event structure (event.cbutton.*)
   *}

  TSDLControllerButtonEvent = record
    type_: UInt32;         // SDL_CONTROLLERBUTTONDOWN or SDL_CONTROLLERBUTTONUP
    timestamp: UInt32;
    which: TSDLJoystickID; // The joystick instance id
    button: UInt8;         // The controller button (SDL_GameControllerButton)
    state: UInt8;          // SDL_PRESSED or SDL_RELEASED
    padding1: UInt8;
    padding2: UInt8;
  end;


  {**
   *  Controller device event structure (event.cdevice.*)
   *}

  TSDLControllerDeviceEvent = record
    type_: UInt32;       // SDL_CONTROLLERDEVICEADDED, SDL_CONTROLLERDEVICEREMOVED, or SDL_CONTROLLERDEVICEREMAPPED
    timestamp: UInt32;
    which: SInt32;       // The joystick device index for the ADDED event, instance id for the REMOVED or REMAPPED event
  end;

  {**
   *  Touch finger event structure (event.tfinger.*)
   *}

  TSDLTouchFingerEvent = record
    type_: UInt32;         // SDL_FINGERMOTION or SDL_FINGERDOWN or SDL_FINGERUP
    timestamp: UInt32;
    touchId: TSDLTouchID;  // The touch device id
    fingerId: TSDLFingerID;
    x: Float;              // Normalized in the range 0...1
    y: Float;              // Normalized in the range 0...1
    dx: Float;             // Normalized in the range 0...1
    dy: Float;             // Normalized in the range 0...1
    pressure: Float;       // Normalized in the range 0...1
  end;

  {**
   *  Multiple Finger Gesture Event (event.mgesture.*)
   *}
  TSDLMultiGestureEvent = record
    type_: UInt32;        // SDL_MULTIGESTURE
    timestamp: UInt32;
    touchId: TSDLTouchID; // The touch device index
    dTheta: Float;
    dDist: Float;
    x: Float;
    y: Float;
    numFingers: UInt16;
    padding: UInt16;
  end;


  {* (event.dgesture.*) *}
  TSDLDollarGestureEvent = record
    type_: UInt32;         // SDL_DOLLARGESTURE
    timestamp: UInt32;
    touchId: TSDLTouchID;  // The touch device id
    gestureId: TSDLGestureID;
    numFingers: UInt32;
    error: Float;
    x: Float;              // Normalized center of gesture
    y: Float;              // Normalized center of gesture
  end;


  {**
   *  An event used to request a file open by the system (event.drop.*)
   *  This event is disabled by default, you can enable it with SDL_EventState()
   *  If you enable this event, you must free the filename in the event.
   *}

  TSDL_DropEvent = record
    type_: UInt32;      // SDL_DROPFILE
    timestamp: UInt32;
    _file: PAnsiChar;   // The file name, which should be freed with SDL_free() 
  end;

  {**
   *  The "quit requested" event
   *}

  TSDL_QuitEvent = record
    type_: UInt32;        // SDL_QUIT
    timestamp: UInt32;
  end;

  {**
   *  A user-defined event type (event.user.*)
   *}

  TSDL_UserEvent = record
    type_: UInt32;       // SDL_USEREVENT through SDL_NUMEVENTS-1
    timestamp: UInt32;
    windowID: UInt32;    // The associated window if any
    code: SInt32;        // User defined event code
    data1: Pointer;      // User defined data pointer
    data2: Pointer;      // User defined data pointer
  end;

  {$IFDEF Unix}
    //These are the various supported subsystems under UNIX
    TSDL_SysWm = ( SDL_SYSWM_X11 ) ;
  {$ENDIF}

  // The windows custom event structure
  {$IFDEF Windows}
    PSDL_SysWMmsg = ^TSDL_SysWMmsg;
    TSDL_SysWMmsg = record
      version: TSDLVersion;
      h_wnd: HWND; // The window for the message
      msg: UInt; // The type of message
      w_Param: WPARAM; // WORD message parameter
      lParam: LPARAM; // LONG message parameter
    end;
  {$ELSE}

    {$IFDEF Unix}
      { The Linux custom event structure }
      PSDL_SysWMmsg = ^TSDL_SysWMmsg;
      TSDL_SysWMmsg = record
        version : TSDLVersion;
        subsystem : TSDLSysWm;
        {$IFDEF FPC}
          event : TXEvent;
        {$ELSE}
          event : XEvent;
        {$ENDIF}
      end;
    {$ELSE}
      { The generic custom event structure }
      PSDL_SysWMmsg = ^TSDL_SysWMmsg;
      TSDL_SysWMmsg = record
        version: TSDLVersion;
        data: Integer;
      end;
    {$ENDIF}

  {$ENDIF}

  // The Windows custom window manager information structure
  {$IFDEF Windows}
    PSDL_SysWMinfo = ^TSDL_SysWMinfo;
    TSDL_SysWMinfo = record
      version : TSDLVersion;
      window : HWnd;	// The display window
    end;
  {$ELSE}
    // The Linux custom window manager information structure
    {$IFDEF Unix}
      TX11 = record
        display : PDisplay;	// The X11 display
        window : TWindow;		// The X11 display window */
        {* These locking functions should be called around
           any X11 functions using the display variable.
           They lock the event thread, so should not be
           called around event functions or from event filters.
         *}
        lock_func : Pointer;
        unlock_func : Pointer;

        // Introduced in SDL 1.0.2
        fswindow : TWindow;	// The X11 fullscreen window */
        wmwindow : TWindow;	// The X11 managed input window */
      end;

      PSDL_SysWMinfo = ^TSDL_SysWMinfo;
      TSDL_SysWMinfo = record
         version : TSDLVersion;
         subsystem : TSDLSysWm;
         X11 : TX11;
      end;
    {$ELSE}
      // The generic custom window manager information structure
      PSDL_SysWMinfo = ^TSDLSysWMinfo;
      TSDL_SysWMinfo = record
        version : TSDLVersion;
        data : integer;
      end;
    {$ENDIF}

  {$ENDIF}

  {**
   *  A video driver dependent system event (event.syswm.*)
   *  This event is disabled by default, you can enable it with SDL_EventState()
   *
   *  If you want to use this event, you should include SDL_syswm.h.
   *}

  PSDLSysWMEvent = ^TSDLSysWMEvent;
  TSDLSysWMEvent = record
    type_: UInt32;       // SDL_SYSWMEVENT
    timestamp: UInt32;
    msg: PSDLSysWMmsg;  // driver dependent data (defined in SDL_syswm.h)
  end;

  {**
   *  General event structure
   *}

  PSDLEvent = ^TSDLEvent;
  TSDLEvent = record
    case Integer of
      0:  (type_: UInt32);

      SDL_GENERICEVENT:  (generic: TSDLGenericEvent);
      SDL_WINDOWEVENT:  (window: TSDLWindowEvent);

      SDL_KEYUP,
      SDL_KEYDOWN:  (key: TSDLKeyboardEvent);
      SDL_TEXTEDITING:  (edit: TSDLTextEditingEvent);
      SDL_TEXTINPUT:  (text: TSDLTextInputEvent);

      SDL_MOUSEMOTION:  (motion: TSDLMouseMotionEvent);
      SDL_MOUSEBUTTONUP,
      SDL_MOUSEBUTTONDOWN:  (button: TSDLMouseButtonEvent);
      SDL_MOUSEWHEEL:  (wheel: TSDLMouseWheelEvent);
	  
      SDL_JOYAXISMOTION:  (jaxis: TSDLJoyAxisEvent);
      SDL_JOYBALLMOTION: (jball: TSDLJoyBallEvent);
      SDL_JOYHATMOTION: (jhat: TSDLJoyHatEvent);
      SDL_JOYBUTTONDOWN,
      SDL_JOYBUTTONUP: (jbutton: TSDLJoyButtonEvent);
      SDL_JOYDEVICEADDED,
      SDL_JOYDEVICEREMOVED: (jdevice: TSDLJoyDeviceEvent);

      SDL_CONTROLLERAXISMOTION: (caxis: TSDLControllerAxisEvent);
      SDL_CONTROLLERBUTTONUP,
      SDL_CONTROLLERBUTTONDOWN: (cbutton: TSDLControllerButtonEvent);
      SDL_CONTROLLERDEVICEADDED,
      SDL_CONTROLLERDEVICEREMOVED,
      SDL_CONTROLLERDEVICEREMAPPED: (cdevice: TSDLControllerDeviceEvent);

      SDL_QUITEV: (quit: TSDLQuitEvent);

      SDL_USEREVENT: (user: TSDLUserEvent);
      SDL_SYSWMEVENT: (syswm: TSDLSysWMEvent);

      SDL_TOUCHFINGERDOWN,
      SDL_TOUCHFINGERUP,
      SDL_TOUCHFINGERMOTION: (tfinger: TSDLTouchFingerEvent);
      SDL_MULTIGESTURE: (mgesture: TSDLMultiGestureEvent);
      SDL_DOLLARGESTURE,SDL_DOLLARRECORD: (dgesture: TSDLDollarGestureEvent);

      SDL_DROPFILE: (drop: TSDLDropEvent);
	  end;
  end;


  {* Function prototypes *}

  {**
   *  Pumps the event loop, gathering events from the input devices.
   *  
   *  This function updates the event queue and internal input device state.
   *  
   *  This should only be run in the thread that sets the video mode.
   *}
  procedure SDL_PumpEvents cdecl external {$IFDEF GPC} name 'SDL_PumpEvents' {$ELSE} SDL_LibName {$ENDIF};

const
  SDL_ADDEVENT = 0;
  SDL_PEEKEVENT = 1;
  SDL_GETEVENT = 2;

type
  TSDLEventAction = Word;

  {**
   *  Checks the event queue for messages and optionally returns them.
   *
   *  If action is SDL_ADDEVENT, up to numevents events will be added to
   *  the back of the event queue.
   *
   *  If action is SDL_PEEKEVENT, up to numevents events at the front
   *  of the event queue, within the specified minimum and maximum type,
   *  will be returned and will not be removed from the queue.
   *
   *  If action is SDL_GETEVENT, up to numevents events at the front
   *  of the event queue, within the specified minimum and maximum type,
   *  will be returned and will be removed from the queue.
   *
   *  Result: The number of events actually stored, or -1 if there was an error.
   *
   *  This function is thread-safe.
   *}

  function SDL_PeepEvents(events: PSDLEvent; numevents: SInt32; action: TSDL_EventAction; minType: UInt32; maxType: UInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_PeepEvents' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Checks to see if certain event types are in the event queue.
   *}
 
  function SDL_HasEvent(type_: UInt32): TSDLBool  cdecl external {$IFDEF GPC} name 'SDL_HasEvent' {$ELSE} SDL_LibName {$ENDIF};
  function SDL_HasEvents(minType: UInt32; maxType: UInt32): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_HasEvents' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  This function clears events from the event queue
   *}

  procedure SDL_FlushEvent(type_: UInt32) cdecl external {$IFDEF GPC} name 'SDL_FlushEvent' {$ELSE} SDL_LibName {$ENDIF};
  procedure SDL_FlushEvents(minType: UInt32; maxType: UInt32) cdecl external {$IFDEF GPC} name 'SDL_FlushEvents' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Polls for currently pending events.
   *
   *  1 if there are any pending events, or 0 if there are none available.
   *  
   *  event - If not nil, the next event is removed from the queue and
   *               stored in that area.
   *}

  function SDL_PollEvent(event: PSDLEvent): SInt32 cdecl external {$IFDEF GPC} name 'SDL_PollEvent' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Waits indefinitely for the next available event.
   *  
   *  1, or 0 if there was an error while waiting for events.
   *   
   *  event - If not nil, the next event is removed from the queue and 
   *  stored in that area.
   *}
 
  function SDL_WaitEvent(event: PSDLEvent): SInt32 cdecl external {$IFDEF GPC} name 'SDL_WaitEvent' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Waits until the specified timeout (in milliseconds) for the next
   *  available event.
   *  
   *  1, or 0 if there was an error while waiting for events.
   *  
   *  event - If not nil, the next event is removed from the queue and
   *  stored in that area.
   *}
 
  function SDL_WaitEventTimeout(event: PSDLEvent; timeout: SInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_WaitEventTimeout' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Add an event to the event queue.
   *  
   *  1 on success, 0 if the event was filtered, or -1 if the event queue
   *  was full or there was some other error.
   *}

  function SDL_PushEvent(event: PSDLEvent): SInt32 cdecl external {$IFDEF GPC} name 'SDL_PumpEvents' {$ELSE} SDL_LibName {$ENDIF};

  {$IFNDEF GPC}
    TSDLEventFilter = function( event: PSDLEvent ): Integer; cdecl;
  {$ELSE}
    TSDLEventFilter = function( event: PSDLEvent ): Integer;
  {$ENDIF}

  {**
   *  Sets up a filter to process all events before they change internal state and
   *  are posted to the internal event queue.
   *  
   *  If the filter returns 1, then the event will be added to the internal queue.
   *  If it returns 0, then the event will be dropped from the queue, but the 
   *  internal state will still be updated.  This allows selective filtering of
   *  dynamically arriving events.
   *  
   *  Be very careful of what you do in the event filter function, as 
   *  it may run in a different thread!
   *  
   *  There is one caveat when dealing with the SDL_QUITEVENT event type.  The
   *  event filter is only called when the window manager desires to close the
   *  application window.  If the event filter returns 1, then the window will
   *  be closed, otherwise the window will remain open if possible.
   *
   *  If the quit event is generated by an interrupt signal, it will bypass the
   *  internal queue and be delivered to the application at the next event poll.
   *}
 
  procedure SDL_SetEventFilter(filter: TSDLEventFilter; userdata: Pointer) cdecl external {$IFDEF GPC} name 'SDL_SetEventFilter' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Return the current event filter - can be used to "chain" filters.
   *  If there is no event filter set, this function returns SDL_FALSE.
   *}

  function SDL_GetEventFilter(filter: PSDLEventFilter; userdata: Pointer): TSDLBool cdecl external {$IFDEF GPC} name 'SDL_GetEventFilter' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Add a function which is called when an event is added to the queue.
   *}
 
  procedure SDL_AddEventWatch(filter: TSDLEventFilter, userdata: Pointer) cdecl external {$IFDEF GPC} name 'SDL_AddEventWatch' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Remove an event watch function added with SDL_AddEventWatch()
   *}
 
  procedure SDL_DelEventWatch(filter: TSDLEventFilter, userdata: Pointer) cdecl external {$IFDEF GPC} name 'SDL_DelEventWatch' {$ELSE} SDL_LibName {$ENDIF};

  {**
   *  Run the filter function on the current event queue, removing any
   *  events for which the filter returns 0.
   *}

  procedure SDL_FilterEvents(filter: TSDLEventFilter; userdata: Pointer);

const

  SDL_QUERY   =	-1
  SDL_IGNORE  =	 0
  SDL_DISABLE =	 0
  SDL_ENABLE  =  1

  {**
   *  This function allows you to set the state of processing certain events.
   *   - If state is set to SDL_IGNORE, that event will be automatically
   *     dropped from the event queue and will not event be filtered.
   *   - If state is set to SDL_ENABLE, that event will be processed
   *     normally.
   *   - If state is set to SDL_QUERY, SDL_EventState() will return the
   *     current processing state of the specified event.
   *}

  function SDL_EventState(type_: UInt32; state: SInt32): UInt8 cdecl external {$IFDEF GPC} name 'SDL_EventState' {$ELSE} SDL_LibName {$ENDIF};

  procedure SDL_GetEventState(type_: UInt32);

  {**
   *  This function allocates a set of user-defined events, and returns
   *  the beginning event number for that set of events.
   *
   *  If there aren't enough user-defined events left, this function
   *  returns (Uint32)-1
   *}
   
  function SDL_RegisterEvents(numevents: SInt32): UInt32 cdecl external {$IFDEF GPC} name 'SDL_RegisterEvents' {$ELSE} SDL_LibName {$ENDIF};

  //from "sdl.h"

const

  SDL_INIT_TIMER          = $00000001;
  {$EXTERNALSYM SDL_INIT_TIMER}
  SDL_INIT_AUDIO          = $00000010;
  {$EXTERNALSYM SDL_INIT_AUDIO}
  SDL_INIT_VIDEO          = $00000020;
  {$EXTERNALSYM SDL_INIT_VIDEO}
  SDL_INIT_JOYSTICK       = $00000200;
  {$EXTERNALSYM SDL_INIT_JOYSTICK}
  SDL_INIT_HAPTIC         = $00001000;
  {$EXTERNALSYM SDL_INIT_HAPTIC}
  SDL_INIT_GAMECONTROLLER = $00002000;  //turn on game controller also implicitly does JOYSTICK 
  {$EXTERNALSYM SDL_INIT_GAMECONTROLLER}
  SDL_INIT_NOPARACHUTE    = $00100000;  //Don't catch fatal signals
  {$EXTERNALSYM SDL_INIT_NOPARACHUTE}
  SDL_INIT_EVERYTHING     = SDL_INIT_TIMER    or
							SDL_INIT_AUDIO    or
							SDL_INIT_VIDEO    or
							SDL_INIT_JOYSTICK or
							SDL_INIT_HAPTIC   or
							SDL_INIT_GAMECONTROLLER;
  {$EXTERNALSYM SDL_INIT_EVERYTHING}

{**
 *  This function initializes  the subsystems specified by flags
 *  Unless the SDL_INIT_NOPARACHUTE flag is set, it will install cleanup
 *  signal handlers for some commonly ignored fatal signals (like SIGSEGV).
 *}

function SDL_Init(flags: UInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_Init' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  This function initializes specific SDL subsystems
 *}
 
function SDL_InitSubSystem(flags: UInt32): SInt32 cdecl external {$IFDEF GPC} name 'SDL_InitSubSystem' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  This function cleans up specific SDL subsystems
 *}
 
procedure SDL_QuitSubSystem(flags: UInt32) cdecl external {$IFDEF GPC} name 'SDL_QuitSubSystem' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  This function returns a mask of the specified subsystems which have
 *  previously been initialized.
 *  
 *  If flags is 0, it returns a mask of all initialized subsystems.
 *}
 
function SDL_WasInit(flags: UInt32): UInt32 cdecl external {$IFDEF GPC} name 'SDL_WasInit' {$ELSE} SDL_LibName {$ENDIF};

{**
 *  This function cleans up all initialized subsystems. You should
 *  call it upon all exit conditions.
 *}
 
procedure SDL_Quit cdecl external {$IFDEF GPC} name 'SDL_Quit' {$ELSE} SDL_LibName {$ENDIF};

implementation

//from "sdl_rect.h"
function SDL_RectEmpty(X: TSDLRect): Boolean;
begin
  Result := (X.w <= 0) or (X.h <= 0);
end;

function SDL_RectEquals(A: TSDLRect; B: TSDLRect);
begin
  Result := (A.x = B.x) and (A.y = B.y) and (A.w = B.w) and (A.h = B.h);
end;

//from "sdl_pixels.h"
function SDL_IsPixelFormat_FOURCC(format: Variant): Boolean;
begin
  {* The flag is set to 1 because 0x1? is not in the printable ASCII range *}
  Result := format and SDL_PIXELFLAG(format) <> 1;
end;

//from "sdl_surface.h"
function SDL_LoadBMP(file_: PChar);
begin
  SDL_LoadBMP_RW(SDL_RWFromFile(file_, "rb"), 1);
end;

//from "sdl_video.h"
function SDL_WindowPos_IsUndefined(X: Variant): Variant;
begin
  Result := (X and $FFFF0000) == SDL_WINDOWPOS_UNDEFINED_MASK;
end;

function SDL_WindowPos_IsCentered(X: Variant): Variant;
begin
  Result := (X and $FFFF0000) == SDL_WINDOWPOS_CENTERED_MASK;
end;

//from "sdl_events.h"

procedure SDL_GetEventState(type_: UInt32);
begin
  SDL_EventState(type_, SDL_QUERY);
end;

end.
