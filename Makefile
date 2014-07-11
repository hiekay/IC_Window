

SCIDB_SOURCE_DIR=/home/ljiang/scidbtrunk
BOOST_LOCATION=/opt/scidb/13.12/3rdparty/boost/include
 
CFLAGS=-pedantic -W -Wextra -Wall -Wno-strict-aliasing -Wno-long-long -Wno-unused-parameter -fPIC -D__STDC_FORMAT_MACROS -Wno-system-headers -isystem -O2 -g -DNDEBUG -ggdb3  -D__STDC_LIMIT_MACROS
INC=-I. -DPROJECT_ROOT="\"$(SCIDB_SOURCE_DIR)\"" -I"$(SCIDB_SOURCE_DIR)/include" -I"$(BOOST_LOCATION)"
LIBS=-L"$(SCIDB_SOURCE_DIR)/lib" -shared -Wl,-soname, -L. -lm

all:
	@if test ! -d "$(SCIDB_SOURCE_DIR)"; then echo  "Error. Try:\n\nmake SCIDB_SOURCE_DIR=<PATH TO SCIDB TRUNK>"; exit 1; fi 
	$(CXX) $(CFLAGS) $(INC) -o plugin.cpp.o -c plugin.cpp

	$(CXX) $(CFLAGS) $(INC) -o LogicalIcWindow.cpp.o -c LogicalIcWindow.cpp
	$(CXX) $(CFLAGS) $(INC) -o PhysicalIcWindow.cpp.o -c PhysicalIcWindow.cpp
	$(CXX) $(CFLAGS) $(INC) -o IcWindowArray.cpp.o -c IcWindowArray.cpp

	$(CXX) $(CFLAGS) $(INC) -o libicwindow.so \
	                           plugin.cpp.o \
	                           LogicalIcWindow.cpp.o \
							   PhysicalIcWindow.cpp.o \
							   IcWindowArray.cpp.o \
	                           $(LIBS)

clean:
	rm -f *.o *.so
