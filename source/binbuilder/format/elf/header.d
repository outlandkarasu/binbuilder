/**
ELF header.
*/
module binbuilder.format.elf.header;

import binbuilder.format.elf.types : ElfBits, ElfTypes;

/**
ELF file header.
*/
struct ElfHeader(ElfBits bits : ElfBits.bits64)
{
    alias Types = ElfTypes!bits;

    enum
    {
        EI_MAG0 = 0,
        EI_MAG1,
        EI_MAG2,
        EI_MAG3,
        EI_CLASS,
        EI_DATA,
        EI_VERSION,
        EI_OSABI,
        EI_PAD,

        EI_NIDENT = 16,
    }

    ubyte[EI_NIDENT] e_ident = [0x7f, 'E', 'L', 'F'];
    Types.Half e_type;
    Types.Half e_machine;
    Types.Word e_version;
    Types.Addr e_entry;
    Types.Off e_phoff;
    Types.Off e_shoff;
    Types.Word e_flags;
    Types.Half e_ehsize = typeof(this).sizeof;
    Types.Half e_phentsize = ElfPHeader!(bits).sizeof;
    Types.Half e_phnum;
    Types.Half e_shentsize;
    Types.Half e_shnum;
    Types.Half e_shstrndx;

    enum ElfClass : ubyte
    {
        ELFCLASSNONE = 0,
        ELFCLASS32 = 1,
        ELFCLASS64 = 2,
        ELFCLASSNUM = 3,
    }

    enum ElfData : ubyte
    {
        ELFDATANONE = 0,
        ELFDATA2LSB = 1,
        ELFDATA2MSB = 2,
    }

    enum ElfVersion : ubyte
    {
        EV_NONE = 0,
        EV_CURRENT = 1,
        EV_NUM = 2,
    }

    enum ElfOsAbi : ubyte
    {
        ELFOSABI_NONE = 0,
        ELFOSABI_LINUX = 3,
    }

    @property @nogc nothrow pure @safe scope
    {
        ElfClass elfClass() const { return cast(ElfClass) e_ident[EI_CLASS]; }
        void elfClass(ElfClass value) { e_ident[EI_CLASS] = value; }

        ElfData elfData() const { return cast(ElfData) e_ident[EI_DATA]; }
        void elfData(ElfData value) { e_ident[EI_DATA] = value; }

        ElfVersion elfVersion() const { return cast(ElfVersion) e_ident[EI_VERSION]; }
        void elfVersion(ElfVersion value) { e_ident[EI_VERSION] = value; }

        ElfOsAbi elfOsAbi() const { return cast(ElfOsAbi) e_ident[EI_OSABI]; }
        void elfOsAbi(ElfOsAbi value) { e_ident[EI_OSABI] = value; }
    }

    enum : Types.Half
    {
        ET_NONE = 0,
        ET_REL = 1,
        ET_EXEC = 2,
        ET_DYN = 3,
        ET_CORE = 4,
        ET_LOOS = 0xfe00,
        ET_HIOS = 0xfeff,
        ET_LOPROC = 0xff00,
        ET_HIPROC = 0xffff,
    }

    enum : Types.Half
    {
        EM_NONE = 0,
        EM_386 = 3,
        EM_ARM = 40,
        EM_X86_64 = 62,
    }
}

///
@nogc nothrow pure @safe unittest
{
    alias Header = ElfHeader!(ElfBits.bits64);
    auto header = Header();
    assert(header.e_ehsize == header.sizeof);
    assert(header.e_phentsize == ElfPHeader!(ElfBits.bits64).sizeof);

    header.elfClass = Header.ElfClass.ELFCLASS64;
    header.elfData = Header.ElfData.ELFDATA2LSB;
    header.elfVersion = Header.ElfVersion.EV_CURRENT;
    header.elfOsAbi = Header.ElfOsAbi.ELFOSABI_LINUX;

    assert(header.elfClass == Header.ElfClass.ELFCLASS64);
    assert(header.elfData == Header.ElfData.ELFDATA2LSB);
    assert(header.elfVersion == Header.ElfVersion.EV_CURRENT);
    assert(header.elfOsAbi == Header.ElfOsAbi.ELFOSABI_LINUX);

    assert(header.e_ident[Header.EI_CLASS] == Header.ElfClass.ELFCLASS64);
    assert(header.e_ident[Header.EI_DATA] == Header.ElfData.ELFDATA2LSB);
    assert(header.e_ident[Header.EI_VERSION] == Header.ElfVersion.EV_CURRENT);
    assert(header.e_ident[Header.EI_OSABI] == Header.ElfOsAbi.ELFOSABI_LINUX);
}

/**
ELF program header.
*/
struct ElfPHeader(ElfBits bits : ElfBits.bits64)
{
    alias Types = ElfTypes!bits;
    Types.Word p_type;
    Types.Word p_flags;
    Types.Off p_offset;
    Types.Addr p_vaddr;
    Types.Addr p_paddr;
    Types.Xword p_filesz;
    Types.Xword p_memsz;
    Types.Xword p_align;
}

///
@nogc nothrow pure @safe unittest
{
    alias PHeader = ElfPHeader!(ElfBits.bits64);
    auto pheader = PHeader();
    assert(pheader.sizeof == 56);
}

