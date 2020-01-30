rm cs_domains_output.txt
rm amass_out.txt
rm massdns_output_1.txt
rm amass_plus_cs_output.txt
rm  massdns_output_2.txt
rm wordlist_filtered.txt
rm wordlist_filtered_1.txt
./amass enum --passive -d $1 -o amass_out.txt
python commonspeak_list_generate.py $1
sort amass_out.txt cs_domains_output.txt | uniq > amass_plus_cs_output.txt
#./massdns -r resolvers.txt -t A -o J -w massdns_output_1.txt amass_plus_cs_output.txt
./massdns -r <(curl -s https://raw.githubusercontent.com/vijaykumar2111/freshdnsrecord/master/resolvers.txt) -t A -s 1000 -o S -w "massdns_output_2.txt" "amass_plus_cs_output.txt"
awk -F ". " '{print $1}' "massdns_output_2.txt" > "wordlist_filtered.txt"
awk '!seen[$0]++' wordlist_filtered.txt > wordlist_filtered_1.txt
