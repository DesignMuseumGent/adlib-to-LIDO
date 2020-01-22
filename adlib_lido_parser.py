#%%
import lxml.etree as ET
from xml.dom import minidom

'''ETL parse XSLT and parse XML(Adlib)  and transform XML(adlib) into XML LIDO'''

dom = ET.parse("/Users/oliviervandhuynslager/Documents/GitHub/adlib-to-LIDO/WOLFERS_TEST_INPUT(ADLIB).xml")
xslt = ET.parse("/Users/oliviervandhuynslager/Documents/GitHub/adlib-to-LIDO/LIDO_DMG.xsl")
transform = ET.XSLT(xslt)
newdom = transform(dom)
newdom.write("WOLFERS_TEST_OUTPUT(LIDO).xml")

result = ET.tostring(newdom, pretty_print=True)
print(result)

