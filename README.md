# backup2nrm

TODO: rewrite for decomission of milou

Backup script for transferring UPPMAX files to NRM.

Assuming file structure similar to:

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
1. Login to UPPMAX (`milou.uppmax.uu.se`)
2. Clone the repository from [https://github.com/NBISweden/backup2nrm.git](https://github.com/NBISweden/backup2nrm.git), using
    - `git clone https://github.com/NBISweden/backup2nrm.git`
3. Edit the `backup2nrm` file to add values for
    1. `$nrmuser`
    2. `$mailuser`
    3. `$nrmcomputer`
4. Put the file `backup2nrm` in your PATH (on UPPMAX)
