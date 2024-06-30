class PdfToText
  def initialize(pdf_path)
    @pdf_path = pdf_path
  end

  def text
    # ``-raw`` option "undoes" column formatting
    # The `-` tells pdftotext to output to stdout
    `pdftotext -raw \"#{@pdf_path}\" -`
  end
end
