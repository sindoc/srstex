<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:srs="http://sina.khakbaz.com/2011/01/srs/ns"
		version="1.0">

  <xsl:template name="index-by-status">

    <xsl:variable name="reqs-text">
      <xsl:call-template name="gentext">
	<xsl:with-param name="context" select="'reqs'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:call-template name="tex-index">
      <xsl:with-param name="entry">
	<xsl:call-template name="tex-textbf">
	  <xsl:with-param name="content">
	    <xsl:call-template name="gentext">
	      <xsl:with-param name="key" select="."/>
	      <xsl:with-param name="custom-i" select="$reqs-text"/>
	      <xsl:with-param 
		  name="pattern" select="'Adj@general Plural@custom-i'"/>
	    </xsl:call-template>	    
	  </xsl:with-param>
	</xsl:call-template>
	<xsl:value-of select="$tex-index-key-sep"/>
	<xsl:call-template name="tex-textit">
	  <xsl:with-param name="content">
	    <xsl:call-template name="gentext">
	      <xsl:with-param name="key" select="."/>
	    </xsl:call-template>
	  </xsl:with-param>
	</xsl:call-template>
	<xsl:value-of select="$tex-index-key-sep"/>
	<xsl:call-template name="cons-ttl-var"/>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <xsl:template match="@sts" mode="tex-index">
    <xsl:call-template name="index-by-status"/>
  </xsl:template>

  <xsl:template match="@res" mode="tex-index">
    <xsl:call-template name="index-by-status"/>
  </xsl:template>

  <xsl:template match="srs:sum" mode="tex-index">

    <xsl:variable name="key">
      <xsl:call-template name="cons-ttl-var"/>
    </xsl:variable>
    
    <xsl:variable name="entry">
      <xsl:value-of select="$key"/>
      <xsl:value-of select="$tex-index-val-sep"/>
      <xsl:call-template name="tex-textbf">
	<xsl:with-param name="content" select="$key"/>
      </xsl:call-template>
      <xsl:value-of select="$tex-index-key-sep"/>
      <xsl:call-template name="cons-sum-var"/>
    </xsl:variable>
    
    <xsl:call-template name="tex-index">
      <xsl:with-param name="entry" select="$entry"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@pty" mode="tex-index">

    <xsl:variable name="reqs-text">
      <xsl:call-template name="gentext">
	<xsl:with-param name="context" select="'reqs'"/>
      </xsl:call-template>      
    </xsl:variable>

    <xsl:variable name="key">
      <xsl:call-template name="gentext">
	<xsl:with-param name="key" select="."/>
	<xsl:with-param name="custom-i" select="$reqs-text"/>
	<xsl:with-param name="pattern" 
			select="'Adj@key Noun@context Plural@custom-i'"/>
      </xsl:call-template>
      <xsl:value-of select="$tex-nbsp"/>
    </xsl:variable>

    <xsl:variable name="entry">
      <xsl:value-of select="$key"/>
      <xsl:value-of select="$tex-index-val-sep"/>
      <xsl:call-template name="tex-textbf">
	<xsl:with-param name="content" select="$key"/>
      </xsl:call-template>
      <xsl:value-of select="$tex-index-key-sep"/>
      <xsl:call-template name="cons-ttl-var"/>
    </xsl:variable>
    
    <xsl:call-template name="tex-index">
      <xsl:with-param name="entry" select="$entry"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template match="srs:*|@*" mode="tex-index">
    <!-- Do nothing -->
  </xsl:template>

  <xsl:template match="srs:req" mode="tex-index">
    <xsl:apply-templates select="@*|srs:*" mode="tex-index"/>
  </xsl:template>

  <xsl:template match="srs:dep" mode="tex-index">

    <xsl:variable name="dst-idn">
      <xsl:call-template name="decode-idn">
	<xsl:with-param name="str" select="@ref"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="src-idn">
      <xsl:call-template name="req-idn">
	<xsl:with-param name="node" select="../../@xml:id"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="key">
      <xsl:call-template name="cons-ttl-var">
	<xsl:with-param name="idn" select="$src-idn"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="verb">
      <xsl:call-template name="gentext">
	<xsl:with-param name="pattern" select="'Verb'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="entry">
      <xsl:value-of select="$key"/>
      <xsl:value-of select="$tex-index-val-sep"/>
      <xsl:call-template name="tex-textbf">
	<xsl:with-param name="content" select="$key"/>
      </xsl:call-template>
      <xsl:value-of select="$tex-index-key-sep"/>
      <xsl:call-template name="tex-textit">
	<xsl:with-param name="content" select="$verb"/>
      </xsl:call-template>
      <xsl:value-of select="$tex-index-key-sep"/>
      <xsl:call-template name="cons-ttl-var">
	<xsl:with-param name="idn" select="$dst-idn"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:call-template name="tex-index">
      <xsl:with-param name="entry" select="$entry"/>
    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>