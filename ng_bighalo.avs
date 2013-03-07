#Copyright (c) 2013, John Stout <jstout.physics@gmail.com>
#http://en.wikipedia.org/wiki/ISC_license

LoadCPlugin("C:/mf/NGcode/TASEncodingPackage/programs/freesub.dll")

function ng_sub(
\   clip clp,
\ string "text",
\    int "first_frame",
\    int "last_frame",
\    int "text_color",
\    int "halo_color",
\    int "x",
\    int "y",
\ string "font",
\    int "size",
\    int "align",
\    int "lsp",
\    int "font_width",
\    int "halo_width",
\    int "halo_height",
\    int "x_scale",
\    int "y_scale",
\    int "text_color8",
\    int "halo_color8",
\    int "font8",
\    int "spc8",
\    int "lsp8",
\    int "align8",
\    int "x8",
\    int "y8",
\    int "size8",
\    int "font_width8",
\    int "font_angle8",
\ string "halo8",
\ string "shadow8"
\){

    #Version 4 2012/12/3

    text = default( text, "This is a tool-assisted recording.\n" + \
                          "For details, visit http://TASVideos.org/")
    first_frame = default(first_frame, 0)
    last_frame  = default( last_frame, first_frame + 299)
    text_color  = default( text_color, $00DDDDDD)
    halo_color  = default( halo_color, $80000000)
    font        = default(       font, "helvB12")
    font_real   = "C:/mf/NGcode/TASEncodingPackage/fonts/"+ font +".bdf"
    lsp         = default(        lsp, 0)
    x_scale     = default(    x_scale, 8)
    y_scale     = default(    y_scale, x_scale)
    align       = default(      align, 8)
    align_x = align % 3
    align_y = (align - 1) / 3
    default_x = (align_x == 0) ? clp.width - 8 : \
                (align_x == 2) ? clp.width / 2 : 8
    default_y = (align_y == 0) ? clp.height - 8 : \
                (align_y == 1) ? clp.height / 2 : 8
    x8 = (defined(x)) ? default(x8, x*x_scale) : default_x
    y8 = (defined(y)) ? default(y8, y*y_scale) : default_y
    x           = default(          x, default_x)
    y           = default(          y, default_y)
    size        = default(       size, 1)
    font_width  = default( font_width, size)
    halo_width  = default( halo_width, 2)
    halo_height = default(halo_height, 2)

    text_color8 = default(text_color8, text_color)
    halo_color8 = default(halo_color8, halo_color)
    font8       = default(      font8, "Ariel")
    spc8        = default(       spc8, 0)
    lsp8        = default(       lsp8, lsp*y_scale)
    align8      = default(     align8, align)
    size8       = default(      size8, 112)
    font_width8 = default(font_width8, 0)
    font_angle8 = default(font_angle8, 0)
    halo_radius8 = 0
    mode8        = ""
    
    #OO@
    #   OO@
    #      O@
    #        @
    #         @
    #          @
    #          O
    #           @
    #           O
    #           O
    #            @
    #            O
    #@           O

    #using an unfilled circle reduces the number of calculations
    #by a factor of ~16
    circle_12_jagged="0 0 "+\
    "  2 12   5 11   7 10   8 9 "+\
    "  12 2   11 5   10 7   9 8 "+\
    " -2 12  -5 11  -7 10  -8 9 "+\
    " -12 2  -11 5  -10 7  -9 8 "+\
    "-2 -12 -5 -11 -7 -10 -8 -9 "+\
    "-12 -2 -11 -5 -10 -7 -9 -8 "+\
    " 2 -12  5 -11  7 -10  8 -9 "+\
    " 12 -2  11 -5  10 -7  9 -8 "

    circle_12="0 0 "+\
    "12 0 0 12 -12 0 0 -12 "+\
    "1 12 2 12 3 11 4 11 5 11 6 10 7 10 8 9 "+\
    "12 1 12 2 11 3 11 4 11 5 10 6 10 7 9 8 "+\
    "-1 12 -2 12 -3 11 -4 11 -5 11 -6 10 -7 10 -8 9 "+\
    "-12 1 -12 2 -11 3 -11 4 -11 5 -10 6 -10 7 -9 8 "+\
    "-1 -12 -2 -12 -3 -11 -4 -11 -5 -11 -6 -10 -7 -10 -8 -9 "+\
    "-12 -1 -12 -2 -11 -3 -11 -4 -11 -5 -10 -6 -10 -7 -9 -8 "+\
    "1 -12  2 -12 3 -11 4 -11 5 -11 6 -10 7 -10 8 -9 "+\
    "12 -1  12 -2 11 -3 11 -4 11 -5 10 -6 10 -7 9 -8 "

    halo8        = default(          halo8, circle_12)
    shadow8      = default(        shadow8, " -4 -8")

    sub = FreeSub(clp, text, x, y, first_frame, last_frame, \
        font_real, size, text_color, halo_color, align, lsp, \
        font_width, halo_width, halo_height)

    sub_HD = ng_bighalo(clp, text, x8, y8, first_frame, last_frame, \
        font8, size8, text_color8, halo_color8, align8, spc8, lsp8, \
        font_width8, font_angle8, halo=halo8, shadow=shadow8)
        
    (clp.height >= 1080) ? sub_HD : sub
}

function ng_bighalo(
\   clip clp,
\ string text,
\  float "x",
\  float "y",
\    int "first_frame",
\    int "last_frame",
\ string "font",
\  float "size",
\    int "text_color",
\    int "halo_color",
\    int "align",
\    int "spc",
\    int "lsp",
\  float "font_width",
\  float "font_angle",
\    int "halo_radius",
\ string "mode",
\ string "halo",
\ string "shadow"
\){
 
    #Version 16-17 2012/12/1
    # - added circle_12 as default
    # - reworked math to avoid bitwise functions that are only
    #   availible in experimental builds
    #Version 15 2012/12/1
    # - drop shadow added
    # - halo_radius still works, but calculating the points of
    #   a hollow circle for halo is much faster
    # - mode is depricated since memo-ing isn't as needed
 
    first_frame = default(first_frame, 0)
    last_frame  = default( last_frame, first_frame + 299)
    font        = default(       font, "Ariel")
    size        = default(       size, 112)
    x           = default(          x, -1)
    y           = default(          y, -1)
    text_color  = default( text_color, $00DDDDDD)
    halo_color  = default( halo_color, $80000000)
    align       = default(      align, 5)
    spc         = default(        spc, 0)
    lsp         = default(        lsp, 0)
    font_width  = default( font_width, 0)
    font_angle  = default( font_angle, 0)
    shadow      = default(     shadow, " -4 -8")
    w           = clp.width
    h           = clp.height
    ###
       ###
          ##
            #
             #
              #
              #
               #
               #
               #
                #
                #
    #           #
    circle_12="0 0 "+\
    "12 0 0 12 -12 0 0 -12 "+\
    "1 12 2 12 3 11 4 11 5 11 6 10 7 10 8 9 "+\
    "12 1 12 2 11 3 11 4 11 5 10 6 10 7 9 8 "+\
    "-1 12 -2 12 -3 11 -4 11 -5 11 -6 10 -7 10 -8 9 "+\
    "-12 1 -12 2 -11 3 -11 4 -11 5 -10 6 -10 7 -9 8 "+\
    "-1 -12 -2 -12 -3 -11 -4 -11 -5 -11 -6 -10 -7 -10 -8 -9 "+\
    "-12 -1 -12 -2 -11 -3 -11 -4 -11 -5 -10 -6 -10 -7 -9 -8 "+\
    "1 -12  2 -12 3 -11 4 -11 5 -11 6 -10 7 -10 8 -9 "+\
    "12 -1  12 -2 11 -3 11 -4 11 -5 10 -6 10 -7 9 -8 "
    halo = (defined(halo_radius)) ? mt_circle(halo_radius) : circle_12
 
    invis = BlankClip(1, w, h, pixel_type="YV12")
    tm = Subtitle(invis, text, x, y, 0, 0, font, size, $00FFFFFF,\
        0, align, spc, lsp, font_width, font_angle)
    text_mask = tm.mt_expand(mode="0 0 "+shadow, chroma="-128")
    halo_mask = text_mask.mt_expand(mode=halo, chroma="-128")
   
    h0      = halo_color%$01000000
    h_color = (h0>=0) ? h0 : $01000000+h0
    t0      = text_color%$01000000
    t_color = (t0>=0) ? t0 : $01000000+t0
    h_alpha = (halo_color>=0) ? 255-(halo_color/$01000000) : (-halo_color-1)/$01000000
    t_alpha = (text_color>=0) ? 255-(text_color/$01000000) : (-text_color-1)/$01000000
    lut_str = string(h_alpha)+ " x * 255 / " +string(t_alpha)+\
              " " +string(h_alpha)+ " - y * 255 / +"
 
    alpha_mask = mt_lutxy(halo_mask, text_mask, lut_str)
 
    hc = BlankClip(1, w, h, color=h_color)
    tc = Subtitle(hc, text, x, y, 0, 0, font, size, t_color,\
        0, align, spc, lsp, font_width, font_angle)
    overlay = tc.Mask(alpha_mask.ConvertToRGB32())
   
    clp.ApplyRange(first_frame, last_frame, "Layer", overlay)
}
