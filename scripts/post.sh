# Created a new post with title and current date
#
# Usage: ./scripts/post.sh My new post

if [[ $1 == "" ]]
then
  echo "Usage: ./post.sh <TITLE>"
  exit 1
fi

date=$(date +%F)

filename="$date-$( echo $1 | tr "A-Z" "a-z" | tr " " "-" ).md"
full_filename="./_posts/$filename"

post=$(cat <<POST
---
layout:   post
title:    "$1"
comments: true
---
POST)

echo "$post" > $full_filename
echo "Generated new post: $full_filename"

mvim "./_posts/$filename"
