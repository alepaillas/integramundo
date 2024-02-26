#!/bin/bash
curl 'https://s370.v2n.cl:2083/execute/Email/list_pops' -H "Authorization: cpanel integram:7LS4D28UDVLE85XJQXO0FGJBF1GMCYFX" | jq

curl 'https://s370.v2n.cl:2083/execute/Email/suspend_outgoing?email=management@integramundo.cl' -H "Authorization: cpanel integram:7LS4D28UDVLE85XJQXO0FGJBF1GMCYFX" | jq

curl 'https://s370.v2n.cl:2083/execute/Email/delete_held_messages?email=management@integramundo.cl' -H "Authorization: cpanel integram:7LS4D28UDVLE85XJQXO0FGJBF1GMCYFX" | jq

curl 'https://s370.v2n.cl:2083/execute/Email/release_outgoing?email=management@integramundo.cl' -H "Authorization: cpanel integram:7LS4D28UDVLE85XJQXO0FGJBF1GMCYFX" | jq