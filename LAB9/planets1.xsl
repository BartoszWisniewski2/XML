<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<html> 
<body>
  <table border="0">
    <xsl:for-each select="SOLAR_SYSTEM/PLANETS/PLANET">
<xsl:variable name="out" select="@COLOR" />
    <tr style="color:{$out}">
      <td><xsl:value-of select="NAME"/></td>
    </tr>
    </xsl:for-each>
  </table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
