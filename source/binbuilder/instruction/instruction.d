/**
Instruction interface module.
*/
module binbuilder.instruction.instruction;

import binbuilder.instruction.writer : Writer;

/**
Instruction interface.
*/
interface Instruction
{
    /**
    Write this instruction.

    Params:
        writer = desitination writer.
    */
    void write(scope Writer writer) const @nogc nothrow pure @safe scope;

    /**
    Returns:
        instruction bytes length.
    */
    @property size_t length() const @nogc nothrow pure @safe scope;
}

