sudo apt-get update -y;
sudo apt-get install apache2 -y;
sudo apt-get install build-essential -y;

git clone https://github.com/blechschmidt/massdns.git;
cd massdns;
make;