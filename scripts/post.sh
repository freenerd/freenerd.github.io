# Created a new post with title and current date
#
# Usage: ./scripts/post.sh My new post

date=$(date +%F)

filename="$date-$( echo $1 | tr "A-Z" "a-z" | tr " " "-" ).md"

post=$(cat <<POST
---
layout:   post
title:    $1
comments: true
---
POST)

echo "$post" > "./_posts/$filename"

mvim "./_posts/$filename"
