#%%
import lxml.etree as ET

## import

'''1. parse export ADLIB (grouped XML)'''
'''2. parse xsl (for transformation)'''

dom = ET.parse("/Users/oliviervandhuynslager/Documents/GitHub/adlib-to-LIDO/20200121_DMG_OBJ_WOLFERS.xml")
xslt = ET.parse("/Users/oliviervandhuynslager/Documents/GitHub/adlib-to-LIDO/LIDO_DMG.xsl")

##transformation

transform = ET.XSLT(xslt)
newdom = transform(dom)
newdom.write("WOLFERS_TEST_OUTPUT(LIDO).xml") ##output directory, filename.
print(ET.tostring(newdom, pretty_print=True))

'''NOTE: reformat code after parsing to restructure XML'''
