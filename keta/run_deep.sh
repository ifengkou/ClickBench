#!/bin/bash

TRIES=3
QUERY_NUM=1
touch result.csv
truncate -s0 result.csv
TOKEN="eyJhbGciOiJIUzUxMiIsInppcCI6IkRFRiJ9.eJxNzEsKAyEQRdG91FjB6vZX7qZEBYNpQtQQaLL32KNkeA-Pd8JtVAiQKCsyFqVSmqT2zkvGqGXynnJRJkVkEFB7X2NO93qs6jP-Fc90HeXCs43V-f2AgE7hjm7bUcARywJLZNTmL6g8fmB3Aa_6HJMbhMKt588XI4wrSA.WyS--Al_WcSFJrtH56TBOLc5YkVQ8B_NONPcUDiXzLF27saON7aHtlh-pKr7VBw7VdUeakEQ7SklQbUWgs3EeQ"
URL='http://localhost:9200/api/v1/jobs'
while read -r query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
    echo -n "query${QUERY_NUM}," | tee -a result.csv
    for i in $(seq 1 $TRIES); do
        #RES=$(curl -s -k -X POST "$URL" --location-trusted -m 602 --insecure --compressed -H "Authorization: $TOKEN" -H 'Pragma: no-cache' -H 'Content-Type: application/json' -d '{"app":"search","source":"search","query":"'"${query}"'","endTime":1699505966536,"mode":"fast","preview":false,"collectSize":500,"timeout":600000,"sorts":[]}' | jq .meta.duration || :)
        #echo $RES
        #echo -n "$RES" | tee -a result.csv
        #[[ "$i" != "$TRIES" ]] && echo -n "," | tee -a result.csv
        RES=$(curl -s -k -X POST "$URL" --location-trusted -m 602 --insecure --compressed -H "Authorization: $TOKEN" -H 'Pragma: no-cache' -H 'Content-Type: application/json' -d '{"app":"search","source":"search","query":"'"${query}"'","endTime":1699505966536,"mode":"fast","preview":false,"collectSize":500,"timeout":600000,"sorts":[]}')
        jqR=$(echo $RES | jq '.meta.process, .id, .meta.duration')
        ARR=($jqR)
        DUR=null
        #echo "${ARR[0]} : ${ARR[1]}  :  ${ARR[2]}"
        if [ ${ARR[0]} == "1" ]; then
            # 处理完成
            DUR=${ARR[2]}
        elif [ ${ARR[0]} == "0" ]; then
            CONTiN=true
            QID=$(echo ${ARR[1]} | sed 's/\"//g')
            #echo "queryid=$QID"
            while [ $CONTiN ]; do
                sleep 5
                RES2=$(curl -s -k -X GET "$URL/$QID" --location-trusted --insecure --compressed -H "Authorization: $TOKEN" -H 'Pragma: no-cache' -H 'Content-Type: application/json')
                #echo "request again=$RES2"
                jqR2=$(echo $RES2 | jq '.process,  .duration')
                ARR2=($jqR2)
                if [ "${ARR2[0]}" == "1" ]; then
                    DUR=${ARR2[1]}
                    CONTiN=false
                    break
                fi
            done
        else
            echo "query${QUERY_NUM} error; resp=$RES"
        fi
        #echo "duration=$DUR"
        #DUR_S=$(awk 'BEGIN{printf "%0.2f","$DUR"/1000}')
        DUR_S=$(printf "%.2f" `echo "scale=2;$DUR/1000"|bc`)
        echo -n "$DUR_S" | tee -a result.csv
        [[ "$i" != "$TRIES" ]] && echo -n "," | tee -a result.csv
    done
    echo "" | tee -a result.csv

    QUERY_NUM=$((QUERY_NUM + 1))
done <queries_debug.sql