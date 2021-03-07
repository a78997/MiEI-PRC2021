<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">    
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="obra">
        ###  http://www.di.uminho.pt/prc2021/arquivo-musical#<xsl:value-of select="@id"/>
        :<xsl:value-of select="@id"/> rdf:type owl:NamedIndividual ,
        :Obra ;
        :éCompostaPor :<xsl:value-of select="translate(compositor, ' ','_')"/> ;
        :temTipo "<xsl:value-of select="tipo"/>" ;
        :temTítulo "<xsl:value-of select="titulo"/>" .
        
        <xsl:if test="compositor!=''">
            ###  http://www.di.uminho.pt/prc2021/arquivo-musical#<xsl:value-of select="translate(compositor, ' ','_')"/>
        :<xsl:value-of select="translate(compositor, ' ','_')"/> rdf:type owl:NamedIndividual ,
        :Compositor ;
        :compôs :<xsl:value-of select="@id"/> .
        </xsl:if>
        
        <xsl:for-each select="instrumentos/instrumento">
            ###  http://www.di.uminho.pt/prc2021/arquivo-musical#<xsl:value-of select="partitura/@path"/>
            :<xsl:value-of select="partitura/@path"/> rdf:type owl:NamedIndividual ,
            :Instrumento ;
            :temPartitura :partitura_<xsl:value-of select="partitura/@path"/> ;
            :éTocadoEm :<xsl:value-of select="../../@id"/> ;
            :temDesignação "<xsl:value-of select="designacao"/>" .
            
            <xsl:for-each select="partitura">
                ###  http://www.di.uminho.pt/prc2021/arquivo-musical#partitura_<xsl:value-of select="@path"/>
                :partitura_<xsl:value-of select="@path"/> rdf:type owl:NamedIndividual ,
                :Partitura ;
                <xsl:if test="@afinacao!=''">
                    :temAfinação "<xsl:value-of select="@afinacao"/>" ;
                </xsl:if>
                <xsl:if test="@clave!=''">
                    :temClave "<xsl:value-of select="@clave"/>" ;
                </xsl:if>
                :temPath "<xsl:value-of select="@path"/>" ;
                <xsl:if test="@voz!=''">
                    :temVoz "<xsl:value-of select="@voz"/>" ;
                </xsl:if>
                :éDoTipo "<xsl:value-of select="@type"/>" .
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>