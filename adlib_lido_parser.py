#%%
import lxml.etree as ET
import pandas as pd

'''ETL parse XSLT and parse XML(Adlib)  and transform XML(adlib) into XML LIDO'''

dom = ET.parse("/Users/oliviervandhuynslager/PycharmProjects/DesignMuseumGent/Datasets/exports/20200120_DMG_OBJ_OBJECTSTORIES.xml")
xslt = ET.parse("/Users/oliviervandhuynslager/PycharmProjects/DesignMuseumGent/Tools/adlib - lido/LIDO_DMG.xsl")
transform = ET.XSLT(xslt)
newdom = transform(dom)

result = ET.tostring(newdom, pretty_print=True)
print(result)

