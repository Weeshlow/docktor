# Build
Alpha build. Still working on all of the configuration options.

# Usage

`docker run -dt --name fastexit --rm torworld/fastexit`

`Nickname: -n name`
`DirPort: -d port`
`ORPort: -o port`
`Contact Info: -c info`

# Example
`docker run -dt --name fastexit -p 80:80 -p 9030:9030 -p 9001:9001 torworld/fastexit -c "abuse [AT] torworld.org" -d 9030 -o 9001 -n TorWorld`

# Manage
`docker exec -it fastexit /bin/sh`

# Contact
If you have any questions feel free to email us: security[AT]torworld.org
