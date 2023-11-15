#!/bin/bash

# set -x
if [[ ! -d results ]]; then mkdir results; fi

echo -e "{
    \"system\": \"Xishu Ketadb\",
    \"date\": \"$(date '+%Y-%m-%d')\",
    \"machine\": \"$(sudo dmidecode -s system-product-name), 500gb gp2\",
    \"cluster_size\": 1,
    \"comment\": \"1. 43个SQL都能完全翻译SPL(人工翻译）；\n 2. 其中有14、17、19、23、29、34、35、36号查询会导致OOM问题；search1有内存限制；\n 3. API方式存在cache，无法消除影响；\n 4. ketadb在查询完全结束前，可以预先返回部分结果；5. 前后两个相关性强的SQL（执行task可能有缓存优化？）\",
    \"tags\": [\"Ketadb\"],
    \"load_time\": 18600,
    \"data_size\": 143018120000,
    \"result\": [
$(
    r=$(sed -r -e 's/query[0-9]+,/[/; s/$/],/' result.csv)
    echo "${r%?}"
)
    ]
}
" | tee results/"$(sudo dmidecode -s system-product-name).json"

