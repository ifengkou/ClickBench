#!/bin/bash

# set -x
if [[ ! -d results ]]; then mkdir results; fi

echo -e "{
    \"system\": \"Clickhouse\",
    \"date\": \"$(date '+%Y-%m-%d')\",
    \"machine\": \"$(sudo dmidecode -s system-product-name), 500gb gp2\",
    \"cluster_size\": 1,
    \"comment\": \"\",
    \"tags\": [\"C++\", \"column-oriented\", \"ClickHouse derivative\"],
    \"load_time\": 1380,
    \"data_size\": 14580183513,
    \"result\": [
$(
    # 每行取最后一列 awk -F',' '{print $NF}'
    # 每3行 合并成一行 sed 'N;N;s/\n/,/g' 123
    # 首尾加[]   sed "s/^/[/g" sed "s/$/]/g" 
    # cat result.csv | awk -F',' '{print $NF}' |  sed 'N;N;s/\n/,/g' | sed "s/^/[/g" |sed "s/$/],/g" 
    r= cat result.csv | awk -F',' '{print $NF}' |  sed 'N;N;s/\n/,/g' | sed "s/^/[/g" |sed "s/$/],/g"
    # 去掉最后一个 ,
    echo "${r%?}"
)
    ]
}
" | tee results/"$(sudo dmidecode -s system-product-name).json"

