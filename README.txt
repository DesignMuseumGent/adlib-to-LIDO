##DESIGN MUSEUM GENT - ADLIB XML TO LIDO XML PARSER.##

LIDO is an XML harvesting schema. The schema is intended for delivering metadata, for use in a variety of online services, from an organization’s online collections database to portals of aggregated resources, as well as exposing, sharing and connecting data on the web. It is not intended to be used as a basis for a collection management system or to support loan and acquisition activities.
The strength of LIDO lies in its ability to support the full range of descriptive information about museum objects. It can be used for all kinds of object, e.g. art, architecture, cultural history, history of technology, and natural history.
LIDO supports multilingual portal environments. It does this by having a language attribute that can be associated with each element, or more generally, with the group of descriptive elements for fully multilingual resources.

#ObjectClassificationWrap:#

  *Object_name
  *Object_category

#ObjectIdentificationWrap:#

  *Object_title
  *Title_translation
  *Object_number

#EventWrap:#

  *Creator
  *Creator_qualifier
  *Production_date(start/precision/end/precision)
  *Production_place

  *Dimension

  *Acquisition_source
  *Acqusuition: Current_owner
  *Acquisition: method 
  *Acquisitiomn: date 

  *owner hist: source
  *owner hist: owner
  *owner hist: date end/date start
  *owner hist: acquisition method
  *owner hist: notes

  *exhibition hist; ID's
  *exhibition hist; title
  *exhibition hist; organizer
  *exhibition hist; venue + venue location
  *exhibition hist; start date - end date 

  *loan out: ID's
  *loan out: title
  *loan out: location
  *loan out: title (exhibition)
  *loan out: startdate - enddate


TODO:
- reconciliate PID's from thesaurus to parse in LIDO xml. >
 via lref? For loop? Xpath / python?

- fix priref issue. not parsing. 


