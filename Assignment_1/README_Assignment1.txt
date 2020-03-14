Simple shell script for etl on csv file.

Some assumption made.
- no special character

- name is (tricky?) eg. John Smith , I assumed the first name is John , last name is Smith

- Simple sed replacement to remove leading 0 in front of value.
- Simple check for name whether it exist and value > 100.