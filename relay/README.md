# Build
Pre-Alpha build. Still working on all configuration options.

# Usage

`docker run -it --rm torworld/fastrelay`

`Nickname: -n name`
`DirPort: -d port`
`ORPort: -o port`
`Contact Info: -c info`

# Example
`docker run -it --rm -p 9030:9030 -p 9001:9001 torworld/fastrelay -c "abuse [AT] torworld.org" -d 9030 -o 9001 -n TorWorld`

# Contact
If you have any questions feel free to email us: security[AT]torworld.org