This tool is written to assist people who want to read the contents of values like this when they query MongoDB:

* BinData(0,"eyJ0ZXN0IjoxfQ==")
* { "$binary" : "eyJ0ZXN0IjoxfQ", "$type" : "00" }
* eyJ0ZXN0IjoxfQ

This is the sort of data that mongodb's client and robomongo return for binary json fields that are stored as embedded in more traditional document objects.  I am not sure if this is bson, but I am calling it that since that's what I thought it was initially.  I'm creating this tool to help the next person out who stumbles across this output from robomongo or the mongodb client and wants to see what their data really is.

Currently I only support converting the last format, but I will add support for the first two formats too.
   