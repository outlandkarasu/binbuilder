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
    */
    void write(ubyte value) @nogc nothrow pure @safe scope;
}

