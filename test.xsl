<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" indent="yes"/>

    <xsl:key name="clients-par-annee" match="offre" use="substring(dates/debut, 1, 4)"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Rapport annuel</title>
            </head>
            <body>
                <h1>Rapport annuel</h1>
                <table border="1">
                    <tr>
                        <th>Année</th>
                        <th>Nombre de clients</th>
                    </tr>
                    <xsl:for-each select="//offre[count(. | key('clients-par-annee', substring(dates/debut, 1, 4))[1]) = 1]">
                        <xsl:variable name="annee" select="substring(dates/debut, 1, 4)"/>
                        <tr>
                            <td><xsl:value-of select="$annee"/></td>
                            <td>
                                <xsl:value-of select="count(//offre[dates/debut[contains(.,$annee)]])"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
