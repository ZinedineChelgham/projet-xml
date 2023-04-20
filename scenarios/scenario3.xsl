<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
    <xsl:key name="clients-par-annee" match="offre" use="substring(dates/debut, 1, 4)"/>

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="../style/scenario3.css"/>
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                <title>Clientèle</title>
            </head>
            <body>
                <div id="app">
                    <h1>Statistiques de l'agence de voyage</h1>
                    <h2>Client et type de séjour</h2>
                    <div id="pieChartsContainer">
                        <div>
                            <canvas id="clientChart"></canvas>
                        </div>
                        <div>
                            <canvas id="typeOfTravelChart"></canvas>
                        </div>
                    </div>
                    <br/>
                    <h2>Nombre de client par année</h2>
                    <div id="popularity">
                        <canvas id="popularityChart"></canvas>
                    </div>
                </div>

            </body>
            <script>
                let ctx = document.getElementById('clientChart');
                let options = {
                plugins: {
                legend: {
                labels: {
                // This more specific font property overrides the global property
                font: {
                size: 20
                }
                }
                }
                }
                }
                let data = {
                labels: [
                'Famille',
                'Adulte',
                'Enfant'
                ],
                datasets: [{
                label: 'nombre',
                data: [<xsl:value-of select="count(offres/offre/client[@type='famille'])"/>, <xsl:value-of select="count(offres/offre/client[@type='adulte'])"/>, <xsl:value-of select="count(offres/offre/client[@type='enfant'])"/>],
                backgroundColor: [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)',
                'rgb(255, 205, 86)'
                ],
                hoverOffset: 4
                }]
                };
                let config = {
                type: 'doughnut',
                data: data,
                options: options
                };
                new Chart(ctx, config);


                ctx = document.getElementById('typeOfTravelChart');
                options = {
                plugins: {
                legend: {
                labels: {
                // This more specific font property overrides the global property
                font: {
                size: 20
                }
                }
                }
                }
                }
                data = {
                labels: [
                'colonie',
                'scolaire',
                'accueil',
                'classique'
                ],
                datasets: [{
                label: 'nombre',
                data: [<xsl:value-of select="count(offres/offre[@type='colonie'])"/>, <xsl:value-of select="count(offres/offre[@type='scolaire'])"/>, <xsl:value-of select="count(offres/offre[@type='accueil'])"/>, <xsl:value-of select="count(offres/offre[@type='classique'])"/>],
                backgroundColor: [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)',
                'rgb(255, 205, 86)',
                'rgba(75, 192, 192, 0.2)'
                ],
                hoverOffset: 4
                }]
                };
                config = {
                type: 'doughnut',
                data: data,
                options: options
                };
                new Chart(ctx, config);

                ctx = document.getElementById('popularityChart');
                new Chart(ctx, {
                type: 'bar',
                data: {
                labels: [
                <xsl:for-each select="//offre[count(. | key('clients-par-annee', substring(dates/debut, 1, 4))[1]) = 1]">
                    <xsl:sort select="substring(dates/debut, 1, 4)" data-type="number" order="ascending"/>
                    <xsl:variable name="annee" select="substring(dates/debut, 1, 4)"/>
                    <xsl:value-of select="$annee"/>,
                </xsl:for-each>
                ],
                datasets: [{
                label: '# of Votes',
                data: [
                <xsl:for-each select="//offre[count(. | key('clients-par-annee', substring(dates/debut, 1, 4))[1]) = 1]">
                    <xsl:sort select="substring(dates/debut, 1, 4)" data-type="number" order="ascending"/>
                    <xsl:variable name="annee" select="substring(dates/debut, 1, 4)"/>
                    <xsl:value-of select="count(//offre[dates/debut[contains(.,$annee)]])"/>,
                </xsl:for-each>
                ],
                borderWidth: 1
                }]
                },
                options: {
                scales: {
                y: {
                beginAtZero: true
                }
                }
                }
                });
            </script>
        </html>
    </xsl:template>



    <!-- Template pour la correspondance "ARTISTE" qui ne fait rien -->
    <!-- <xsl:template match="ARTISTE"/> -->

</xsl:stylesheet>
