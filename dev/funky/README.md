# funky
a little meta magic

**depends**
* [file classdef repo](https://github.com/johndevitis/file)


# example usage:
 
Setup:
```
f = funky()         % create instance
f.name = 'newfcn';  % change properties
f.author = 'john';  % sign
```

Create function from template:
```
f.create()          % create file
edit(f.fullname)    % view in editor
```