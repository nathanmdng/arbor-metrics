<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:java="http://xml.apache.org/xslt/java"
	exclude-result-prefixes="java">
	<xsl:template name="age-in-months">
		<xsl:param name="date-of-birth" />
		<xsl:param name="current-date" />
		<xsl:param name="y1" select="substring($date-of-birth, 7, 4)" />
		<xsl:param name="y2" select="substring($current-date, 7, 4)" />
		<xsl:param name="m1" select="substring($date-of-birth, 1, 2)" />
		<xsl:param name="m2" select="substring($current-date, 1, 2)" />
		<xsl:param name="d1" select="substring($date-of-birth, 4, 2)" />
		<xsl:param name="d2" select="substring($current-date, 4, 2)" />
		<xsl:variable name="ageMonths" select="12 * ($y2 - $y1) + $m2 - $m1 - ($d2 &lt; $d1)" />
		<xsl:value-of select="floor($ageMonths div 12)"/>
	</xsl:template>
	<xsl:template match="/">
		<xsl:for-each select="patients/patient">
		<patient>
			<patientid><xsl:value-of select="id" /></patientid>
			<sex>
				<xsl:variable name="gender" select="gender" />
				<xsl:choose>
					<xsl:when test="$gender = 'm'">
						male
					</xsl:when>
					<xsl:when test="$gender = 'f'">
						female
					</xsl:when>
					<xsl:otherwise>
						other
					</xsl:otherwise>
				</xsl:choose>
			</sex>
			<name><xsl:value-of select="name" /></name>
			<state>
				<xsl:variable name="state" select="state" />
				<xsl:choose>
					<xsl:when test="$state = 'Michigan'">
						MI
					</xsl:when>
					<xsl:when test="$state = 'Ohio'">
						OH
					</xsl:when>
					<xsl:otherwise>
						other
					</xsl:otherwise>
				</xsl:choose>
			</state>
			<age>
				<xsl:variable name="currentDate"
					select="java:format(java:java.text.SimpleDateFormat.new('dd/MM/yyyy'), java:java.util.Date.new())" />
				<xsl:call-template name="age-in-months">
					<xsl:with-param name="date-of-birth" select="dob" />
					<xsl:with-param name="current-date" select="$currentDate" />
				</xsl:call-template>
			</age>
		</patient>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
