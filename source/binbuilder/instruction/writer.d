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

/**
Instruction writeable.
*/
interface Writeable
{
    /**
    Write to writer.

    Params:
        writer = destination writer.
    */
    void writeTo(scope Writer writer) const @nogc nothrow pure @safe scope;

    /**
    Returns:
        Writing bytes length.
    */
    @property size_t length() const @nogc nothrow pure @safe scope;
}

