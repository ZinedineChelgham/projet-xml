<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="../style/scenario1.css"/>
                <title>Offre séjour Espagne</title>
            </head>
            <body>
                <h2>Toutes les offres de séjour pour l'Espagne</h2>
                <table>
                    <tr>
                        <th><h2>Ville</h2></th>
                        <th><h2>Type de séjour</h2></th>
                        <th><h2>Dates</h2></th>
                    </tr>
                    <xsl:apply-templates select="offres/offre/destination[pays='Espagne']/../.">
                        <xsl:sort select="destination/ville"/>
                        <xsl:sort select="dates/debut"/>
                    </xsl:apply-templates>

                </table>
                <h3>TOTAL: <xsl:value-of select="count(offres/offre/destination[pays='Espagne'])"></xsl:value-of></h3>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="offre">
        <tr>
            <td><xsl:value-of select="destination/ville"/></td>
            <td><xsl:value-of select="@type"/></td>
            <td><xsl:value-of select="dates/debut"/> : <xsl:value-of select="dates/fin"/></td>
        </tr>
    </xsl:template>


    <!-- Template pour la correspondance "ARTISTE" qui ne fait rien -->
    <!-- <xsl:template match="ARTISTE"/> -->

</xsl:stylesheet>
