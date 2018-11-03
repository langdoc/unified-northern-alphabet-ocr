## Unified Northern Alphabet OCR

This is an attempt to build an OCR system for the languages written in Unified Northern Alphabet. Ideally there would be samples from all languages with which it is used. Only Public Domain data is used. The pages originate from Fenno-Ugrica collection, citations will be added soon.

Unified Northern Alphabet was used for 16 different languages. In this dataset there are sentences from four of them: Kildin Saami, Northern Selkup, Northern Mansi and Tundra Nenets. 

## Training process

The model creation process was iterative, so that new data was added in several batches, each having been OCR'd with the model trained on data that had accumulated into that point. The iterations 1 and 2 contained simply data from all books in consecutive page order, with no attention to content. In the iteration 3 (planned) the page balance will be bit different, in order to achieve the wanted number of individual lines.

Training data looks essentially like this:

![](/train_part_2/0004/010001.bin.png )

Corresponding to the text file with content:

`- Ņajt hum samaꜧe os aꜧmьl jem-`

## Commands used

Individual pages were extracted with commands:

```
    convert -density 300 -trim file.pdf[8] -quality 100 raw/file.png
    ...
    ocropus-nlbin raw_part_1/*.png -o train_part_1
    ocropus-gpageseg 'train_part_1/*.bin.png'
    ocropus-gtedit html train_part_1/*/*.png -o temp-correction-1.html


    ocropus-nlbin raw_part_2/*.png -o train_part_2
    ocropus-gpageseg 'train_part_2/*.bin.png'
    ocropus-gtedit html train_part_2/*/*.png -o temp-correction-2.html
```

You can edit the lines by modifying `temp-correction` files in Firefox and saving the file. Chrome will not save the edited lines! If you use some esoteric browser, please try first! The lines can be written back to correct place with:

```
    ocropus-gtedit extract -O temp-correction-1.html
    ocropus-gtedit extract -O temp-correction-1.html
```

Adding the lines GitHub can be done with:

```
    add train_part_X/*/*png
    add train_part_X/*/*txt
```

This will not add all extracted full pages, just in order to save the page. The OCR systems basically need just the lines for training, although the goal is to archive the whole dataset and pipeline from raw images to the finished lines.

If the line is not properly recognized, then leave it empty. Those will be fixed later. Flag -O is important, it does the overwrite.

Current models, stored in `models` folder, were trained approximately with these commands:

```
    ocropus-rtrain -c ./train/*/*gt.txt -o una-01-58a2a7 -d 20 ./train_part_1/*/*png
    ocropus-rtrain -c ./train/*/*gt.txt -o una-02-d05059 -d 20 ./train_part_1/*/*png
``` 

## Testing

I'm just learning how to best test Ocropy models. Proper tests and model evaluations will follow. Now the training has been tested with something like below, but these are just my messy notes:

```
    cd test
    ocropus-nlbin raw/*.tif -o test
    ocropus-gpageseg 'test/*.bin.png'
    ocropus-rpred -Q 4 -m ../una-01-58a2a7-00137000.pyrnn.gz 'test/*/*.bin.png'
    ocropus-hocr 'test/*.bin.png' -o test.html
    ocropus-rpred -Q 4 -m ../models/02/una-02-d05059-00102000.pyrnn.gz 'book/*/*.bin.png'
    ocropus-nlbin sel/*.png -o sel_test
    ocropus-gpageseg 'sel_test/*.bin.png'
    ocropus-rpred -Q 4 -m ../models/02/una-02-d05059-00102000.pyrnn.gz 'sel_test/*/*.bin.png'
    ocropus-hocr 'sel_test/*.bin.png' -o sel_test.html
    ocropus-hocr 'book/*.bin.png' -o test.html
    ocropus-gtedit html sel_test/*/*.png -o sel_test-correction.html
    convert -density 300 -trim RU_NLR_ONL_3097_sel.pdf[38] -quality 100 sel/RU_NLR_ONL_3097_sel_0038.png
    ...
    convert -density 300 -trim RU_NLR_ONL_3097_sel.pdf[44] -quality 100 sel/RU_NLR_ONL_3097_sel_0044.png
```