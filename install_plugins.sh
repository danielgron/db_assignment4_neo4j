#sudo rm /var/lib/neo4j/plugins/
sudo cp -a plugins/. /var/lib/neo4j/plugins/
sudo cp neo4j.conf /etc/neo4j/neo4j.conf
sudo cp Sample_Game_1_RawEventsData.csv /var/lib/neo4j/import/import.csv

sudo systemctl stop neo4j.service
sudo systemctl start neo4j.service
