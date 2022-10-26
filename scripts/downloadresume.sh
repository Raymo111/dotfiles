#!/bin/bash
# shellcheck disable=SC2154
cd "$dldir" || exit
wget https://docs.google.com/document/d/1LHbqJAzPXPo-r1cMtRWxgvDG8uBre_gcq3dGXM1zcRY/export?format=pdf -O "Raymond Li - Resume.pdf"
exiftool -Title="Résumé | Raymond Li" -Author="Raymond Li" -Subject="Résumé | Raymond Li" -Creator="Vim on Arch Linux" -Producer="VimPDF by Raymond Li" -Keywords="raymond;raymond li;li;raymondli;raymo;raymo111;resume;resumepdf;pdf;pdfresume;fullstack;full-stack;software;developer;full-stack software developer;code;programming;programmer" "Raymond Li - Resume.pdf"
rm "Raymond Li - Resume.pdf_original"
