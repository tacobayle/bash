#!/bin/bash
test="{\"test_list\" : []}"
test=$(echo $test | jq '.test_list += [{"abc": "abc"}]')
test=$(echo $test | jq '.test_list += [{"def": [1,2,3]}]')
test=$(echo $test | jq '.test_list[0] += {"my_new_key": "my_new_value"}')
test=$(echo $test | jq '.test_list[] += {"my_new_key_for_all": "my_new_value_for_all"}')
test=$(echo $test | jq '.test_list[1].def += [{"my_very_nested_key": "my_very_nested_value"}]')
echo $test | jq .
