- Release mainly focused on documentation and fleshing out secondary systems (templates and breakpoint systems)

## Test environments
* local R installation, R 4.1.1
* macOS 11.6.5 (on github-actions), R 4.1.3
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 0 notes

There is one NOTE that is only found on Windows (Server 2022, R-devel 64-bit):
```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
As per [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.
