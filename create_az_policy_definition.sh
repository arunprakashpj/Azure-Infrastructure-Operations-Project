#!/bin/bash

az policy definition create --name tagging-policy \
							--mode indexed \
                            --rules azure-policy.json --params tagging-policy.json \
                            --mode Indexed \
                            --description "This policy deny if indexed resources in the subscription have no tags"
