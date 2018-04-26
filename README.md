# backup2nrm

TODO: rewrite for decomission of milou:

> Nu börjar det trilla in en hel del nya data från SciLife,
> så vi måste få ordning på hur vi gör back-up… 
> Jag lägger nu alla nya data i respektive INBOX på Rackham
> (dvs tex nya sedimentdatat `P9351` som ligger på
> `/proj/sllstore2017093/b2014312/b2014312/INBOX/P9351`).
> 
> Så om det skulle gå att ha ett script som backar upp alla
> INBOX:ar på `sllstore2017093`
> så vore det ju trevligt. 

    [nylander@rackham2]$ find /proj/sllstore2017093/ -maxdepth 4 -type d -name INBOX  2>/dev/null > inboxes.list
    [nylander@rackham2]$ inboxes.list
    /proj/sllstore2017093/b2016342/b2016342/INBOX
    /proj/sllstore2017093/b2016073/b2016073/INBOX
    /proj/sllstore2017093/b2016004/b2016004/INBOX
    /proj/sllstore2017093/b2015298/b2015298/INBOX
    /proj/sllstore2017093/b2015348/b2015348/INBOX
    /proj/sllstore2017093/b2017026/b2017026/INBOX
    /proj/sllstore2017093/b2016263/b2016263/INBOX
    /proj/sllstore2017093/b2014312/b2014312/INBOX
    /proj/sllstore2017093/b2017068/b2017068/INBOX
    /proj/sllstore2017093/b2017093/b2017093/INBOX
    /proj/sllstore2017093/b2015028/b2015028_nobackup/INBOX
    /proj/sllstore2017093/b2015028/b2015028/INBOX






Backup script for transferring UPPMAX files to NRM.

Assuming file structure similar to:

- On rackham:

        /proj/sllstore2017093/b2014312/b2014312/INBOX/P9351

- On NRM:

        /dnadata/projects/lovedale/b2014312/INBOX/P9351


**OLD:**

- On milou:

        /proj/b1234567/INBOX/A.Name_12_34

- On NRM:

        /dnadata/projects/nrmuser/b1234567/INBOX/A.Name_12_34


We wish to be able to do `backup2nrm b1234567` in order to sync files in the INBOXes

Then, in principle, it would suffice issuing this command (on UPPMAX):

    backup2nrm -s -a b1234567

The command above will:

1. Connect to NRM with `rsync` to find out the size of all files needed to be transferred
2. Send some test data to NRM to estimate the transfer speed
3. Create a slurm script in the current working directory
4. Submit the slurm script to the batch system on UPPMAX

An alternative usage (only item 3. above), is 

    backup2nrm b1234567

Then, the user need to review the generated slurm script, and submit it manually
using `sbatch slurmscript`.


## Usage

For detailed information, use `backup2nrm -h`

## Installation

0. From NRM IT-support, get information about
    1. Name and IP address for the NRM backup computer (below called `nrmcomputer`).
    2. User name on the backup computer (prob. same as your Windows user). Below called `nrmuser`.
    3. Directory structure on NRM backup computer (e.g. `/dnadata/projects/`)
1. Login to UPPMAX (`rackham.uppmax.uu.se`)
2. Clone the repository from [https://github.com/NBISweden/backup2nrm.git](https://github.com/NBISweden/backup2nrm.git), using
    - `git clone https://github.com/NBISweden/backup2nrm.git`
3. Edit the `backup2nrm` file to add values for
    1. `$nrmuser`
    2. `$mailuser`
    3. `$nrmcomputer`
4. Put the file `backup2nrm` in your PATH (on UPPMAX)
