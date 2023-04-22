<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8" media-type="application/json" indent="yes"/>

    <xsl:template match="/">
        <xsl:text>{"utilisateurs":[ &#xa;</xsl:text>
        <xsl:apply-templates select="//offre//client | //offre//enseignant | //offre//accompagnateur"/>
        <xsl:text>]}</xsl:text>
    </xsl:template>

    <xsl:template match="client | enseignant | accompagnateur">
        <xsl:if test="not(preceding::*[concat(nom, '|', prenom, '|', age) = concat(current()/nom, '|', current()/prenom, '|', current()/age)])"> <!-- would have been better to check with an id but we didn't use id in our model so we keep like that -->
            <xsl:text>{"nom":"</xsl:text>
            <xsl:value-of select="translate(nom, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/> <!-- upper-case method not supported -->
            <xsl:text>","prenom":"</xsl:text>
            <xsl:value-of select="prenom"/>
            <xsl:text>","age":"</xsl:text>
            <xsl:value-of select="age"/>
            <xsl:text>","genre":"</xsl:text>
            <xsl:choose>
                <xsl:when test="genre = 'homme'">H</xsl:when>
                <xsl:when test="genre = 'femme'">F</xsl:when>
                <xsl:when test="genre = 'non_specifie'">-</xsl:when>
            </xsl:choose>
            <xsl:text>"}</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:text>&#xa;</xsl:text> <!-- Ajouter un saut de ligne après chaque utilisateur -->
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
