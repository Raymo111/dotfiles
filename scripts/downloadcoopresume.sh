#!/bin/bash
cd /mnt/c/Users/raymo/Downloads
wget https://docs.google.com/document/d/1jG-5wMcLVPBajKWkIaCG0xwybEVmODwKNKRxIJBXGas/export?format=pdf -O "Resume - Raymond Li.pdf"
exiftool -Title="Résumé - Raymond Li" -Author="Raymond Li" -Subject="Résumé - Raymond Li" -Creator="Nano on Arch Linux" -Producer="NanoPDF by Raymond Li" -Keywords="raymond;raymond li;li;raymondli;raymo;raymo111;resume;resumepdf;pdf;pdfresume;fullstack;full-stack;software;developer;full-stack software developer;code;programming;programmer" "Resume - Raymond Li.pdf"
rm "Resume - Raymond Li.pdf_original"
