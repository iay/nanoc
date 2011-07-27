# encoding: utf-8

class Nanoc::Filters::XSLTest < MiniTest::Unit::TestCase

  include Nanoc::TestHelpers

  def test_filter
    if_have 'nokogiri' do
      require 'tempfile'
      # Create a simple XSL file
      xsl_file = Tempfile.new('simple_xsl')
      xsl_file.puts <<-EOS
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>

  <xsl:template match="/ | node() | @* | comment() | processing-instruction()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
EOS
      
      xml_content = <<-EOS
<?xml version="1.0" encoding="utf-8"?>
<test foo="bar">
  <shouldbe>identical</shouldbe>
</test>
EOS
      xsl_file.open
      # Create filter
      filter = ::Nanoc::Filters::XSL.new

      # Run filter
      result = filter.run(xml_content, { :template => xsl_file.path })
      assert_equal(xml_content, result)
    end
  end

  def test_filter
    if_have 'nokogiri' do
      require 'tempfile'
      # Create a simple XSL file
      xsl_file = Tempfile.new('simple_xsl')
      xsl_file.puts <<-EOS
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>

  <xsl:template match="/ | node() | @* | comment() | processing-instruction()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
EOS
      
      xml_content = <<-EOS
<?xml version="1.0" encoding="utf-8"?>
<test foo="bar">
  <shouldbe>identical</shouldbe>
</test>
EOS
      xsl_file.open
      # Create filter
      filter = ::Nanoc::Filters::XSL.new

      # Run filter
      result = filter.run(xml_content, { :template => xsl_file.path })
      assert_equal(xml_content, result)
      xsl_file.open
    end
  end

end