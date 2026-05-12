<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
              doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Weather Forecast - <xsl:value-of select="weatherForecast/location"/></title>
        <style>
          body {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 13px;
            background-color: #f5f5f5;
            margin: 20px 40px;
            color: #222;
          }

          h2 {
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 12px;
            text-decoration: underline;
          }

          table.forecast-table {
            border-collapse: collapse;
            margin: 0 auto;
            background-color: #fff;
          }

          table.forecast-table th,
          table.forecast-table td {
            border: 1px solid #888;
            text-align: center;
            vertical-align: middle;
            padding: 6px 10px;
            min-width: 90px;
          }

          table.forecast-table thead tr th {
            background-color: Yellow;
            font-weight: bold;
          }

          table.forecast-table tbody tr td:first-child {
            background-color: Yellow;
            
          }

          .cell-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 4px;
          }

          .temp-range {
            font-size: 12px;
            font-weight: bold;
          }

          .weather-img {
            width: 60px;
            height: 60px;
            object-fit: contain;
          }

          .description {
            font-size: 11px;
          }

          .cloudy       { color: blue;   }
          .thunderstorm { color: orange; }
          .rain         { color: Lime;   }
          .sunny        { color: red;    }
          .partlysunny  { color: red;    }
        </style>
      </head>
      <body>

        <h2>
          <xsl:value-of select="weatherForecast/location"/>
          <xsl:text> [</xsl:text>
          <xsl:value-of select="weatherForecast/lastUpdated/date"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="weatherForecast/lastUpdated/month"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="weatherForecast/lastUpdated/year"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="weatherForecast/lastUpdated/time"/>
          <xsl:text>]</xsl:text>
        </h2>

        <table class="forecast-table">
          <thead>
            <tr>
              <th>Date</th>
              <th>Mon</th>
              <th>Tue</th>
              <th>Wed</th>
              <th>Thu</th>
              <th>Fri</th>
              <th>Sat</th>
              <th>Sun</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="weatherForecast/forecasts/forecast">
              <xsl:sort select="forecastDate/year"  data-type="number" order="descending"/>
              <xsl:sort select="forecastDate/month" data-type="number" order="descending"/>
              <xsl:sort select="forecastDate/date"  data-type="number" order="descending"/>
              <xsl:call-template name="forecastRow"/>
            </xsl:for-each>
          </tbody>
        </table>

      </body>
    </html>
  </xsl:template>

  <xsl:template name="forecastRow">
    <tr>
      <td><xsl:value-of select="forecastDate/displayDate"/></td>

      <td>
        <xsl:if test="forecastDate/dayOfWeek = 'Mon'">
          <xsl:call-template name="weatherCell"/>
        </xsl:if>
      </td>

      <td>
        <xsl:if test="forecastDate/dayOfWeek = 'Tues'">
          <xsl:call-template name="weatherCell"/>
        </xsl:if>
      </td>

      <td>
        <xsl:if test="forecastDate/dayOfWeek = 'Wed'">
          <xsl:call-template name="weatherCell"/>
        </xsl:if>
      </td>

      <td>
        <xsl:if test="forecastDate/dayOfWeek = 'Thur'">
          <xsl:call-template name="weatherCell"/>
        </xsl:if>
      </td>

      <td>
        <xsl:if test="forecastDate/dayOfWeek = 'Fri'">
          <xsl:call-template name="weatherCell"/>
        </xsl:if>
      </td>

      <td>
        <xsl:if test="forecastDate/dayOfWeek = 'Sat'">
          <xsl:call-template name="weatherCell"/>
        </xsl:if>
      </td>

      <td>
        <xsl:if test="forecastDate/dayOfWeek = 'Sun'">
          <xsl:call-template name="weatherCell"/>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <xsl:template name="weatherCell">
    <xsl:variable name="code" select="overallCode"/>

    <div class="cell-content">

      <span class="temp-range">
        <xsl:value-of select="temperature/high"/>
        <xsl:text>&#176; - </xsl:text>
        <xsl:value-of select="temperature/low"/>
        <xsl:text>&#176;</xsl:text>
      </span>

      <xsl:choose>
        <xsl:when test="$code = 'cloudy'">
          <img class="weather-img" src="cloudy.jpeg" alt="Cloudy"/>
        </xsl:when>
        <xsl:when test="$code = 'thunderstorm'">
          <img class="weather-img" src="thunderstorm.jpeg" alt="Thunderstorm"/>
        </xsl:when>
        <xsl:when test="$code = 'rain'">
          <img class="weather-img" src="rain.jpeg" alt="Rain"/>
        </xsl:when>
        <xsl:when test="$code = 'sunny'">
          <img class="weather-img" src="sunny.jpeg" alt="Sunny"/>
        </xsl:when>
        <xsl:when test="$code = 'partlysunny'">
          <img class="weather-img" src="partlySunny.jpeg" alt="Partly Sunny"/>
        </xsl:when>
      </xsl:choose>

      <span>
        <xsl:attribute name="class">
          <xsl:text>description </xsl:text>
          <xsl:value-of select="$code"/>
        </xsl:attribute>
        <xsl:value-of select="description"/>
      </span>

    </div>
  </xsl:template>

</xsl:stylesheet>
