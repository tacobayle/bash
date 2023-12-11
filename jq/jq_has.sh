#!/bin/bash
if $(jq -e 'has("Master_DNS_names")' data/supervisor_test.json) ; then echo yes ; else echo no ; fi
if $(jq -e 'has("fake_key")' data/supervisor_test.json) ; then echo yes ; else echo no ; fi
if $(jq -e 'has("cluster_proxy_config")' data/supervisor_test.json) ; then echo yes ; else echo no ; fi
if $(jq -e '.cluster_proxy_config |  has("http_proxy_config")' data/supervisor_test.json) ; then echo yes ; else echo no ; fi
if $(jq -e '.cluster_proxy_config |  has("fake_key")' data/supervisor_test.json) ; then echo yes ; else echo no ; fi
