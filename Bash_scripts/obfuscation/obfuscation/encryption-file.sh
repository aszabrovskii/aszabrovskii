#!/bin/bash

encrypted='U2FsdGVkX1/I2B2xVVvAbEoNduMdSPWFfx9ID6YyuGvjokd9RIv08qcL9hL+oMrb'
read word

innerScript=$(echo "$encrypted" | openssl aes-256-cbc -base64 -d -pass pass:"$word")
eval "$innerScript"

