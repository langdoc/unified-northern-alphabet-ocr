git rm train_part_1/*/*txt
git rm train_part_2/*/*txt
git rm train_part_3/*/*txt
git rm train_part_4/*/*txt
git rm train_part_5/*/*txt
git rm train_part_6/*/*txt
git rm train_part_8/*/*txt

/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-gtedit extract -O temp-correction-1.html
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-gtedit extract -O temp-correction-2.html
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-gtedit extract -O temp-correction-3.html
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-gtedit extract -O temp-correction-4.html
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-gtedit extract -O temp-correction-5.html
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-gtedit extract -O temp-correction-6.html
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-gtedit extract -O temp-correction-8.html

git add train_part_1/*/*txt
git add train_part_2/*/*txt
git add train_part_3/*/*txt
git add train_part_4/*/*txt
git add train_part_5/*/*txt
git add train_part_6/*/*txt
git add train_part_8/*/*txt

git commit -m "updating lines"
