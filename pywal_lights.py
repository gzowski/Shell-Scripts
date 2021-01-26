#!/usr/bin/python

from phue import Bridge

hexlist = []
#Location of colors file for pywal
with open ('~/.cache/wal/colors', 'rt') as filecol:
        for hexcol in filecol:
                hexlist.append(hexcol)
def hex_to_rgb(value):
        value = value.lstrip('#')
        return list(int(value[i:i+2], 16) for i in (0, 2, 4))

#Primary Light Colour
#hexlist[0] = color0 hexlist[1] = color1 and so on for terminal colours.
rgbp = hex_to_rgb(hexlist[1])
#Secondary Light Colour
rgbs = hex_to_rgb(hexlist[2])

frgbp = [x / 255.0 for x in rgbp]
frgbs = [x / 255.0 for x in rgbs]

frp = float(format(frgbp[0]))
fgp = float(format(frgbp[1]))
fbp = float(format(frgbp[2]))
frs = float(format(frgbs[0]))
fgs = float(format(frgbs[1]))
fbs = float(format(frgbs[2]))

def rgb_to_xy(red, green, blue):
        red = pow((red + 0.055) / (1.0 + 0.055), 2.4) if red > 0.04045 else (red / 12.92)
        green = pow((green + 0.055) / (1.0 + 0.055), 2.4) if green > 0.04045 else (green / 12.92)
        blue =  pow((blue + 0.055) / (1.0 + 0.055), 2.4) if blue > 0.04045 else (blue / 12.92)
        x = red * 0.649926 + green * 0.103455 + blue * 0.197109
        y = red * 0.234327 + green * 0.743075 + blue * 0.022598
        z = green * 0.053077 + blue * 1.035763
        x = x / (x + y + z)
        y = y / (x + y + z)
        return [x, y]
xyp = rgb_to_xy(frp,fgp,fbp)
xys = rgb_to_xy(frs,fgs,fbs)

#Philips Hue Bridge IP
b = Bridge('***.***.***.***')
#Connect to Bridge
b.connect()

#Get API
b.get_api()

#Get Light Names
lights = b.get_light_objects('name')

#Set Light Colour (xyp = primary, xys = Secondary)
lights["Living room main"].xy = xyp
lights["Living room lamp"].xy = xys
#Set Lights ON
lights["Living room main"].on = True
lights["Living room lamp"].on = True
#Set Light Brightness 100%
lights["Living room main"].brightness = 255
lights["Living room lamp"].brightness = 255
#Set Light Saturation
lights["Living room main"].saturation = 200
lights["Living room lamp"].saturation = 200
