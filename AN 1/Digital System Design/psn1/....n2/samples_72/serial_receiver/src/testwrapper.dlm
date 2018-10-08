<?xml version="1.0" encoding="UTF-8"?>
<CONFIG>
 <Version>
  <version number="5"/>
 </Version>
 <Compilation>
  <file name="$dsn\src\transactor.cpp"/>
  <file name="$dsn\src\test.cpp"/>
  <file name="$dsn\src\testwrapper.cpp"/>
  <options name="-O2"/>
 </Compilation>
 <Linker>
  <target name="$dsn\src\testwrapper.dll"/>
 </Linker>
 <Type>
  <DesignType name="SYSTEMC"/>
  <CompilerType name="GCC"/>
 </Type>
 <Additional>
  <AddLibraryToDesign name="false"/>
  <AddModulesToLibrary name="true"/>
 </Additional>
</CONFIG>
