<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="../style/scenario2.css"/>
                <title>Frise chronologique</title>
            </head>
            <body>
                <h2>Frise chronologique de tout les séjours qui ont été proposés</h2>

                <div id="app">
                    <div id="frise-container">
                        <xsl:apply-templates select="offres/offre">
                            <xsl:sort select="dates/debut"/>
                            <xsl:sort select="destination/pays"/>
                            <xsl:sort select="destination/ville"/>
                        </xsl:apply-templates>
                    </div>
                    <div class="arrow"></div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="offre">
        <div class="item">
            <div class="flex-center">
                <span><b><xsl:value-of select="destination/ville"/> </b></span>
                <span><xsl:value-of select="@type"/></span>
            </div>
            <div class="flex-center">
                <xsl:value-of select="dates/debut"/>
                <div class="tick"></div>
            </div>
        </div>
    </xsl:template>



</xsl:stylesheet>
