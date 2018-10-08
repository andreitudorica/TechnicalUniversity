<?xml version="1.0" encoding="UTF-8"?>
<CONFIG>
 <Version>
  <version number="5"/>
 </Version>
 <Compilation>
  <file name="$dsn\src\systemc\simprims.cpp"/>
  <file name="$dsn\src\systemc\comp.cpp"/>
  <file name="$dsn\src\systemc\hex2bin.cpp"/>
  <file name="$dsn\src\systemc\sc_top.cpp"/>
  <options name="-g3"/>
 </Compilation>
 <Linker>
  <target name="$dsn\src\hex_ram.dll"/>
 </Linker>
 <Type>
  <DesignType name="SYSTEMC"/>
  <CompilerType name="GCC"/>
 </Type>
 <Additional>
  <AddLibraryToDesign name="true"/>
  <AddModulesToLibrary name="true"/>
 </Additional>
</CONFIG>
