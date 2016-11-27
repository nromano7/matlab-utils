# classio
*MATLAB class IO magic.*

Use `classio` as a superclass for any MATLAB class definition to inherit file read/write capability. Objects can be serialized (write) and de-serialized (read + auto-populate class properties).

Currently only JSON is supported.

*Refer to `/libs/jsonlab/loadjson` and `/libs/jsonlab/savejson` for details regarding the encoding and decoding of specific data types (e.g. arrays and complex numbers) as well as available formatting options.*

# Examples

## Read-Write Example
A simple read/write example can be found in `examples/read_write_example/`.

The function `read_write_example` creates an instance of the `read_write_example_class` and uses the classio methods `obj2json` and `json2obj` to serialize and de-serialize the example object.

*MATLAB classdef file:*
```
classdef read_write_example_class < classio
	properties
        firstName = 'john'
        lastName = 'dev'
        age = 'dont ask'
	end
```

*JSON Output:*
```
{
	"read_write_example_class": {
		"firstName": "john",
		"lastName": "dev",
		"age": "dont ask"
	}
}
```


# Authors
The core code for the JSON encoding/decoding is called `jsonlab` and is hosted [here](http://iso2mesh.sourceforge.net/cgi-bin/index.cgi?jsonlab). The jsonlab library can be found in `libs/josnlab/`; information about the original authors can be found in `libs/jsonlab/AUTHORS.txt`.

 This repository was created by John DeVitis and hosts a class-wrapper implementation of the original jsonlab core.
