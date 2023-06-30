#!/bin/bash

host="localhost"
port=9200
index="my_index"

curl -XDELETE "$host:$port/$index"
echo "\n"
curl -XPUT "$host:$port/$index" \
--header 'Content-Type: application/json' \
--data '{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "type": "standard",
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "russian_morphology"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "my_field": {
        "type": "text",
        "analyzer": "my_analyzer"
      }
    }
  }
}'
echo "\n"
doc_id_one="1"
curl -XPUT "$host:$port/$index/_doc/$doc_id_one" \
--header 'Content-Type: application/json' \
--data '{
  "my_field": "созданная металло-конструкция"
}'
echo "\n"
doc_id_two="2"
curl -XPUT "$host:$port/$index/_doc/$doc_id_two" \
--header 'Content-Type: application/json' \
--data '{
  "my_field": "металлический корпус"
}'
echo "\n"
doc_id_three="3"
curl -XPUT "$host:$port/$index/_doc/$doc_id_three" \
--header 'Content-Type: application/json' \
--data '{
  "my_field": "цветной металл"
}'
echo "\n"
doc_id_four="4"
curl -XPUT "$host:$port/$index/_doc/$doc_id_four" \
--header 'Content-Type: application/json' \
--data '{
  "my_field": "метал дротики"
}'
echo "\n"
doc_id_five="5"
curl -XPUT "$host:$port/$index/_doc/$doc_id_five" \
--header 'Content-Type: application/json' \
--data '{
  "my_field": "21у21 матался по жизни матал"
}'
echo "\n"
curl -XGET "$host:$port/$index/_search" \
--header 'Content-Type: application/json' \
--data '{
  "query": {
    "prefix": {
      "my_field": {
        "value": "металл"
      }
    }
  }
}'


