<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" />
  
  <xsl:template match="/">
    <SOLAR_SYSTEM>
      <PLANETS>
	<xsl:apply-templates />
      </PLANETS>
    </SOLAR_SYSTEM>
  </xsl:template>

  <xsl:template match="SOLAR_SYSTEM/PLANETS">
    <xsl:for-each select="PLANET">
      <xsl:sort select="RADIUS" />
      <xsl:variable name="gestosc" select="DENSITY" />
      <xsl:if test="$gestosc &lt;3">
	<xsl:copy-of select="." />
      </xsl:if> 
    </xsl:for-each>
    
  </xsl:template>
  
</xsl:stylesheet>
