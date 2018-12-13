build_path=`pwd`
cp -f ./dep/entry.sh ./
sudo docker build -t omo-proxy $build_path
rm -f ./entry.sh
