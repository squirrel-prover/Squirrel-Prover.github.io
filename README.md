# How to update our website

Please do not edit HTML directly! Edit corresponding markdown files instead,
then run make, and push your modifications to github.

# Requirements

## Pandoc

You need the --citeproc option, which means version 2.19.2 or above.

You may need to install it directly from pandoc's website,
which provides e.g. Debian packets for the latest pandoc.

# Populated and up-to-date squirrel-prover submodule

To populate and update the submodule, run:
```
git submodule init
git submodule update
```

<!> Jsquirrel compilation requires to uninstall why3. The doc compilation requires to have why3 installed...
