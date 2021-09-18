#!/bin/bash
cd $dldir
wget https://docs.google.com/document/d/1LHbqJAzPXPo-r1cMtRWxgvDG8uBre_gcq3dGXM1zcRY/export?format=pdf -O resume.pdf
exiftool -Title="Résumé | Raymond Li" -Author="Raymond Li" -Subject="Résumé | Raymond Li" -Creator="Vim on Arch Linux" -Producer="VimPDF by Raymond Li" -Keywords="raymond;raymond li;li;raymondli;raymo;raymo111;resume;resumepdf;pdf;pdfresume;fullstack;full-stack;software;developer;full-stack software developer;code;programming;programmer" "Resume - Raymond Li.pdf"
rm "Resume - Raymond Li.pdf_original"
