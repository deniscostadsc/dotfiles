# SSH

## General config

This task enables the coexistance of two SSH keys, one for work and one for
personal purposes. I set the work SSH key to impact only the domain
`work.github.com`. For that reason, after a work repositoryt is cloned, it's
necessary need to change the remote URL to add the suffix `work.`. The command
[workfy-repo](roles/git/files/bin/workfy-repo.sh) does the job.

To allow two different SSH keys, there are two host config on [SSH config
file](roles/ssh/files/ssh/config).
