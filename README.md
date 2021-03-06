[![DOI](https://zenodo.org/badge/154043563.svg)](https://zenodo.org/badge/latestdoi/154043563)

## Unified Northern Alphabet OCR Ground Truth

This dataset contains proofread OCR Ground Truth materials for Unified Northern Alphabet on different languages. Ideally there would be samples from all languages with which this writing system has been used. Only Public Domain data is used. The pages originate from the [Fenno-Ugrica collection](http://fennougrica.kansalliskirjasto.fi/). The books and their URN's are specified below:

|Author|Book | Language| URN |
|-------|-------|--------|--------|
|Ƶuļov, P. N.|Kniga logkɘm guejka: vɘsmus pieļ vɘsmus egest opnuvmus|Kildin Saami|http://urn.fi/URN:NBN:fi-fe2016051212324|
|Ƶuļov, P. N.|Lovintan maɧьs lovintanut: oul lomt :oul hanis̷ tan tal maɧьs|Northern Mansi|http://urn.fi/URN:NBN:fi-fe2014060426213|
|Ƶuļov, P. N.|Tolaŋgowa jeɧemņa tolaŋgobçɧ: ņurtej peļa: ņurtej toholambawa po jeɧemņa padawь|Tundra Nenets|http://urn.fi/URN:NBN:fi-fe2014061629286|
|Ƶuļov, P. N.|Togьltьptæt catь: togьltьpsatьļ nəkьrьl laka: posukoļ pelæktь: posukoļ tantaltьkьptæļ pot|Northern Selkup|http://urn.fi/URN:NBN:fi-fe2014061226436|

In the 1930s, the so-called Unified Northern Alphabet (Единый северный алфавит) was used for creating literacy in 16 different languages of the Soviet Union. In this dataset there are sentences from four of them: Kildin Saami (sjd, kild1236), Northern Selkup (Selkup: sel, selk1253), Northern Mansi (Mansi: mns, mans1258) and Tundra Nenets (yrk, tund1255). 

The data in this repository will primarily contain Ground Truth files for training OCR systems, but also the intermediate workflows and processing steps will be documented to the extend that is reasonable.

If you want to get a quick idea of what this is about, just clone the repository and open file `temp-correction-1.html` in Firefox.

Language and line specific metadata is stored in the file `meta_pages.csv`. The file `meta_extra.csv` contains additional information about lines that are written on distinct fonts, i.e. titles. 

## Authors and reuse

This work has been done by Niko Partanen and Michael Rießler in Kone Foundation funded [IKDP-2](https://langdoc.github.io/IKDP-2/) research project. Please cite it using following template:

    Partanen, Niko & Rießler, Michael 2018: Unified Northern Alphabet OCR Ground Truth v1.1. DOI: 10.5281/zenodo.1493414.

## Distributed models

There are trained Tesseract and Ocropy models distributed with the training data, and these can be found from `models/tesseract` and `models/ocropy` directories. With Tesseract the `.traineddata` file should be moved into `tessdata` directory.

## Training process

The model creation process was iterative, so that new data was added in several batches, each having been OCR'd with the model trained on data that had accumulated into that point. The iterations 1 and 2 contained simply data from all books in consecutive page order, with no attention to content. In the iteration 3 (planned) the page balance will be bit different, in order to achieve the wanted number of individual lines.

Training data looks essentially like this:

![](/train_part_2/0004/010001.bin.png )

Corresponding to the text file with content:

`- Ņajt hum samaꜧe os aꜧmьl jem-`

## Questions

The Wikipedia article [Единый северный алфавит](https://ru.wikipedia.org/wiki/%D0%95%D0%B4%D0%B8%D0%BD%D1%8B%D0%B9_%D1%81%D0%B5%D0%B2%D0%B5%D1%80%D0%BD%D1%8B%D0%B9_%D0%B0%D0%BB%D1%84%D0%B0%D0%B2%D0%B8%D1%82) contains a good table of all characters used in all languages. The character values used in this Ground Truth dataset are the same as in that table. In many cases these are not the correct Unicode characters.

## Commands used

Individual pages were extracted with commands:

```
ocropus-nlbin raw_part_1/*.png -o train_part_1
ocropus-gpageseg 'train_part_1/*.bin.png'
ocropus-gtedit html train_part_1/*/*.png -o temp-correction-1.html
# Initial OCR result was copied semi-manually from Fenno-Ugrica OCR
# In alter iterations the model trained with this data was used

ocropus-nlbin raw_part_2/*.png -o train_part_2
ocropus-gpageseg 'train_part_2/*.bin.png'
ocropus-rpred -Q 4 -m ./models/02/una-02-d05059-00102000.pyrnn.gz 'train_part_2/*/*.bin.png'
ocropus-gtedit html train_part_2/*/*.png -o temp-correction-2.html

ocropus-nlbin raw_part_3/*.png -o train_part_3
ocropus-gpageseg 'train_part_3/*.bin.png'
ocropus-rpred -Q 4 -m ./models/02/una-02-d05059-00102000.pyrnn.gz 'train_part_3/*/*.bin.png'
ocropus-gtedit html train_part_3/*/*.png -o temp-correction-3.html

ocropus-nlbin raw_part_4/*.png -o train_part_4
ocropus-gpageseg 'train_part_4/*.bin.png'
ocropus-rpred -Q 4 -m ./models/02/una-02-d05059-00102000.pyrnn.gz 'train_part_4/*/*.bin.png'
ocropus-gtedit html train_part_4/*/*.png -o temp-correction-4.html

ocropus-nlbin raw_part_5/*.png -o train_part_5
ocropus-gpageseg 'train_part_5/*.bin.png'
ocropus-rpred -Q 4 -m ./models/02/una-02-d05059-00102000.pyrnn.gz 'train_part_5/*/*.bin.png'
ocropus-gtedit html train_part_5/*/*.png -o temp-correction-5.html

ocropus-nlbin raw_part_6/*.png -o train_part_6
ocropus-gpageseg 'train_part_6/*.bin.png'
ocropus-rpred -Q 4 -m ./models/02/una-02-d05059-00102000.pyrnn.gz 'train_part_6/*/*.bin.png'
ocropus-gtedit html train_part_6/*/*.png -o temp-correction-6.html

ocropus-nlbin raw_part_8/*.png -o train_part_8
ocropus-gpageseg 'train_part_8/*.bin.png'
ocropus-rpred -Q 4 -m ./models/02/una-02-d05059-00102000.pyrnn.gz 'train_part_8/*/*.bin.png'
ocropus-gtedit html train_part_8/*/*.png -o temp-correction-8.html

# This Evenki section is still unclear whether it actually is in 
# Public Domain, so it will not be publicly added yet.
#ocropus-nlbin raw_part_7/*.png -o train_part_7
#ocropus-gpageseg 'train_part_7/*.bin.png'
#ocropus-rpred -Q 4 -m ../models/mixed/una-test-1-00010000.pyrnn.gz 'train_part_7/*/*.bin.png'
#ocropus-gtedit html train_part_7/*/*.png -o temp-correction-7.html
```

You can edit the lines by modifying `temp-correction` files in Firefox and saving the file. Chrome will not save the edited lines! If you use some esoteric browser, please try first! The lines can be written back to correct place with:

```
ocropus-gtedit extract -O temp-correction-1.html
ocropus-gtedit extract -O temp-correction-2.html
ocropus-gtedit extract -O temp-correction-3.html
ocropus-gtedit extract -O temp-correction-4.html
ocropus-gtedit extract -O temp-correction-5.html
ocropus-gtedit extract -O temp-correction-6.html
# ocropus-gtedit extract -O temp-correction-7.html
ocropus-gtedit extract -O temp-correction-8.html
```

Adding the lines GitHub can be done with:

```
git add train_part_1/*/*png
git add train_part_1/*/*txt
git add train_part_2/*/*png
git add train_part_2/*/*txt
git add train_part_3/*/*png
git add train_part_3/*/*txt
git add train_part_4/*/*png
git add train_part_4/*/*txt
git add train_part_5/*/*png
git add train_part_5/*/*txt
git add train_part_6/*/*png
git add train_part_6/*/*txt
```

This will not add all extracted full pages, just in order to save the page. The OCR systems basically need just the lines for training, although the goal is to archive the whole dataset and pipeline from raw images to the finished lines.

If the line is not properly recognized, then leave it empty. Those will be fixed later. Flag -O is important, it does the overwrite.

Current models, stored in `models` folder, were trained approximately with these commands:

```
ocropus-rtrain -c ./train/*/*gt.txt -o una-01-58a2a7 -d 20 ./train_part_1/*/*png
ocropus-rtrain -c ./train/*/*gt.txt -o una-02-d05059 -d 20 ./train_part_1/*/*png
ocropus-rtrain -c ./*/*/*gt.txt -o models/03/una-03-279620 -d 20 ./*/*/*png
``` 

For actual testing the models should be trained on different subsets of the data.