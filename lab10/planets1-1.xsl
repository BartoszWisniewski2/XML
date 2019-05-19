<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:template match="/">
    <html>
      <body>
	<h2>Planety</h2>
	<xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="SOLAR_SYSTEM/PLANETS/PLANET">
    <!-- <xsl:variable name="kolor" select="@COLOR" /> -->
    <xsl:variable name="kolor">
      <xsl:value-of select="@COLOR" />
    </xsl:variable>
    
    <p style="color:{$kolor}">
      <xsl:value-of select="NAME" />
    </p>
  </xsl:template>
  
</xsl:stylesheet>
