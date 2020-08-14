/**
AMD64 instruction set prefix module.
*/
module binbuilder.instruction.amd64.prefix;

import binbuilder.instruction.writer : Writer, Writeable;

/**
Prefix
*/
abstract class Prefix : Writeable
{
@nogc nothrow pure @safe:

    /**
    Construct from prefix value.

    Params:
        value = prefix value.
    */
    this(ubyte value) scope
    {
        this.value_ = value;
    }

    override final void writeTo(scope Writer writer) const scope
    in (writer)
    {
        writer.write(value_);
    }

    override final @property size_t length() const scope
    {
        return 1;
    }

private:
    ubyte value_;
}

