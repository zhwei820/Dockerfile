wget https://github.com/jumpserver/jumpserver/archive/master.zip -O src/jumpserver.zip
wget https://github.com/jumpserver/coco/archive/master.zip -O src/coco.zip
wget https://github.com/jumpserver/luna/releases/download/v1.0.0/luna.tar.gz -O src/luna.tar.gz
cd src/;
unzip coco.zip && mv coco-master coco && unzip jumpserver.zip && mv jumpserver-master jumpserver && tar xzf luna.tar.gz
