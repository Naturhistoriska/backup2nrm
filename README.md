# backup2nrm

- Last modified: tor aug 12, 2021  07:52
- Sign: JN

## Description

Script for transferring UPPMAX files to backup server on NRM.

The current backup server is named nrmdna01.nrm.se and has limited access.

For transfer, we use rsync over ssh.

Assuming file structure similar to:

- On rackham:

        /proj/projectname

- On NRM (where XXX is a department acronym, currently in use: BIO, BOT, ZOO, and nrmuser is the user in the Windows ActiveDirectory)

        /projects/XXX-projects/nrmuser

## Installation

0. From NRM IT-support, get information about
    1. Name and IP address for the NRM backup computer (below called `nrmcomputer`).
    2. User name on the backup computer (prob. same as your Windows user). Below called `nrmuser`.
    3. Directory structure on NRM backup computer (e.g. `/projects/BIO-projects`)
    4. How to set up "passwordless communication between uppmax and nrmdna01.nrm.se"
1. Login to UPPMAX (`rackham.uppmax.uu.se`)
2. Clone the repository from [https://github.com/NBISweden/backup2nrm.git](https://github.com/NBISweden/backup2nrm.git), using
    - `git clone https://github.com/NBISweden/backup2nrm.git`
3. Put the file `backup2nrmdna01` in your PATH (on UPPMAX)
4. For convenience, edit the `backup2nrmdna01` file to add values for
    1. `$nrmuser`
    2. `$email`
    3. `$department`
    4. (`$nrmpath`)
    5. (`$cpuaccount`)

## Usage

For detailed information, use `backup2nrmdna01 -h`

One example (run on uppmax, and with some default values edited in the script):

    $ backup2ndmdna01 -c snic123-45-678 -autotime -s /proj/snic123-45-678/delivery012345

