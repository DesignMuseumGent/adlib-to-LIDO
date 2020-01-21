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
                                    <!--for each object category their needs to be one classification node -->
                                    <xsl:for-each select="./object_category">
                                        <lido:classification>
                                            <!--voor lido:conceptID moet de waarde van objectcategorie.lref gemapped worden -->
                                            <lido:term><xsl:value-of select="./object_category/value"/></lido:term>
                                        </lido:classification>
                                    </xsl:for-each>

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
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
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
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!-- ACQUISITION PLACE -->
                                            <xsl:if test="acquisition.place">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local"
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>

                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>



                            </lido:eventWrap>

                    </lido:descriptiveMetadata>
                </lido:lido>
            </xsl:for-each>
        </lido:lidoWrap>

    </xsl:template>
</xsl:stylesheet>