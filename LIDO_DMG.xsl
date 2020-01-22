<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">

        <lido:lidoWrap xmlns:lido="http://www.lido-schema.org"
                       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                       xsi:schemaLocation="http://www.lido-schema.org http://www.lido-schema.org/schema/v1.0/lido-v1.0.xs">
            <xsl:for-each select="./adlibXML/recordList/record">
                <lido:lido>
                    <lido:lidoRecID lido:source="Olivier Van D'huynslager (Design Museum Gent)" lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./priref"/></lido:lidoRecID>
                    <lido:descriptiveMetadata xml:lang="nl-NL">
                            <lido:objectClassificationWrap>
                                <lido:objectWorkTypeWrap>
                                    <!-- OGPELET: voor elke Object_name node moet er een objectWorkType node zijn.
                                     Hier is het belangrijk om <xsl:choose> te gebruiken. ObjectWorkType moet verplicht ingevuld worden voor een lido Record!
                                     indien er geen object type gedefinieerd werd door de instelling moet er alsnog een lido:objectWorkType aangemaakt worden maar leeg. 
                                      -->
                                    <xsl:choose>
                                        <xsl:when test="./Object_name">
                                            <xsl:for-each select="./Object_name">
                                                <lido:objectWorkType>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./object_name.lref"/></lido:conceptID>
                                                    <lido:term><xsl:value-of select="./object_name/value"/></lido:term>
                                                </lido:objectWorkType>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <lido:ObjectWorkType>
                                                <lido:term></lido:term>
                                            </lido:ObjectWorkType>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </lido:objectWorkTypeWrap>
                                <lido:classificationWrap>
                                    <!--for each object category their needs to be one classification node
                                     todo object_category (parse error)-->
                                    <xsl:choose>
                                        <xsl:when test="./object_category">
                                            <xsl:for-each select="./object_category">
                                                <lido:classification>
                                                    <!--voor lido:conceptID moet de waarde van objectcategorie.lref gemapped worden -->
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of
                                                            select="./object_category.lref"/></lido:conceptID>
                                                    <lido:term><xsl:value-of select="./object_category/value"/></lido:term>
                                                </lido:classification>
                                            </xsl:for-each>
                                        </xsl:when>
                                     </xsl:choose>

                                </lido:classificationWrap>
                            </lido:objectClassificationWrap>

                            <lido:ObjectIdentificationWrap>
                                <lido:titleWrap>
                                    <!--do we need languages here? -->
                                    <xsl:choose>
                                        <xsl:when test="./Title">
                                            <xsl:for-each select="./Title">
                                                <lido:titleSet>
                                                    <lido:appellationValue><xsl:value-of select="./title/value"/></lido:appellationValue>
                                                </lido:titleSet>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <lido:titleSet>
                                                <lido:appellationValue></lido:appellationValue>
                                            </lido:titleSet>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="./Titel_translatotion[1]/title.translation">
                                        <lido:titleSet>
                                            <lido:appellationValue><xsl:value-of select="./Titel_translation[1]/title.translation"/></lido:appellationValue>
                                        </lido:titleSet>
                                    </xsl:if>
                                     <xsl:if test="./Titel_translatotion[2]/title.translation">
                                        <lido:titleSet>
                                            <lido:appellationValue><xsl:value-of select="./Titel_translation[2]/title.translation"/></lido:appellationValue>
                                        </lido:titleSet>
                                    </xsl:if>
                                    <xsl:if test="./Titel_translatotion[3]/title.translation">
                                        <lido:titleSet>
                                            <lido:appellationValue><xsl:value-of select="./Titel_translation[3]/title.translation"/></lido:appellationValue>
                                        </lido:titleSet>
                                    </xsl:if>
                                </lido:titleWrap>
                                <lido:repositoryWrap>
                                    <lido:repositorySet>
                                        <lido:repositoryName>
                                            <lido:LegalBodyID lido:type="ISIL"></lido:LegalBodyID>
                                            <lido:LegalBodyName>
                                                <lido:appelationValue>Design Museum Gent</lido:appelationValue>
                                            </lido:LegalBodyName>
                                        </lido:repositoryName>
                                        <lido:workID lido:type="object number"><xsl:value-of select="./object_number"/></lido:workID>
                                    </lido:repositorySet>
                                </lido:repositoryWrap>

                            </lido:ObjectIdentificationWrap>

                        <!--LIDO EVENT WRAPPER -->

                            <lido:eventWrap>
                                <xsl:if test="Production | Production_date">
                                    <lido:eventSet>
                                        <lido:event>
                                            <lido:eventType><lido:term>production</lido:term></lido:eventType>


                                            <xsl:for-each select="./Production">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of
                                                                    select="./creator.lref"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appelationValue><xsl:value-of select="./creator/value"/></lido:appelationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor>
                                                            <lido:term><xsl:value-of select="./creator.role/value"/></lido:term>
                                                        </lido:roleActor>
                                                        <xsl:if test="./creator.qualifier">
                                                            <lido:attributionQualifierActor><xsl:value-of select="./creator.qualifier"/></lido:attributionQualifierActor>
                                                        </xsl:if>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:for-each>

                                            <!--PRODUCTION DATES -->

                                            <xsl:if test="Production_date">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="./Production_date/production.date.start.prec"/>;<xsl:value-of
                                                            select="./Production_date/production.date.start"/>;<xsl:value-of
                                                            select="./Production_date/production.date.end.prec"/><xsl:value-of
                                                            select="./Production_date/production.date.end"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate><xsl:value-of select="./Production_date/production.date.start"/></lido:earliestDate>
                                                        <lido:latestDate><xsl:value-of select="./Production_date/production.date.end"/></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!--PRODUCTION PLACE -->
                                           <xsl:if test="./production.place"> 
                                                <lido:eventPlace> 
                                                    <lido:place> 
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./production.place.lref"/></lido:placeID> 
                                                        <lido:namePlaceSet> 
                                                            <lido:appellationValue><xsl:value-of select="./production.place"/></lido:appellationValue> 
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace> 
                                            </xsl:if>


                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>

                                <!-- PEDIGREE -->

                                <xsl:if test="Acquisition_source | current_owner | acquisition.date | acquisition.method | acquisition.place | acquisition.notes">
                                    <lido:eventSet>
                                        <lido:event>
                                            <lido:eventType>
                                                <lido:term>acquisition</lido:term>
                                            </lido:eventType>

                                            <!-- ACQUISITION SOURCE -->

                                            <xsl:for-each select="./Acquisition_source">
                                                <lido:eventActor>
                                                    <lido:Actor>
                                                        <lido:ActorID lido:type="local" lido:label="Adlib database number"><xsl:value-of
                                                                select="acquisition.source.lref"/></lido:ActorID>
                                                        <lido:nameActorSet>
                                                            <lido:appelationValue><xsl:value-of select="./acquisition.source/value"/></lido:appelationValue>
                                                        </lido:nameActorSet>
                                                    </lido:Actor>
                                                    <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                                </lido:eventActor>
                                            </xsl:for-each>

                                            <!-- CURRENT OWNER -->

                                            <xsl:if test="current_owner">
                                            <lido:eventActor>
                                                <lido:actorInRole>
                                                    <lido:actor>
                                                        <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="current_owner.lref"/></lido:actorID>
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="./current_owner"/></lido:appellationValue>
                                                        </lido:nameActorSet>
                                                    </lido:actor>
                                                    <lido:roleActor><lido:term>acquirer</lido:term></lido:roleActor>
                                                </lido:actorInRole>
                                            </lido:eventActor>
                                            </xsl:if>

                                            <!-- ACQUISITION PLACE -->

                                            <xsl:if test="acquisition.date">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="./acquisition.date.precision"/>;<xsl:value-of select="./acquisition.date"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate><xsl:value-of select="./acquisition.date"/></lido:earliestDate>
                                                        <lido:latestDate><xsl:value-of select="./acquisition.date"/></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>

                                            <!-- ACQUISITION PLACE -->

                                            <xsl:if test="acquisition.place">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number">
                                                            <xsl:value-of select="./acquisition.place.lref"/>
                                                        </lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="./acquisition.place"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>

                                            <!-- ACQUISITION METHOD -->

                                            <xsl:if test="./acquisition.method">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number">
                                                        <xsl:value-of select="./acquisition.method.lref"/>
                                                    </lido:conceptID>
                                                    <lido:term>
                                                        <xsl:value-of select="./acquisition.method"/>
                                                    </lido:term>
                                                </lido:eventMethod>
                                            </xsl:if>

                                            <!-- ACQUISITION NOTES -->

                                            <xsl:if test="./acquisition.notes">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue>
                                                        <xsl:value-of select="./acquisition.notes"/>
                                                    </lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>

                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>

                                <!-- OWNERHIST: ACQUIRED FROM | OWNER | DATE START | DATE END | PLACE | NOTES -->
                                <!-- OWNER HISTORY ITERATION 1-->

                                <xsl:if test="owner_hist.acquired_from | owner_hist.owner | owner_hist.date.start | owner_hist.date.end |owner_hist.notes">
                                    <xsl:if test="owner_hist.acquired_from[1] | owner_hist.owner[1] | owner_hist.date.start[1] | owner_hist.date.end[1] | owner_hist.notes[1]">
                                        <lido:eventSet>
                                            <lido:eventType>

                                                <!-- DEFAULT: PROVENANCE -->

                                                <lido:term>provenance</lido:term>
                                            </lido:eventType>

                                            <!-- ACQUISITION SOURCE [1] -->
                                            
                                            <xsl:if test="./owner_hist.acquired_from[1]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number">
                                                                <xsl:value-of select="./owner_hist.acquired_from.lref[1]"/>
                                                            </lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue>
                                                                    <xsl:value-of select="./owner_hist.acquired_from[1]/value"/>
                                                                </lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- Pedigree:OWNER [1] (target) --> 
                                            
                                            <xsl:if test="./owner_hist.owner[1]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number">
                                                                <xsl:value-of select="./owner_hist.owner.lref[1]"/>
                                                            </lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue>
                                                                    <xsl:value-of select="./owner_hist.owner[1]/value"/>
                                                                </lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- OWNER HISTORY: DATE START -OR- DATE END [1] -->
                                            
                                            <xsl:if test="./owner_hist.date.start[1] or owner_hist.date.end[1]">
                                                <lido:eventDate>
                                                    <lido:displayDate>
                                                        <xsl:value-of select="./owner_hist.date.start[1]"/>;<xsl:value-of
                                                            select="./owner_hist.date.end[1]"/>
                                                    </lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate>
                                                            <xsl:value-of select="./owner_hist.date.start[1]"/>
                                                        </lido:earliestDate>
                                                        <lido:latestDate>
                                                            <xsl:value-of select="./owner_hist.date.end[1]"/>
                                                        </lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: PLACE [1]-->

                                            <xsl:if test="./owner_hist.place[1]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number">
                                                            <xsl:value-of select="./owner_hist.place.lref[1]"/>
                                                        </lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue>
                                                                <xsl:value-of select="./owner_hist.place[1]/value"/>
                                                            </lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>

                                            <!-- OWNER HISTORY:  ACQUISITION METHOD [1] -->

                                            <xsl:if test="./owner_hist.acquisition.method[1]">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number">
                                                        <xsl:value-of select="./owner_hist.acquisition.method.lref[1]"/>
                                                    </lido:conceptID>
                                                    <lido:term>
                                                        <xsl:value-of select="./owner_hist.acquisition.method[1]/value"/>
                                                    </lido:term>
                                                </lido:eventMethod>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: NOTES [1] -->

                                            <xsl:if test="./owner_hist.notes[1]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[1]/value"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>

                                        </lido:eventSet>
                                    </xsl:if>
                                </xsl:if>

                                <!-- OWNER HISTORY ITERATION 2-->

                                <xsl:if test="owner_hist.acquired_from | owner_hist.owner | owner_hist.date.start | owner_hist.date.end |owner_hist.notes">
                                    <xsl:if test="owner_hist.acquired_from[2] | owner_hist.owner[2] | owner_hist.date.start[2] | owner_hist.date.end[2] | owner_hist.notes[2]">
                                        <lido:eventSet>
                                            <lido:eventType>

                                                <!-- DEFAULT: PROVENANCE -->

                                                <lido:term>provenance</lido:term>
                                            </lido:eventType>

                                            <!-- ACQUISITION SOURCE [2] -->

                                            <xsl:if test="./owner_hist.acquired_from[2]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number">
                                                                <xsl:value-of select="./owner_hist.acquired_from.lref[2]"/>
                                                            </lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue>
                                                                    <xsl:value-of select="./owner_hist.acquired_from[2]/value"/>
                                                                </lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>

                                            <!-- Pedigree:OWNER [2] (target) -->

                                            <xsl:if test="./owner_hist.owner[2]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number">
                                                                <xsl:value-of select="./owner_hist.owner.lref[2]"/>
                                                            </lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue>
                                                                    <xsl:value-of select="./owner_hist.owner[2]/value"/>
                                                                </lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: DATE START -OR- DATE END [2] -->

                                            <xsl:if test="./owner_hist.date.start[1] or owner_hist.date.end[2]">
                                                <lido:eventDate>
                                                    <lido:displayDate>
                                                        <xsl:value-of select="./owner_hist.date.start[2]"/>;<xsl:value-of
                                                            select="./owner_hist.date.end[2]"/>
                                                    </lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate>
                                                            <xsl:value-of select="./owner_hist.date.start[2]"/>
                                                        </lido:earliestDate>
                                                        <lido:latestDate>
                                                            <xsl:value-of select="./owner_hist.date.end[2]"/>
                                                        </lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: PLACE [2]-->

                                            <xsl:if test="./owner_hist.place[2]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number">
                                                            <xsl:value-of select="./owner_hist.place.lref[2]"/>
                                                        </lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue>
                                                                <xsl:value-of select="./owner_hist.place[2]/value"/>
                                                            </lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>

                                            <!-- OWNER HISTORY:  ACQUISITION METHOD [2] -->

                                            <xsl:if test="./owner_hist.acquisition.method[2]">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number">
                                                        <xsl:value-of select="./owner_hist.acquisition.method.lref[2]"/>
                                                    </lido:conceptID>
                                                    <lido:term>
                                                        <xsl:value-of select="./owner_hist.acquisition.method[2]/value"/>
                                                    </lido:term>
                                                </lido:eventMethod>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: NOTES [2] -->

                                            <xsl:if test="./owner_hist.notes[2]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[2]/value"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>

                                        </lido:eventSet>
                                    </xsl:if>
                                </xsl:if>

                                <!-- OWNER HISTORY ITERATION 3-->

                                <xsl:if test="owner_hist.acquired_from | owner_hist.owner | owner_hist.date.start | owner_hist.date.end |owner_hist.notes">
                                    <xsl:if test="owner_hist.acquired_from[3] | owner_hist.owner[3] | owner_hist.date.start[3] | owner_hist.date.end[3] | owner_hist.notes[3]">
                                        <lido:eventSet>
                                            <lido:eventType>

                                                <!-- DEFAULT: PROVENANCE -->

                                                <lido:term>provenance</lido:term>
                                            </lido:eventType>

                                            <!-- ACQUISITION SOURCE [3] -->

                                            <xsl:if test="./owner_hist.acquired_from[3]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number">
                                                                <xsl:value-of select="./owner_hist.acquired_from.lref[3]"/>
                                                            </lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue>
                                                                    <xsl:value-of select="./owner_hist.acquired_from[3]/value"/>
                                                                </lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>

                                            <!-- Pedigree:OWNER [3] (target) -->

                                            <xsl:if test="./owner_hist.owner[3]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number">
                                                                <xsl:value-of select="./owner_hist.owner.lref[3]"/>
                                                            </lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue>
                                                                    <xsl:value-of select="./owner_hist.owner[3]/value"/>
                                                                </lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: DATE START -OR- DATE END [3] -->

                                            <xsl:if test="./owner_hist.date.start[3] or owner_hist.date.end[3]">
                                                <lido:eventDate>
                                                    <lido:displayDate>
                                                        <xsl:value-of select="./owner_hist.date.start[3]"/>;<xsl:value-of
                                                            select="./owner_hist.date.end[3]"/>
                                                    </lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate>
                                                            <xsl:value-of select="./owner_hist.date.start[3]"/>
                                                        </lido:earliestDate>
                                                        <lido:latestDate>
                                                            <xsl:value-of select="./owner_hist.date.end[3]"/>
                                                        </lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: PLACE [3]-->

                                            <xsl:if test="./owner_hist.place[3]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number">
                                                            <xsl:value-of select="./owner_hist.place.lref[3]"/>
                                                        </lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue>
                                                                <xsl:value-of select="./owner_hist.place[3]/value"/>
                                                            </lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>

                                            <!-- OWNER HISTORY:  ACQUISITION METHOD [3] -->

                                            <xsl:if test="./owner_hist.acquisition.method[1]">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number">
                                                        <xsl:value-of select="./owner_hist.acquisition.method.lref[3]"/>
                                                    </lido:conceptID>
                                                    <lido:term>
                                                        <xsl:value-of select="./owner_hist.acquisition.method[3]/value"/>
                                                    </lido:term>
                                                </lido:eventMethod>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: NOTES [3] -->

                                            <xsl:if test="./owner_hist.notes[3]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[3]/value"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>

                                        </lido:eventSet>
                                    </xsl:if>
                                </xsl:if>

                                <!-- OWNER HISTORY ITERATION 4-->

                                <xsl:if test="owner_hist.acquired_from | owner_hist.owner | owner_hist.date.start | owner_hist.date.end |owner_hist.notes">
                                    <xsl:if test="owner_hist.acquired_from[4] | owner_hist.owner[4] | owner_hist.date.start[4] | owner_hist.date.end[4] | owner_hist.notes[4]">
                                        <lido:eventSet>
                                            <lido:eventType>

                                                <!-- DEFAULT: PROVENANCE -->

                                                <lido:term>provenance</lido:term>
                                            </lido:eventType>

                                            <!-- ACQUISITION SOURCE [4] -->

                                            <xsl:if test="./owner_hist.acquired_from[4]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number">
                                                                <xsl:value-of select="./owner_hist.acquired_from.lref[4]"/>
                                                            </lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue>
                                                                    <xsl:value-of select="./owner_hist.acquired_from[4]/value"/>
                                                                </lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>

                                            <!-- Pedigree:OWNER [4] (target) -->

                                            <xsl:if test="./owner_hist.owner[4]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number">
                                                                <xsl:value-of select="./owner_hist.owner.lref[4]"/>
                                                            </lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue>
                                                                    <xsl:value-of select="./owner_hist.owner[4]/value"/>
                                                                </lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: DATE START -OR- DATE END [4] -->

                                            <xsl:if test="./owner_hist.date.start[4] or owner_hist.date.end[4]">
                                                <lido:eventDate>
                                                    <lido:displayDate>
                                                        <xsl:value-of select="./owner_hist.date.start[4]"/>;<xsl:value-of
                                                            select="./owner_hist.date.end[4]"/>
                                                    </lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate>
                                                            <xsl:value-of select="./owner_hist.date.start[4]"/>
                                                        </lido:earliestDate>
                                                        <lido:latestDate>
                                                            <xsl:value-of select="./owner_hist.date.end[4]"/>
                                                        </lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: PLACE [4]-->

                                            <xsl:if test="./owner_hist.place[4]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number">
                                                            <xsl:value-of select="./owner_hist.place.lref[4]"/>
                                                        </lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue>
                                                                <xsl:value-of select="./owner_hist.place[4]/value"/>
                                                            </lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>

                                            <!-- OWNER HISTORY:  ACQUISITION METHOD [4] -->

                                            <xsl:if test="./owner_hist.acquisition.method[4]">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number">
                                                        <xsl:value-of select="./owner_hist.acquisition.method.lref[4]"/>
                                                    </lido:conceptID>
                                                    <lido:term>
                                                        <xsl:value-of select="./owner_hist.acquisition.method[4]/value"/>
                                                    </lido:term>
                                                </lido:eventMethod>
                                            </xsl:if>

                                            <!-- OWNER HISTORY: NOTES [1] -->

                                            <xsl:if test="./owner_hist.notes[4]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[4]/value"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>

                                        </lido:eventSet>
                                    </xsl:if>
                                </xsl:if>

                                <!-- EXHIBITION HISTORY-->
                                <!-- events in eventSet -->

                                <xsl:if test="./Exhibition">
                                    <xsl:for-each select="./Exhibition">
                                        <lido:eventSet>
                                            <lido:event>

                                                <!-- LOCAL ID FOR EXHIBTIONS (REFERENCE NUMBER | CATALOGUE NUMBER | LREF -->

                                                <lido:eventID lido:type="local reference number">
                                                    <xsl:value-of select="./exhibition.reference_number"/>
                                                </lido:eventID>
                                                <lido:eventID lido:type="local catalogue number">
                                                    <xsl:value-of select="./exhibition.catalogue_number"/>
                                                </lido:eventID>
                                                <lido:eventID lido:type="Adlib database number">
                                                    <xsl:value-of select="./exhibition.lref"/>
                                                </lido:eventID>

                                                <!-- EXHIBITION TITLE-->

                                                <xsl:if test="./exhibition">
                                                    <lido:eventName>
                                                        <lido:appellationValue>
                                                            <xsl:value-of select="./exhibition"/>
                                                        </lido:appellationValue>
                                                    </lido:eventName>
                                                </xsl:if>

                                                <!-- EXHIBITION ORGANIZER -->

                                                <xsl:if test="./exhibition.organiser">
                                                    <lido:eventActor>
                                                        <lido:actorInRole>
                                                            <lido:actor>
                                                                <lido:nameActorSet>
                                                                    <lido:appellationValue>
                                                                        <xsl:value-of select="./exhibition.organiser"/>
                                                                    </lido:appellationValue>
                                                                </lido:nameActorSet>
                                                            </lido:actor>
                                                        </lido:actorInRole>
                                                    </lido:eventActor>
                                                </xsl:if>

                                                <!-- EXHIBITION DATE START - END -->

                                                <xsl:if test="./exhitbition.date.start or ./exhibition.date.end">
                                                    <lido:eventDate>
                                                        <lido:date>
                                                            <lido:earliestDate>
                                                                <xsl:value-of select="./exhibtion.date.start"/>
                                                            </lido:earliestDate>
                                                            <lido:latestDate>
                                                                <xsl:value-of select="./exhibition.date.end"/>
                                                            </lido:latestDate>
                                                        </lido:date>
                                                    </lido:eventDate>
                                                </xsl:if>

                                                <!-- EXHIBITION LOCATION -->

                                                <xsl:if test="./exhibition.venue or ./exhibition.venue.place">
                                                    <lido:eventPlace>
                                                        <lido:place>
                                                            <lido:namePlaceSet>
                                                                <xsl:value-of select="./exhibition.venue"/>;<xsl:value-of
                                                                    select="./exhibition.venue.place"/>
                                                            </lido:namePlaceSet>
                                                        </lido:place>
                                                    </lido:eventPlace>
                                                </xsl:if>

                                            </lido:event>
                                        </lido:eventSet>
                                    </xsl:for-each>
                                </xsl:if>

                                <!-- EXHIBITION LOAN OUT-->

                                <xsl:if test="./Loan_out">
                                    <xsl:for-each select="./Loan_out">
                                        <lido:eventSet>
                                            <lido:event>

                                                <!-- LOCAL ID FOR LOANS-->

                                                <lido:eventID lido:type="local loan ID">
                                                    <xsl:value-of select="./loan.out.number"/>
                                                </lido:eventID>
                                                <lido:eventID lido:type="local loan ID" lido:label="Adlib database number">
                                                    <xsl:value-of select="./loan.out.lref"/>
                                                </lido:eventID>

                                                <!-- LOAN OUT: EXHIBITION -->

                                                <xsl:if test="./loan.out.exhibition">
                                                    <lido:eventName>
                                                        <lido:appellationValue>
                                                            <xsl:value-of select="./loan.out.exhibition"/>
                                                        </lido:appellationValue>
                                                    </lido:eventName>
                                                </xsl:if>

                                                <!-- LOAN OUT: REQUESTER -->

                                                <xsl:if test="./loan.out.requester">
                                                    <lido:eventActor>
                                                        <lido:actorInRole>
                                                            <lido:actor>
                                                                <lido:nameActorSet>
                                                                    <xsl:value-of select="./loan.out.requester"/>
                                                                </lido:nameActorSet>
                                                            </lido:actor>
                                                        </lido:actorInRole>
                                                    </lido:eventActor>
                                                </xsl:if>

                                                <!-- LOAN OUT: PERIOD -->

                                                <xsl:if test="./loan.out.period.start or ./loan.out.period.end">
                                                    <lido:eventDate>
                                                        <lido:displayDate>
                                                            <xsl:value-of select="./loan.out.period.start"/>;<xsl:value-of
                                                                select="./loan.out.period.end"/>
                                                        </lido:displayDate>
                                                        <lido:date>
                                                            <lido:earliestDate>
                                                                <xsl:value-of select="./loan.out.period.start"/>
                                                            </lido:earliestDate>
                                                            <lido:latestDate>
                                                                <xsl:value-of select="./loan.out.period.end"/>
                                                            </lido:latestDate>
                                                        </lido:date>
                                                    </lido:eventDate>
                                                </xsl:if>
                                            </lido:event>
                                        </lido:eventSet>
                                    </xsl:for-each>
                                </xsl:if>

                            </lido:eventWrap>
                    </lido:descriptiveMetadata>
                </lido:lido>
            </xsl:for-each>
        </lido:lidoWrap>

    </xsl:template>
</xsl:stylesheet>
<!-- todo: digital_reference (museuminzicht)? -->