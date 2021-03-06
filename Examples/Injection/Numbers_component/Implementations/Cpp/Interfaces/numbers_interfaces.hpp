/*++

Copyright (C) 2019 Numbers developers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0.

Abstract: This is an autogenerated C++ header file in order to allow easy
development of Numbers library. The implementer of Numbers library needs to
derive concrete classes from the abstract classes in this header.

Interface version: 1.0.0

*/


#ifndef __NUMBERS_CPPINTERFACES
#define __NUMBERS_CPPINTERFACES

#include <string>
#include <memory>

#include "numbers_types.hpp"



namespace Numbers {
namespace Impl {

/**
 Forward declarations of class interfaces
*/
class IBase;
class IVariable;



/*************************************************************************************************************************
 Class interface for Base
**************************************************************************************************************************/

class IBase
{
public:
	/**
	* IBase::~IBase - virtual destructor of IBase
	*/
	virtual
	~IBase() {};

	/**
	* IBase::ReleaseBaseClassInterface - Releases ownership of a base class interface. Deletes the reference, if necessary.
	* @param[in] pIBase - The base class instance to release
	*/
	static void
	ReleaseBaseClassInterface(IBase* pIBase)
	{
		if (pIBase) {
			pIBase->DecRefCount();
		}
	};

	/**
	* IBase::AcquireBaseClassInterface - Acquires shared ownership of a base class interface.
	* @param[in] pIBase - The base class instance to acquire
	*/
	static void
	AcquireBaseClassInterface(IBase* pIBase)
	{
		if (pIBase) {
			pIBase->IncRefCount();
		}
	};


	/**
	* IBase::GetLastErrorMessage - Returns the last error registered of this class instance
	* @param[out] sErrorMessage - Message of the last error registered
	* @return Has an error been registered already
	*/
	virtual bool GetLastErrorMessage(std::string & sErrorMessage) = 0;

	/**
	* IBase::ClearErrorMessages - Clears all registered messages of this class instance
	*/
	virtual void ClearErrorMessages() = 0;

	/**
	* IBase::RegisterErrorMessage - Registers an error message with this class instance
	* @param[in] sErrorMessage - Error message to register
	*/
	virtual void RegisterErrorMessage(const std::string & sErrorMessage) = 0;

	/**
	* IBase::IncRefCount - Increases the reference count of a class instance
	*/
	virtual void IncRefCount() = 0;

	/**
	* IBase::DecRefCount - Decreases the reference count of a class instance and free releases it, if the last reference has been removed
	* @return Has the object been released
	*/
	virtual bool DecRefCount() = 0;
};


/**
 Definition of a shared pointer class for IBase
*/
template<class T>
class IBaseSharedPtr : public std::shared_ptr<T>
{
public:
	explicit
	IBaseSharedPtr(T* t = nullptr)
		: std::shared_ptr<T>(t, IBase::ReleaseBaseClassInterface)
	{
		t->IncRefCount();
	}

	// Reset function, as it also needs to properly set the deleter.
	void
	reset(T* t = nullptr)
	{
		std::shared_ptr<T>::reset(t, IBase::ReleaseBaseClassInterface);
	}

	// Get-function that increases the Base class's reference count
	T*
	getCoOwningPtr()
	{
		T* t = this->get();
		t->IncRefCount();
		return t;
	}
};


typedef IBaseSharedPtr<IBase> PIBase;


/*************************************************************************************************************************
 Class interface for Variable
**************************************************************************************************************************/

class IVariable : public virtual IBase
{
public:
	/**
	* IVariable::GetValue - Returns the current value of this Variable
	* @return The current value of this Variable
	*/
	virtual Numbers_double GetValue() = 0;

	/**
	* IVariable::SetValue - Set the numerical value of this Variable
	* @param[in] dValue - The new value of this Variable
	*/
	virtual void SetValue(const Numbers_double dValue) = 0;

};

typedef IBaseSharedPtr<IVariable> PIVariable;


/*************************************************************************************************************************
 Global functions declarations
**************************************************************************************************************************/
class CWrapper
{
public:
	/**
	* Inumbers::CreateVariable - Creates a new Variable instance
	* @param[in] dInitialValue - Initial value of the new Variable
	* @return New Variable instance
	*/
	static IVariable * CreateVariable(const Numbers_double dInitialValue);

	/**
	* Inumbers::GetVersion - retrieves the binary version of this library.
	* @param[out] nMajor - returns the major version of this library
	* @param[out] nMinor - returns the minor version of this library
	* @param[out] nMicro - returns the micro version of this library
	*/
	static void GetVersion(Numbers_uint32 & nMajor, Numbers_uint32 & nMinor, Numbers_uint32 & nMicro);

	/**
	* Inumbers::GetLastError - Returns the last error recorded on this object
	* @param[in] pInstance - Instance Handle
	* @param[out] sErrorMessage - Message of the last error
	* @return Is there a last error to query
	*/
	static bool GetLastError(IBase* pInstance, std::string & sErrorMessage);

	/**
	* Inumbers::ReleaseInstance - Releases shared ownership of an Instance
	* @param[in] pInstance - Instance Handle
	*/
	static void ReleaseInstance(IBase* pInstance);

	/**
	* Inumbers::AcquireInstance - Acquires shared ownership of an Instance
	* @param[in] pInstance - Instance Handle
	*/
	static void AcquireInstance(IBase* pInstance);

};

} // namespace Impl
} // namespace Numbers

#endif // __NUMBERS_CPPINTERFACES
