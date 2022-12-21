docker build ./ -t testenv
# virtual machine ubuntu
docker run --gpus all --name virtualmachineubuntu -itd -p 8887:8888 testenv 
