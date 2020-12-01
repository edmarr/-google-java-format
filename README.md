Formatting the Java source files according to Google Java Style Guide

The script will download (and cache) the Jar from https://github.com/google/google-java-format and try to re-format all changed .java files in the repository.

# PRE-COMMIT
Place the pre-commit script (with that name and executable bit set) in your .git/hooks directory.

# Job Pipeline Validation (GIT LAB)
```
....
job_01:
   script
    - git checkout $CI_BUILD_REF_NAME
    - chmod 775 formatter.sh
    - export iPUSH=$(./formatter.sh)
    - echo $iPUSH
    - |- 
        if [[ "$iPUSH" == "true" ]]; then
            git add -A && git commit -m "[skip ci] Java files Changed by Java Google Fomatter" && git push
        fi  ....
```



