# Blue Panda PDF Parser

Parses Blue Panda's PDFs into a CSV.

Built specifically for FBLA NLC's Finalist Lists.

## Steps

1. Download the PDFs from the FBLA NLC Finalist Dropbox

   **2024:** https://www.dropbox.com/scl/fo/mvre3p4f7l45fy4cm2akl/AN46aXaqHXZgVcNNMOQRM-o?rlkey=urne9tvsmnmvuypkddok5oqy7&e=2&st=mrz7779u&dl=0
2. Place the PDF file in this project's root directory
3. Update `FILEPATH` as necessary
4. Run `ruby parse.rb`
5. Look for a file called `finalists.csv` in this directory.

Ensure you have Poppler installed: `brew install poppler`
