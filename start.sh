rm *_output.txt
./amass enum --passive -d $1 -o amass_output.txt
python commonspeak_list_generate.py $1
sort amass_output.txt cs_domains_output.txt | uniq > amass_plus_cs_output.txt
cat amass_plus_cs_output.txt | shuf > amass_plus_cs_2_output.txt
cat amass_plus_cs_output.txt | shuf > amass_plus_cs_3_output.txt
./massdns -r <(curl -s https://raw.githubusercontent.com/BBerastegui/fresh-dns-servers/master/resolvers.txt) -t A -s 1000 -o S -w "massdns_1_output.txt" "amass_plus_cs_output.txt"
./massdns -r <(curl -s https://raw.githubusercontent.com/BBerastegui/fresh-dns-servers/master/resolvers.txt) -t A -s 1000 -o S -w "massdns_2_output.txt" "amass_plus_cs_2_output.txt"
./massdns -r <(curl -s https://raw.githubusercontent.com/BBerastegui/fresh-dns-servers/master/resolvers.txt) -t A -s 1000 -o S -w "massdns_3_output.txt" "amass_plus_cs_3_output.txt"
comm -12 <(sort massdns_1_output.txt) <(sort massdns_2_output.txt) > massdns_common_1_output.txt
comm -12 <(sort massdns_common_1_output.txt) <(sort massdns_3_output.txt) > massdns_common_final_output.txt
awk -F ". " '{print $1}' "massdns_common_final_output.txt" > "wordlist_filtered_output.txt"
awk '!seen[$0]++' wordlist_filtered_output.txt > wordlist_filtered_final_output.txt

altdns -i wordlist_filtered_final_output.txt -o altdns_output.txt -w altdns_wordlist.txt
cat altdns_output.txt | shuf > altdns_2_output.txt
cat altdns_output.txt | shuf > altdns_3_output.txt

./massdns -r <(curl -s https://raw.githubusercontent.com/BBerastegui/fresh-dns-servers/master/resolvers.txt) -t A -s 1000 -o S -w "altdns_massdns_1_output.txt" "altdns_output.txt"
./massdns -r <(curl -s https://raw.githubusercontent.com/BBerastegui/fresh-dns-servers/master/resolvers.txt) -t A -s 1000 -o S -w "altdns_massdns_2_output.txt" "altdns_2_output.txt"
./massdns -r <(curl -s https://raw.githubusercontent.com/BBerastegui/fresh-dns-servers/master/resolvers.txt) -t A -s 1000 -o S -w "altdns_massdns_3_output.txt" "altdns_3_output.txt"

comm -12 <(sort altdns_massdns_1_output.txt) <(sort altdns_massdns_2_output.txt) > altdns_massdns_common_output.txt
comm -12 <(sort altdns_massdns_common_output.txt) <(sort altdns_massdns_3_output.txt) > altdns_massdns_common_final_output.txt
awk -F ". " '{print $1}' "altdns_massdns_common_final_output.txt" > "altdns_massdns_common_filtered_output.txt"
awk '!seen[$0]++' altdns_massdns_common_filtered_output.txt > altdns_massdns_sorted_final_output.txt

sort wordlist_filtered_final_output.txt altdns_massdns_sorted_final_output.txt | uniq > altdns_amass_final_output.txt
