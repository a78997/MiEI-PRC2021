<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="xhtml" indent="yes" encoding="UTF-8"/>
        <xsl:template match="/">
        <html>
            <head>
                <title>Processamento e Representação de Conhecimento</title>
                <meta charset="UTF-8"/>
            </head>
            <body>
                <h1 style="text-align:center">Trabalho Prático nº 1</h1>
                <hr/>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="meta">
        <table width="100%">
            <tr>
                <td width="50%">
                    <p><b>Key Name: </b><i><xsl:value-of select="keyname"/></i></p>
                    <p><b>Title: </b><i><xsl:value-of select="title"/></i></p>
                    <p><b>Subtitle: </b><i><xsl:value-of select="subtitle"/></i></p>
                </td>
                <td>
                    <p><b>Begin Date: </b><xsl:value-of select="bdate"/></p>
                    <p><b>End Date: </b><xsl:value-of select="edate"/></p>
                    <p><b>Supervisor: </b><i><a href="{supervisor/homepage}"><xsl:value-of select="supervisor/name"/></a></i></p>
                </td>
            </tr>
        </table>
        <hr/>
    </xsl:template>
    
    <xsl:template match="workteam">
        <hr/>
        <h2>WorkTeam:</h2>
        <ol>
            <xsl:apply-templates/>
        </ol>
        <hr/>
    </xsl:template>
    
    <xsl:template match="member">
        <li>
            <p>
            <xsl:value-of select="identifier"/> - <b><xsl:value-of select="name"/></b> - 
            <i><a href="{email}"><xsl:value-of select="email"/></a></i>
            </p>
            <p> <img src="{photo/@path}" alt="Photo" width="10%" align="middle"/></p>
        </li>
    </xsl:template>
    
    <xsl:template match="abstract">
        <hr/>
        <h3>Abstract:</h3>
        <xsl:apply-templates/>
        <hr/>
    </xsl:template>
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="b">
        <b>
            <xsl:value-of select="."/>
        </b>
    </xsl:template>
    
    <xsl:template match="i">
        <i>
            <xsl:value-of select="."/>
        </i>
    </xsl:template>
    
    <xsl:template match="deliverables">
        <hr/>
        <h3>Deliverables:</h3>
        <ul>
            <xsl:apply-templates/>
        </ul>
        <hr/>
    </xsl:template>
    
    <xsl:template match="deliverable">
        <li>
            <a href="{@path}"><xsl:value-of select="."/></a>
        </li>
    </xsl:template>
    
</xsl:stylesheet>
