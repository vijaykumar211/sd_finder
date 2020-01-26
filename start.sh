rm cs_domains_output.txt
rm amass_out.txt
./amass enum --passive -d $1 -o amass_out.txt
python commonspeak_list_generate.py $1
sort amass_out.txt cs_domains_output.txt | uniq > amass_plus_cs_output.txt
