#!/bin/sh

curl -X POST \
--url "${STRIDE_URL}" \
-H 'Content-Type: application/json' \
-H 'Authorization: Bearer '"${STRIDE_TOKEN}"'' \
-d '{
    "body":{
        "version":1,
        "type":"doc",
        "content":[{
            "type":"applicationCard",
            "attrs": {
                "text": "test message",
                "collapsible":true,
                "title":{
                    "text":"Circle CI Report",
                    "user":{
                        "icon":{
                            "url":"https://a.slack-edge.com/7f1a0/plugins/circleci/assets/service_512.png",
                            "label":"Circle CI"
                        }
                    }
                },
                "description":{
                    "text":"'"${CIRCLE_USERNAME}"' built '"${CIRCLE_PROJECT_REPONAME}"' '"${CIRCLE_BRANCH}"'"
                },
                "details":[{
                    "lozenge": {
                        "text": "Build Failed",
                        "appearance": "removed"
                    }
                }],
                "link":{
                    "url":"'"${CIRCLE_BUILD_URL}"'"
                }
            }
        }]
    }
}'
