<?xml version="1.0" encoding="UTF-8"?>
<CONFIG>
 <Version>
  <version number="5"/>
 </Version>
 <Compilation>
  <file name="$dsn\src\testbench\frametypes.cpp"/>
  <file name="$dsn\src\testbench\transactor.cpp"/>
  <file name="$dsn\src\testbench\test.cpp"/>
  <file name="$dsn\src\testbench\tester.cpp"/>
  <options name="-02"/>
  <options name="-D__int64=&quot;long long int&quot;"/>
  <options name="-Wno-deprecated"/>
 </Compilation>
 <Linker>
  <target name="$dsn\src\testbench\tester.dll"/>
 </Linker>
 <Type>
  <DesignType name="SCV"/>
  <CompilerType name="GCC"/>
 </Type>
 <Additional>
  <AddLibraryToDesign name="false"/>
  <AddModulesToLibrary name="true"/>
 </Additional>
</CONFIG>
