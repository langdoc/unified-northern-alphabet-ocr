This is an attempt to build an OCR system for the languages written in Unified Northern Alphabet. Ideally there would be samples from all languages with which it is used. Only Public Domain data is used. The pages originate from Fenno-Ugrica collection, citations will be added soon.

## Commands used

Individual pages were extracted with command:

   convert -density 300 -trim file.pdf[8] -quality 100 raw/file.png
   ...
   ocropus-nlbin raw/*.png -o train
   ocropus-gpageseg 'train/*.bin.png'
   ocropus-gtedit html train/*/*.png -o temp-correction.html

You can edit the lines by modifying `temp-correction.html` file in Firefox and saving the file. Chrome will not save the edited lines! If you use some esoteric browser, please try first! The lines can be written back to correct place with:

    ocropus-gtedit extract temp-correction.html 

If the line is not properly recognized, then leave it empty. Those will be fixed later.