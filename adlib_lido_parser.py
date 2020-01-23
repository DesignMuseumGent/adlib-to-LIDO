#%%
import lxml.etree as ET

dom = ET.parse("/Users/oliviervandhuynslager/Documents/GitHub/adlib-to-LIDO/20200121_DMG_OBJ_WOLFERS.xml")
xslt = ET.parse("/Users/oliviervandhuynslager/Documents/GitHub/adlib-to-LIDO/LIDO_DMG.xsl")
transform = ET.XSLT(xslt)
newdom = transform(dom)
newdom.write("WOLFERS_TEST_OUTPUT(LIDO).xml")
print(ET.tostring(newdom, pretty_print=True))
