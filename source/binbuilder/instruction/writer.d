/**
Instruction writer.
*/
module binbuilder.instruction.writer;

/**
Instruction writer.
*/
interface Writer
{
    /**
    Write a byte.

    Params:
        value = writing a byte.
    */
    void write(ubyte value) @nogc nothrow pure @safe scope;

    /**
    Write bytes.

    Params:
        bytes = writing bytes.
    */
    void write(scope const(ubyte)[] bytes) @nogc nothrow pure @safe scope;
}

