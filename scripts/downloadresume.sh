#!/bin/bash
# shellcheck disable=SC2154
cd "$dldir" || exit
wget https://docs.google.com/document/d/1LHbqJAzPXPo-r1cMtRWxgvDG8uBre_gcq3dGXM1zcRY/export?format=pdf -O "Raymond_Li_Resume.pdf"
exiftool -Title="Résumé | Raymond Li" -Author="Raymond Li" -Subject="Résumé | Raymond Li" -Creator="Raymond Li on Arch Linux" -Producer="Raymond Li on Arch Linux" "Raymond_Li_Resume.pdf"
rm "Raymond_Li_Resume.pdf_original"
