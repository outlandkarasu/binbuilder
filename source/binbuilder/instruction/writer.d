/**
Instruction writer.
*/
module binbuilder.instruction.writer;

import std.container : Array;

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

/**
Array writer.
*/
class ArrayWriter : Writer
{
    override void write(ubyte value) @nogc nothrow pure @safe scope
    {
        (() @trusted => array_ ~= value)();
    }

    override void write(scope const(ubyte)[] bytes) @nogc nothrow pure @safe scope
    {
        (() @trusted => array_ ~= bytes)();
    }

    ubyte opIndex(size_t i) const @nogc nothrow pure @safe scope
    {
        return array_[i];
    }

private:
    Array!ubyte array_;
}

///
nothrow pure @safe unittest
{
    auto writer = new ArrayWriter();

    writer.write(0x01);
    writer.write(0x02);
    writer.write(0x03);
    assert(writer[0] == 0x01);
    assert(writer[1] == 0x02);
    assert(writer[2] == 0x03);

    writer.write([0x04, 0x05, 0x06]);
    assert(writer[3] == 0x04);
    assert(writer[4] == 0x05);
    assert(writer[5] == 0x06);
}

