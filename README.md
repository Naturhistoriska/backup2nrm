# backup2nrm

- Last modified: tor aug 12, 2021  09:13
- Sign: JN

## Description

Script for transferring UPPMAX files to backup server on NRM.

The current backup server is named nrmdna01.nrm.se and has limited access.

For transfer, we use rsync over ssh.

Assuming file structure similar to:

- On rackham:

        /proj/projectname/folder/to/transfer

- On NRM (where `XXX` is a department acronym, currently in use: BIO, BOT, ZOO,
  and `nrmuser` is the user in the Windows ActiveDirectory)

        /projects/XXX-projects/nrmuser

## Installation

0. From NRM IT-support, get information about
    1. Name and IP address for the NRM backup computer (below called
       `nrmcomputer`).
    2. User name on the backup computer (prob. same as your Windows user).
       Below called `nrmuser`.
    3. Directory structure on NRM backup computer (e.g.
       `/projects/BIO-projects`)
    4. How to set up "passwordless communication between uppmax and
       nrmdna01.nrm.se"
1. Login to UPPMAX (`rackham.uppmax.uu.se`)
2. Clone the repository from
[https://github.com/NBISweden/backup2nrm.git](https://github.com/NBISweden/backup2nrm.git),
using
    - `git clone https://github.com/NBISweden/backup2nrm.git`
3. Put the file `backup2nrmdna01` in your PATH (on UPPMAX)
4. For convenience, edit the `backup2nrmdna01` file to add values for
    1. `$nrmuser`
    2. `$email`
    3. `$department`
    4. (`$nrmpath`)
    5. (`$cpuaccount`)

## Usage

The script performs a number of tasks:

1. Gather information on the source (on uppmax) and destination (on nrm)
   folders
2. Sends mock data to measure the transfer speed and estimate the time needed
   for complete transfer (optional step)
3. Creates a script with rsync commands for the queue system (SLURM) on uppmax
4. Submits the script to SLURM (optional)

All steps can be run at once. For example (run on uppmax, and with default
values edited in the script):

    [rackham]$ backup2nrmdna01 -a -s /proj/snic1234-56-789/delivery012345

This will transfer the folder `delivery012345` to the destination at NRM, which
--- if values for `--nrm-user` and `--department` are provided --- is
`nrmdna01.nrm.se:/projects/XXX-projects/nrmuser/delivery012345`.

The full command may be given as (example)

    backup2nrmdna01 \
        --department=BIO \
        --nrm-user=joebro \
        --autotime \
        --cpuaccount=snic1234-45-789 \
        --email=joe.bro@mail.com \
        --submit \
        --verbose \
        /proj/snic1234-56-789/delivery012345

It may, however, be convenient to first generate the slurm script (saved in the
current working directory), then manually check - and perhaps modify the
entries, and finally submit the slurm-script manually.  This may be
accomplished like this (again with default values added in the script):

    [rackham]$ backup2nrmdna01 -a /proj/snic1234-56-789/delivery012345
    [rackham]$ less rsync-12082021.0-delivery012345-snic1234-56-789.slurm
    [rackham]$ sbatch --test-only rsync-12082021.0-delivery012345-snic1234-56-789.slurm
    [rackham]$ sbatch rsync-12082021.0-delivery012345-snic1234-56-789.slurm

For more details information, use `backup2nrmdna01 -h`.

