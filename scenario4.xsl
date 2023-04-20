<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:key name="offreByPays" match="offre" use="concat(destination/pays, '|', destination/ville)"/>

    <xsl:template match="/">
        <resultats>
            <!-- Pour chaque offre de type famille, triée par nombre de familles d'accueil décroissant -->
            <xsl:for-each select="//offre">
                <xsl:sort select="count(immersion_famille_accueil/famille_accueil)" data-type="number" order="descending"/>
                <xsl:variable name="pays" select="destination/pays"/>
                <xsl:variable name="ville" select="destination/ville"/>
                <!-- Afficher le pays et la ville uniquement si c'est la première occurrence -->
                <xsl:if test="generate-id() = generate-id(key('offreByPays', concat($pays, '|', $ville))[1])">
                    <xsl:if test="not(preceding::offre[destination/pays = $pays])">
                        <pays name="{$pays}">
                            <!-- Nombre de familles d'accueil pour le pays -->
                            <nb_familles_accueil>
                                <xsl:value-of select="count(key('offreByPays', concat($pays, '|', $ville))/immersion_famille_accueil/famille_accueil)"/>
                            </nb_familles_accueil>
                            <!-- Afficher la ville uniquement si elle a des familles d'accueil -->
                            <xsl:if test="count(key('offreByPays', concat($pays, '|', $ville))/immersion_famille_accueil/famille_accueil) > 0">
                                <villes>
                                    <ville name="{$ville}">
                                        <!-- Nombre de familles d'accueil pour la ville -->
                                        <nb_familles_accueil>
                                            <xsl:value-of select="count(immersion_famille_accueil/famille_accueil)"/>
                                        </nb_familles_accueil>
                                    </ville>
                                </villes>
                            </xsl:if>
                        </pays>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
            <!-- Afficher les pays sans familles d'accueil -->
            <xsl:for-each select="//destination/pays[not(../offre/destination/pays = current())]">
                <xsl:if test="not(preceding::pays[@name = current()/@name]) and normalize-space(@name) != ''">
                    <pays name="{@name}">
                        <nb_familles_accueil>0</nb_familles_accueil>
                        <villes>
                            <ville name="Aucune">
                                <nb_familles_accueil>0</nb_familles_accueil>
                            </ville>
                        </villes>
                    </pays>
                </xsl:if>
            </xsl:for-each>
        </resultats>
    </xsl:template>

</xsl:stylesheet>
