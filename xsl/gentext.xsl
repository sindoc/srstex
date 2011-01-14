<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:srs="http://sina.khakbaz.com/2011/01/srs/ns"
    version="1.0">


  <xsl:param name="lang" select="'en_GB'"/>

  <xsl:template name="gentext">
    <xsl:param name="context" select="local-name(.)"/>
    <xsl:param name="key" select="''"/>
    <xsl:param name="pattern" select="''"/>
    <xsl:param name="custom-i" select="''"/>
    <xsl:param name="unresolved" select="'Unresolved'"/>
    <xsl:choose>
      <xsl:when test="$context = 'reqs'">Requirements</xsl:when>
      <xsl:when test="$context = 'deps'">Dependencies</xsl:when>
      <xsl:when test="$context = 'id' or 
		      $context = 'idn'">Identifier</xsl:when>
      <xsl:when test="$context = 'req'">Requirement</xsl:when>
      <xsl:when test="$context = 'sum'">Summary</xsl:when>
      <xsl:when test="$context = 'ttl'">Title</xsl:when>
      <xsl:when test="$context = 'des'">Description</xsl:when>
      <xsl:when test="$context = 'use'">Usage Scenario</xsl:when>
      <xsl:when test="$context = 'pty'">
	<xsl:variable name="contextual">Priority</xsl:variable>
	<xsl:choose>
	  <xsl:when test="$key = 'low' or
			  $key = 'medium' or
			  $key = 'high'">
	    <xsl:call-template name="capitalize">
	      <xsl:with-param name="str" select="$key"/>
	    </xsl:call-template>
	    <xsl:if test="$pattern = 'Adj@key Noun@context Plural@custom-i'">
	      <xsl:text> </xsl:text>
	      <xsl:value-of select="concat($contextual, ' ', $custom-i)"/>
	    </xsl:if>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$contextual"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:when test="$context = 'sts'">
	<xsl:variable name="print" select="'Development Status'"/>
	<xsl:choose>
	  <xsl:when test="$key = 'raised'   or
			  $key = 'accepted' or
			  $key = 'started'  or
			  $key = 'reraised' or
			  $key = 'closed'">
	    <xsl:variable name="print-key">
	      <xsl:call-template name="capitalize">
		<xsl:with-param name="str" select="$key"/>
	      </xsl:call-template>
	    </xsl:variable>
	    <xsl:choose>
	      <xsl:when test="$pattern = 'Adj@general Plural@custom-i'">
		<xsl:variable name="general">
		  <xsl:choose>
		    <xsl:when test="$key = 'closed'">Resolved</xsl:when>
		    <xsl:otherwise>Open</xsl:otherwise>
		  </xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$general"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$custom-i"/>
	      </xsl:when>
	      <xsl:when test="$pattern = 'Adj@key Plural@custom-i'">
		<xsl:value-of select="$print-key"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$custom-i"/>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="$print-key"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:when>
	  <xsl:when test="$pattern = '@print'">
	    <xsl:value-of select="$print"/>
	  </xsl:when>
	  <xsl:when test="$pattern = 'substring-after(@print, @custom-i)'">
	    <xsl:value-of select="substring-after($print, $custom-i)"/>
	  </xsl:when>
	  <xsl:otherwise>DevelopmentStatus</xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:when test="$context = 'res'">
	<xsl:variable name="print" select="'Resolution Status'"/>
	<xsl:choose>
	  <xsl:when test="$key = 'implemented' or
			  $key = 'tested'      or
			  $key = 'dropped'">
	    <xsl:variable name="print-key">
	      <xsl:call-template name="capitalize">
		<xsl:with-param name="str" select="$key"/>
	      </xsl:call-template>
	    </xsl:variable>
	    <xsl:choose>
	      <xsl:when test="$pattern = 'Adj@general Plural@custom-i'">
		<xsl:text>Resolved </xsl:text>
		<xsl:value-of select="$custom-i"/>
	      </xsl:when>
	      <xsl:when test="$pattern = 'Adj@key Plural@custom-i'">
		<xsl:value-of select="$print-key"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$custom-i"/>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="$print-key"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:when>
	  <xsl:when test="$pattern = 'print'">
	    <xsl:value-of select="$print"/>
	  </xsl:when>
	  <xsl:when test="$pattern = 'substring-after(@print, @custom-i)'">
	    <xsl:value-of select="substring-after($print, $custom-i)"/>
	  </xsl:when>
	  <xsl:otherwise>ResolutionStatus</xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:when test="$context = 'dep'">
	<xsl:choose>
	  <xsl:when test="$pattern = 'Verb'">Depends on</xsl:when>
	  <xsl:otherwise>Dependency</xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$unresolved"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="capitalize">
    <xsl:param name="str"/>
    <xsl:value-of select="concat(translate(substring($str, 1, 1), 
			  'abcdefghijklmnopqrstuvwxyz',
			  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), 
			  substring($str, 2))"/>
  </xsl:template>

</xsl:stylesheet>