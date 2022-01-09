import gdb

class CmdPrintEnum(gdb.Command):
    """Prints each of the enumerated values defined by an enum"""

    def __init__(self):
        super(CmdPrintEnum, self).__init__("print-enum", gdb.COMMAND_DATA, gdb.COMPLETE_EXPRESSION)

    def invoke(self, argstr, from_tty):
        typename = argstr
        if not typename or typename.isspace():
            raise gdb.GdbError("Usage: print-enum type")

        try:
            t = gdb.lookup_type(typename)
        except gdb.error:
            typename = "enum " + typename
            try:
                t = gdb.lookup_type(typename)
            except gdb.error:
                raise gdb.GdbError("type " + typename + " not found")

            if t.code != gdb.TYPE_CODE_ENUM:
                raise gdb.GdbError("type " + typename + " is not an enum")

            for f in t.fields():
                print(f.name, "=", f.enumval)

CmdPrintEnum()
