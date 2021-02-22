#! /bin/bash

echo "This is for Configuring Gmail setup"

read -p "Enter your email id:" email
read -p "Enter your passwd:" pass_mail
read -p "Enter Name:" name
sed -i 's/<email-id>/`$email`/g' ./.muttrc
sed -i 's/<passwd>/`$pass_mail`/g' ./.muttrc
sed -i 's/<name>/`$name`/g' ./.muttrc


