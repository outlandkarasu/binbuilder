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

/**
Prefix group
*/
enum PrefixGroup
{
    group1,
    group2,
    group3,
    group4,
}

/**
Group prefix.

Params:
    group = prefix group.
*/
abstract class GroupPrefix(PrefixGroup group) : Prefix
{
private:
    this(ubyte value) @nogc nothrow pure @safe scope
    {
        super(value);
    }
}

alias Group1Prefix = GroupPrefix!(PrefixGroup.group1);
alias Group2Prefix = GroupPrefix!(PrefixGroup.group2);
alias Group3Prefix = GroupPrefix!(PrefixGroup.group3);
alias Group4Prefix = GroupPrefix!(PrefixGroup.group4);

private mixin template PrefixConstructor(ubyte value)
{
private:

    this() @nogc nothrow pure @safe scope
    {
        super(value);
    }
}

final class Lock : Group1Prefix
{
    mixin PrefixConstructor!(0xF0);
}

immutable LOCK = new Lock();

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => LOCK.writeTo(writer))();
    assert(writer[0] == 0xF0);
}

final class RepeatNotZero: Group1Prefix
{
    mixin PrefixConstructor!(0xF2);
}

immutable REPNZ = new RepeatNotZero();
alias REPNE = REPNZ;

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => REPNZ.writeTo(writer))();
    assert(writer[0] == 0xF2);
}

final class Repeat : Group1Prefix
{
    mixin PrefixConstructor!(0xF3);
}

immutable REP = new Repeat();
alias REPE = REP;
alias REPZ = REP;

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => REP.writeTo(writer))();
    assert(writer[0] == 0xF3);
}

final class SegmentOverrideCS : Group2Prefix
{
    mixin PrefixConstructor!(0x2E);
}

immutable CS_SEGMENT_OVERRIDE = new SegmentOverrideCS();

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => CS_SEGMENT_OVERRIDE.writeTo(writer))();
    assert(writer[0] == 0x2E);
}

final class SegmentOverrideSS : Group2Prefix
{
    mixin PrefixConstructor!(0x36);
}

immutable SS_SEGMENT_OVERRIDE = new SegmentOverrideSS();

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => SS_SEGMENT_OVERRIDE.writeTo(writer))();
    assert(writer[0] == 0x36);
}

final class SegmentOverrideDS : Group2Prefix
{
    mixin PrefixConstructor!(0x3E);
}

immutable DS_SEGMENT_OVERRIDE = new SegmentOverrideDS();

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => DS_SEGMENT_OVERRIDE.writeTo(writer))();
    assert(writer[0] == 0x3E);
}

final class SegmentOverrideES : Group2Prefix
{
    mixin PrefixConstructor!(0x26);
}

immutable ES_SEGMENT_OVERRIDE = new SegmentOverrideES();

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => ES_SEGMENT_OVERRIDE.writeTo(writer))();
    assert(writer[0] == 0x26);
}

final class SegmentOverrideFS : Group2Prefix
{
    mixin PrefixConstructor!(0x64);
}

immutable FS_SEGMENT_OVERRIDE = new SegmentOverrideFS();

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => FS_SEGMENT_OVERRIDE.writeTo(writer))();
    assert(writer[0] == 0x64);
}

final class SegmentOverrideGS : Group2Prefix
{
    mixin PrefixConstructor!(0x65);
}

immutable GS_SEGMENT_OVERRIDE = new SegmentOverrideGS();

///
@nogc nothrow pure unittest
{
    import binbuilder.instruction.writer : ArrayWriter;
    scope writer = new ArrayWriter();
    (() @safe => GS_SEGMENT_OVERRIDE.writeTo(writer))();
    assert(writer[0] == 0x65);
}

