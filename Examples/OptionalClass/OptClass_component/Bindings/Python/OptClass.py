'''++

Copyright (C) 2019 ACT Developers


This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0.

Abstract: This is an autogenerated Python file in order to allow an easy
 use of Optional Class Library

Interface version: 1.0.0

'''


import ctypes
import platform
import enum
import os

name = "optclass"

'''Definition of domain specific exception
'''
class EOptClassException(Exception):
	def __init__(self, code, message = ''):
		self._code = code
		self._message = message
	
	def __str__(self):
		if self._message:
			return 'OptClassException ' + str(self._code) + ': '+ str(self._message)
		return 'OptClassException ' + str(self._code)

'''Definition of binding API version
'''
class BindingVersion(enum.IntEnum):
	MAJOR = 1
	MINOR = 0
	MICRO = 0

'''Definition Error Codes
'''
class ErrorCodes(enum.IntEnum):
	SUCCESS = 0
	NOTIMPLEMENTED = 1
	INVALIDPARAM = 2
	INVALIDCAST = 3
	BUFFERTOOSMALL = 4
	GENERICEXCEPTION = 5
	COULDNOTLOADLIBRARY = 6
	COULDNOTFINDLIBRARYEXPORT = 7
	INCOMPATIBLEBINARYVERSION = 8

'''Definition of Function Table
'''
class FunctionTable:
	optclass_acquireinstance = None
	optclass_releaseinstance = None
	optclass_getversion = None
	optclass_getlasterror = None
	optclass_setjournal = None
	optclass_createinstancewithname = None
	optclass_findinstancea = None
	optclass_findinstanceb = None
	optclass_useinstancemaybe = None


'''Wrapper Class Implementation
'''
class Wrapper:

	def __init__(self, libraryName = None, symbolLookupMethodAddress = None):
		ending = ''
		if platform.system() == 'Windows':
			ending = 'dll'
		elif platform.system() == 'Linux':
			ending = 'so'
		elif platform.system() == 'Darwin':
			ending = 'dylib'
		else:
			raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY)
		
		if (not libraryName) and (not symbolLookupMethodAddress):
			libraryName = os.path.join(os.path.dirname(os.path.realpath(__file__)),'optclass')
		
		if libraryName is not None:
			path = libraryName + '.' + ending
			try:
				self.lib = ctypes.CDLL(path)
			except Exception as e:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(e) + '| "'+path + '"' )
			
			self._loadFunctionTable()
		elif symbolLookupMethodAddress is not None:
				self.lib = FunctionTable()
				self._loadFunctionTableFromMethod(symbolLookupMethodAddress)
		else:
			raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(e))
		
		self._checkBinaryVersion()
	
	def _loadFunctionTableFromMethod(self, symbolLookupMethodAddress):
		try:
			symbolLookupMethodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_char_p, ctypes.POINTER(ctypes.c_void_p))
			symbolLookupMethod = symbolLookupMethodType(int(symbolLookupMethodAddress))
			
			methodAddress = ctypes.c_void_p()
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_acquireinstance")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_void_p)
			self.lib.optclass_acquireinstance = methodType(int(methodAddress.value))
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_releaseinstance")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_void_p)
			self.lib.optclass_releaseinstance = methodType(int(methodAddress.value))
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_getversion")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32))
			self.lib.optclass_getversion = methodType(int(methodAddress.value))
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_getlasterror")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_void_p, ctypes.c_uint64, ctypes.POINTER(ctypes.c_uint64), ctypes.c_char_p, ctypes.POINTER(ctypes.c_bool))
			self.lib.optclass_getlasterror = methodType(int(methodAddress.value))
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_setjournal")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_char_p)
			self.lib.optclass_setjournal = methodType(int(methodAddress.value))
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_createinstancewithname")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_char_p)
			self.lib.optclass_createinstancewithname = methodType(int(methodAddress.value))
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_findinstancea")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_char_p, ctypes.POINTER(ctypes.c_void_p))
			self.lib.optclass_findinstancea = methodType(int(methodAddress.value))
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_findinstanceb")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_char_p, ctypes.POINTER(ctypes.c_void_p))
			self.lib.optclass_findinstanceb = methodType(int(methodAddress.value))
			
			err = symbolLookupMethod(ctypes.c_char_p(str.encode("optclass_useinstancemaybe")), methodAddress)
			if err != 0:
				raise EOptClassException(ErrorCodes.COULDNOTLOADLIBRARY, str(err))
			methodType = ctypes.CFUNCTYPE(ctypes.c_int32, ctypes.c_void_p, ctypes.POINTER(ctypes.c_bool))
			self.lib.optclass_useinstancemaybe = methodType(int(methodAddress.value))
			
		except AttributeError as ae:
			raise EOptClassException(ErrorCodes.COULDNOTFINDLIBRARYEXPORT, ae.args[0])
		
	def _loadFunctionTable(self):
		try:
			self.lib.optclass_acquireinstance.restype = ctypes.c_int32
			self.lib.optclass_acquireinstance.argtypes = [ctypes.c_void_p]
			
			self.lib.optclass_releaseinstance.restype = ctypes.c_int32
			self.lib.optclass_releaseinstance.argtypes = [ctypes.c_void_p]
			
			self.lib.optclass_getversion.restype = ctypes.c_int32
			self.lib.optclass_getversion.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32)]
			
			self.lib.optclass_getlasterror.restype = ctypes.c_int32
			self.lib.optclass_getlasterror.argtypes = [ctypes.c_void_p, ctypes.c_uint64, ctypes.POINTER(ctypes.c_uint64), ctypes.c_char_p, ctypes.POINTER(ctypes.c_bool)]
			
			self.lib.optclass_setjournal.restype = ctypes.c_int32
			self.lib.optclass_setjournal.argtypes = [ctypes.c_char_p]
			
			self.lib.optclass_createinstancewithname.restype = ctypes.c_int32
			self.lib.optclass_createinstancewithname.argtypes = [ctypes.c_char_p]
			
			self.lib.optclass_findinstancea.restype = ctypes.c_int32
			self.lib.optclass_findinstancea.argtypes = [ctypes.c_char_p, ctypes.POINTER(ctypes.c_void_p)]
			
			self.lib.optclass_findinstanceb.restype = ctypes.c_int32
			self.lib.optclass_findinstanceb.argtypes = [ctypes.c_char_p, ctypes.POINTER(ctypes.c_void_p)]
			
			self.lib.optclass_useinstancemaybe.restype = ctypes.c_int32
			self.lib.optclass_useinstancemaybe.argtypes = [ctypes.c_void_p, ctypes.POINTER(ctypes.c_bool)]
			
		except AttributeError as ae:
			raise EOptClassException(ErrorCodes.COULDNOTFINDLIBRARYEXPORT, ae.args[0])
	
	def _checkBinaryVersion(self):
		nMajor, nMinor, _ = self.GetVersion()
		if (nMajor != BindingVersion.MAJOR) or (nMinor < BindingVersion.MINOR):
			raise EOptClassException(ErrorCodes.INCOMPATIBLEBINARYVERSION)
	
	def checkError(self, instance, errorCode):
		if errorCode != ErrorCodes.SUCCESS.value:
			if instance:
				if instance._wrapper != self:
					raise EOptClassException(ErrorCodes.INVALIDCAST, 'invalid wrapper call')
			message,_ = self.GetLastError(instance)
			raise EOptClassException(errorCode, message)
	
	def AcquireInstance(self, InstanceObject):
		InstanceHandle = None
		if InstanceObject:
			InstanceHandle = InstanceObject._handle
		else:
			raise EOptClassException(ErrorCodes.INVALIDPARAM, 'Invalid return/output value')
		self.checkError(None, self.lib.optclass_acquireinstance(InstanceHandle))
		
	
	def ReleaseInstance(self, InstanceObject):
		InstanceHandle = None
		if InstanceObject:
			InstanceHandle = InstanceObject._handle
		else:
			raise EOptClassException(ErrorCodes.INVALIDPARAM, 'Invalid return/output value')
		self.checkError(None, self.lib.optclass_releaseinstance(InstanceHandle))
		
	
	def GetVersion(self):
		pMajor = ctypes.c_uint32()
		pMinor = ctypes.c_uint32()
		pMicro = ctypes.c_uint32()
		self.checkError(None, self.lib.optclass_getversion(pMajor, pMinor, pMicro))
		
		return pMajor.value, pMinor.value, pMicro.value
	
	def GetLastError(self, InstanceObject):
		InstanceHandle = None
		if InstanceObject:
			InstanceHandle = InstanceObject._handle
		else:
			raise EOptClassException(ErrorCodes.INVALIDPARAM, 'Invalid return/output value')
		nErrorMessageBufferSize = ctypes.c_uint64(0)
		nErrorMessageNeededChars = ctypes.c_uint64(0)
		pErrorMessageBuffer = ctypes.c_char_p(None)
		pHasError = ctypes.c_bool()
		self.checkError(None, self.lib.optclass_getlasterror(InstanceHandle, nErrorMessageBufferSize, nErrorMessageNeededChars, pErrorMessageBuffer, pHasError))
		nErrorMessageBufferSize = ctypes.c_uint64(nErrorMessageNeededChars.value)
		pErrorMessageBuffer = (ctypes.c_char * (nErrorMessageNeededChars.value))()
		self.checkError(None, self.lib.optclass_getlasterror(InstanceHandle, nErrorMessageBufferSize, nErrorMessageNeededChars, pErrorMessageBuffer, pHasError))
		
		return pErrorMessageBuffer.value.decode(), pHasError.value
	
	def SetJournal(self, FileName):
		pFileName = ctypes.c_char_p(str.encode(FileName))
		self.checkError(None, self.lib.optclass_setjournal(pFileName))
		
	
	def CreateInstanceWithName(self, Identifier):
		pIdentifier = ctypes.c_char_p(str.encode(Identifier))
		self.checkError(None, self.lib.optclass_createinstancewithname(pIdentifier))
		
	
	def FindInstanceA(self, Identifier):
		pIdentifier = ctypes.c_char_p(str.encode(Identifier))
		InstanceHandle = ctypes.c_void_p()
		self.checkError(None, self.lib.optclass_findinstancea(pIdentifier, InstanceHandle))
		if InstanceHandle:
			InstanceObject = Base(InstanceHandle, self)
		else:
			InstanceObject = None
		
		return InstanceObject
	
	def FindInstanceB(self, Identifier):
		pIdentifier = ctypes.c_char_p(str.encode(Identifier))
		InstanceHandle = ctypes.c_void_p()
		self.checkError(None, self.lib.optclass_findinstanceb(pIdentifier, InstanceHandle))
		if InstanceHandle:
			InstanceObject = Base(InstanceHandle, self)
		else:
			InstanceObject = None
		
		return InstanceObject
	
	def UseInstanceMaybe(self, InstanceObject):
		InstanceHandle = None
		if InstanceObject:
			InstanceHandle = InstanceObject._handle
		pIsUsed = ctypes.c_bool()
		self.checkError(None, self.lib.optclass_useinstancemaybe(InstanceHandle, pIsUsed))
		
		return pIsUsed.value
	


''' Class Implementation for Base
'''
class Base:
	def __init__(self, handle, wrapper):
		if not handle or not wrapper:
			raise EOptClassException(ErrorCodes.INVALIDPARAM)
		self._handle = handle
		self._wrapper = wrapper
	
	def __del__(self):
		self._wrapper.ReleaseInstance(self)
		
