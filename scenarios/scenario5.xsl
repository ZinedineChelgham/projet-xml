<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8"/>

    <!-- Template générique pour les éléments imbriqués -->
    <xsl:template match="*">
        <!-- Ajouter le nom de l'élément comme clé dans le JSON -->
        <xsl:text>"</xsl:text>
        <xsl:value-of select="name()" />
        <xsl:text>": {</xsl:text>

        <!-- Appliquer les templates aux éléments enfants de l'élément courant -->
        <xsl:apply-templates />

        <!-- Fermer l'objet JSON pour l'élément courant -->
        <xsl:text>}</xsl:text>

        <!-- Ajouter une virgule si ce n'est pas le dernier élément -->
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <!-- Template générique pour les éléments imbriqués de type "objet" -->
    <xsl:template match="*[*]">
        <!-- Ajouter le nom de l'élément comme clé dans le JSON -->
        <xsl:text>"</xsl:text>
        <xsl:value-of select="name()" />
        <xsl:text>": "</xsl:text>

        <!-- Appliquer récursivement le template aux éléments enfants de l'élément courant -->
        <xsl:apply-templates />

        <!-- Fermer l'objet JSON pour l'élément courant -->
        <xsl:text>"</xsl:text>

        <!-- Ajouter une virgule si ce n'est pas le dernier élément -->
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <!-- Template pour les éléments de type texte -->
    <xsl:template match="text()">
        <!-- Encadrer la valeur avec des guillemets -->
        <xsl:text>"</xsl:text>
        <xsl:value-of select="normalize-space()" />
        <xsl:text>"</xsl:text>
    </xsl:template>



</xsl:stylesheet>
