/**
Basic types module.
*/
module binbuilder.format.elf.types;

import std.stdint :
    int8_t,
    int16_t,
    int32_t,
    int64_t,
    uint8_t,
    uint16_t,
    uint32_t,
    uint64_t;

/**
Binary architecture bits.
*/
enum ElfBits : uint
{
    /**
    Architecture bits 32.
    */
    bits32 = 32,

    /**
    Architecture bits 64.
    */
    bits64 = 64,
}

/**
ELF format basic types.
*/
template ElfTypes(ElfBits bits : ElfBits.bits64)
{
    alias Addr = uint64_t;
    alias Off = uint64_t;
    alias Section = uint16_t;
    alias Versym = uint16_t;
    alias Byte = uint8_t;
    alias Half = uint16_t;
    alias Sword = int32_t;
    alias Word = uint32_t;
    alias Sxword = int64_t;
    alias Xword = uint64_t;
}

/**
ELF file header.
*/
struct ElfHeader(ElfBits bits : ElfBits.bits64)
{
    alias Types = ElfTypes!bits;
    enum EI_NIDENT = 16;

    ubyte[EI_NIDENT] e_ident;
    uint16_t e_type;
    uint16_t e_machine;
    uint32_t e_version;
    Types.Addr e_entry;
    Types.Off e_phoff;
    Types.Off e_shoff;
    uint32_t e_flags;
    uint16_t e_ehsize;
    uint16_t e_phentsize;
    uint16_t e_phnum;
    uint16_t e_shentsize;
    uint16_t e_shnum;
    uint16_t e_shstrndx;
}

