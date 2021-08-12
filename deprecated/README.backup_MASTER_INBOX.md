# README `backup_MASTER_INBOX`

- Last edited: Thu 13 Dec 2018 10:05:05 AM CET
- Sign: JN

## Description

The script `backup_MASTER_INBOX` will copy files from `/proj/sllstorexxxxxxx/MASTER_INBOX`
on UPPMAX to `/dnadata/projects/xxx/MASTER_INBOX` on NRM.

Note that the script is tailored specifically for the source and target directories
above.

The script will automatically estimate the runtime, create a slurm script, and then
submit the slurm script to the system. E-mails will be send on start and end (and error).


## Install

**Easier, lazy solution:** Get file `backup_MASTER_INBOX` from JN, put (in your $PATH) on UPPMAX.

**More complete do-it-yourself instructions:**

1. Logged in to rackham, clone the repo from github:

        [x@rackham ~]$ git clone https://github.com/Naturhistoriska/backup2nrm.git

2. Inside the downloaded backup2nrm folder, edit the script `backup_MASTER_INBOX` and add entries for

        my $nrmuser     = 'edit here'; # Provide your NRM user name here ('joebro')
        my $email       = 'edit here'; # Provide your e-mail address here ('joe.brown@email.com')
        my $nrmcomputer = 'edit here'; # Provide the name of the NRM backup computer here ('xxxx.nrm.se')
        my $nrmpath     = 'edit here'; # Confirm path with NRM-IT ('/dnadata/projects')!
        my $cpuaccount  = 'edit here'; # Account ID for CPU hours on UPPMAX ('snicxxxx-x-xxx')
        my $masterinbox = 'edit here'; # Path to MASTER_INBOX on UPPMAX ('/proj/sllstorexxxxxxx/MASTER_INBOX')

3. Change permissions on the script and put it in your PATH. For example (might need some extra steps):

        [x@rackham ~]$ chmod +x ~/backup2nrm/backup_MASTER_INBOX
        [x@rackham ~]$ mkdir -p ~/bin/
        [x@rackham ~]$ cp ~/backup2nrm/backup_MASTER_INBOX ~/bin/


## Usage

Calculate approx time, create and submit SLURM file, receive email when started, and done:

    [x@rackham ~]$ backup_MASTER_INBOX

To specify specific arguments, you may use combinations (or all) of the ones below:

    [x@rackham ~]$ backup_MASTER_INBOX \
        --autotime=3 \
        --cpuaccount=snicxxxx-x-xxx \
        --email=x@x.xx \
        --nrmuser=x
        --submit \
        --verbose \
        --masterinbox='/proj/sllstorexxxxxxx/MASTER_INBOX'

Or the same, using short args:

    [x@rackham ~]$ backup_MASTER_INBOX -a=3 -c=snicxxxx-x-xxx -e=x@x.xx -n=x -s -v -m='/proj/sllstorexxxxxxx/MASTER_INBOX'

See the output from `backup_MASTER_INBOX --help` for more information.

### More examples

Create script, but do not submit to SLURM:

    [x@rackham ~]$ backup_MASTER_INBOX --nosubmit

The generated script (long name starting with "rsync-") can then be checked
by, e.g., 

    [x@rackham ~]$ sbatch --test-only rsync-12122018-MASTER_INBOX.slurm

and, if OK, submit manually by

    [x@rackham ~]$ sbatch rsync-12122018-MASTER_INBOX.slurm

