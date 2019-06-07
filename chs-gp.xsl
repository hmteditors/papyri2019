<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:cts="http://chs.harvard.edu/xmlns/cts3" xmlns:dc="http://purl.org/dc/elements/1.1" xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="tei-html.xsl"/>
	<!-- Framework for main body of document -->
	<xsl:template match="/">
		
		<html>
			<head>
				<title><xsl:value-of select="//tei:title"/>
					
				</title>
				<link href="cts.css" rel="stylesheet" title="CSS for CTS" type="text/css"/>
				<link href="tei.css" rel="stylesheet" title="CSS for CTS" type="text/css"/>
			</head>
			<body>
				
				<xsl:apply-templates select="//tei:text"/>
						
			</body>
		</html>
	</xsl:template>
	<!-- End Framework for main body document -->
	<!-- Match elements of the CTS reply -->
	<xsl:template match="tei:text">
		
			<xsl:apply-templates/>
		
	</xsl:template>

	
	<!-- Default: replicate unrecognized markup -->
	<xsl:template match="@*|node()" priority="-1">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
