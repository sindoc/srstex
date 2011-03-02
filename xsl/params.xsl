<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

  <xsl:param name="req.idn.input.prefix">r</xsl:param>
  <xsl:param name="req.idn.output.prefix"></xsl:param>
  <xsl:param name="req.fields.size" select="'footnotesize'"/>

  <xsl:param name="gentext.lang" select="'en_GB'"/>
  <xsl:param name="gentext.unresolved">Unresolved</xsl:param>
  <xsl:param name="newline" select="'&#10;'"/>

  <xsl:param name="tex.nbsp" select="'~'"/>
  <xsl:param name="tex.index.key.sep" select="'!'"/>
  <xsl:param name="tex.index.val.sep" select="'@'"/>

</xsl:stylesheet>
