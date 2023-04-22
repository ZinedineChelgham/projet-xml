<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8" media-type="application/json" indent="yes"/>

    <xsl:template match="/">
        <xsl:text>{"utilisateurs":[ &#xa;</xsl:text>
        <xsl:apply-templates select="//offre//client | //offre//enseignant | //offre//accompagnateur"/>
        <xsl:text>]}</xsl:text>
    </xsl:template>

    <xsl:template match="client | enseignant | accompagnateur">
        <xsl:if test="not(preceding::*[concat(nom, '|', prenom, '|', age) = concat(current()/nom, '|', current()/prenom, '|', current()/age)])">
            <xsl:text>{"nom":"</xsl:text>
            <xsl:value-of select="nom"/>
            <xsl:text>","prenom":"</xsl:text>
            <xsl:value-of select="prenom"/>
            <xsl:text>","age":"</xsl:text>
            <xsl:value-of select="age"/>
            <xsl:text>"}</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:text>&#xa;</xsl:text> <!-- Ajouter un saut de ligne après chaque utilisateur -->
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
