rm cs_domains_output.txt
rm amass_out.txt
rm massdns_output_1.txt
./amass enum --passive -d $1 -o amass_out.txt
python commonspeak_list_generate.py $1
sort amass_out.txt cs_domains_output.txt | uniq > amass_plus_cs_output.txt
./massdns -r resolvers.txt -t A -o J -w massdns_output_1.txt amass_plus_cs_output.txt
