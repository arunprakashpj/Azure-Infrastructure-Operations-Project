#!/bin/bash

az policy definition create --name tagging-policy \
							--mode indexed \
                            --description "This policy deny if indexed resources in the subscription have no tags" \
                            --display-name "Deny the creation of resources without tags" \
			    --description "This policy deny if indexed resources in the subscription have no tags" \
			     --rules tagging-policy.json
