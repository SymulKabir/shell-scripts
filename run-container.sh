#!/bin/bash


# Parse arguments
for arg in "$@"; do
    eval "$arg"
done


# Status variables
Yellow_Color='\033[0;93m';
Green_Color='\033[0;92m';
No_Color='\033[0m'

# Define veriables
module_name="$name"
module_port="$port"

if [ -z "$module_name" ]; then
  echo -e "${Yellow_Color} Error: name is required. ${No_Color}"
  exit 1
fi

if [ -z "$module_port" ]; then
  echo -e "${Yellow_Color} Error: port is required. ${No_Color}"
  exit 1
fi

clone "$module_name"

if [ ! -d "./${module_name}" ]; then
  echo -e "${Yellow_Color} Error: The ${module_name} folder doesn't exist ${No_Color}"
  exit 1
fi

cd "$module_name"

if [ ! -f "./Dockerfile" ]; then
 echo -e "${Yellow_Color} Error: Docker file doesn't exist"
 cd ../
 exit 1
fi

docker build -t "${module_name}" ./ 

if docker ps -a --format '{{.Names}}' | grep -wq "${module_name}"; then
  echo "${Green_Color} Removed Container - ${name} ${No_Color}"
fi

docker run -d -p "${module_port}:${module_port}" --name "${module_name}" "${module_name}"

cd ../

echo -e "${Green_Color} Docker container runed Successfylly ${No_Color}"
