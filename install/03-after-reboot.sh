#!/bin/bash

passwd
useradd -m -G wheel -s /bin/bash jeff
passwd jeff

#---[fix]---------------
visudo
#-----------------------

exit
