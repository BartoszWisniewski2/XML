<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" />

  <xsl:template match="/">
    <SOLAR_SYSTEM>
      <PLANETS>
        <xsl:apply-templates/>
      </PLANETS>
    </SOLAR_SYSTEM>
  </xsl:template>

  <xsl:template match="SOLAR_SYSTEM/PLANETS/PLANET">
    <planet>
      <xsl:apply-templates />
    </planet>
  </xsl:template>

  <xsl:template match="NAME">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template match="DISTANCE">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template match="RADIUS">
    <xsl:copy-of select="." />
    <SURFACE UNITS="km^2">
      <xsl:variable name="pole" select="3.14 *4 *.*." />
     
      <xsl:value-of select="$pole" />
    </SURFACE>
  </xsl:template>

  <xsl:template match="LENGTH_OF_YEAR">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template match="DAY">
    <xsl:variable name="jednostka" select="@UNITS" />
    <xsl:choose>
      <xsl:when test="contains($jednostka, 'days')">   
        <xsl:variable name="godz">
          <xsl:value-of select=". *24" />
        
        </xsl:variable>
        <DAY UNITS="hours">
          <xsl:value-of select="$godz" />
        </DAY>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="." />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="MASS">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template match="DENSITY">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template match="SATELLITES">
    <SATELLITE>
      <xsl:value-of select="count(SATELLITE)" />
    </SATELLITE>
  </xsl:template>

</xsl:stylesheet>
