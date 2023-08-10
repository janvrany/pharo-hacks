# Pharo Hacks

*Pharo Hacks* is a set of assorted additions to Pharo that do not fit elsewhere and might be usable outside of projects that prompted its development.

Currently available hacks:

 * *[LibCompat](src/LibCompat)* is yet another compatilibility library that provides source-level compatibility with Smalltalk/X. It is used to facilitate ports of code originating in Smalltalk/X over to Pharo.

 * *[LibUnix](src/LibUnix)* is a tiny library providing better integration with UNIX systems than what's available in stock Pharo. Currently it provides crude support spawning processes and long-running communication over pipes and PTYs.

## Loading

```
Metacello new
   	baseline: 'LibCompat';
   	repository: 'github://janvrany/pharo-hacks';
   	load.

Metacello new
   	baseline: 'LibUnix';
   	repository: 'github://janvrany/pharo-hacks';
   	load.
```


## Development

 Development is driven purely by necessity but any PR would be reviewed and
 eventually merged.

## License

 Code is released under MIT license, see [LICENSE](LICENSE)