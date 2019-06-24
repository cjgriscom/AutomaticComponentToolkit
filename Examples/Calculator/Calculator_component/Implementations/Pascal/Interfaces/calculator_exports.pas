(*++

Copyright (C) 2019 Calculator developers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0-develop.

Abstract: This is an autogenerated Pascal export implementation file in order to allow easy
development of Calculator library. The functions in this file need to be implemented. It needs to be generated only once.

Interface version: 1.0.0

*)

{$MODE DELPHI}
unit calculator_exports;

interface

uses
  calculator_impl,
  calculator_types,
  calculator_interfaces,
  calculator_exception,
  Classes,
  sysutils;

(*************************************************************************************************************************
 Class export definition of Base 
**************************************************************************************************************************)

(*************************************************************************************************************************
 Class export definition of Variable 
**************************************************************************************************************************)

(**
* Returns the current value of this Variable
*
* @param[in] pVariable - Variable instance.
* @param[out] pValue - The current value of this Variable
* @return error code or 0 (success)
*)
function calculator_variable_getvalue (pVariable: TCalculatorHandle; pValue: PDouble): TCalculatorResult; cdecl;

(**
* Set the numerical value of this Variable
*
* @param[in] pVariable - Variable instance.
* @param[in] dValue - The new value of this Variable
* @return error code or 0 (success)
*)
function calculator_variable_setvalue (pVariable: TCalculatorHandle; dValue: Double): TCalculatorResult; cdecl;

(*************************************************************************************************************************
 Class export definition of Calculator 
**************************************************************************************************************************)

(**
* Adds a Variable to the list of Variables this calculator works on
*
* @param[in] pCalculator - Calculator instance.
* @param[in] pVariable - The new variable in this calculator
* @return error code or 0 (success)
*)
function calculator_calculator_enlistvariable (pCalculator: TCalculatorHandle; pVariable: TCalculatorHandle): TCalculatorResult; cdecl;

(**
* Returns an instance of a enlisted variable
*
* @param[in] pCalculator - Calculator instance.
* @param[in] nIndex - The index of the variable to query
* @param[out] pVariable - The Index-th variable in this calculator
* @return error code or 0 (success)
*)
function calculator_calculator_getenlistedvariable (pCalculator: TCalculatorHandle; nIndex: Cardinal; pVariable: PCalculatorHandle): TCalculatorResult; cdecl;

(**
* Clears all variables in enlisted in this calculator
*
* @param[in] pCalculator - Calculator instance.
* @return error code or 0 (success)
*)
function calculator_calculator_clearvariables (pCalculator: TCalculatorHandle): TCalculatorResult; cdecl;

(**
* Multiplies all enlisted variables
*
* @param[in] pCalculator - Calculator instance.
* @param[out] pInstance - Variable that holds the product of all enlisted Variables
* @return error code or 0 (success)
*)
function calculator_calculator_multiply (pCalculator: TCalculatorHandle; pInstance: PCalculatorHandle): TCalculatorResult; cdecl;

(**
* Sums all enlisted variables
*
* @param[in] pCalculator - Calculator instance.
* @param[out] pInstance - Variable that holds the sum of all enlisted Variables
* @return error code or 0 (success)
*)
function calculator_calculator_add (pCalculator: TCalculatorHandle; pInstance: PCalculatorHandle): TCalculatorResult; cdecl;

(*************************************************************************************************************************
 Global function export definition
**************************************************************************************************************************)

(**
* retrieves the binary version of this library.
*
* @param[out] pMajor - returns the major version of this library
* @param[out] pMinor - returns the minor version of this library
* @param[out] pMicro - returns the micro version of this library
* @return error code or 0 (success)
*)
function calculator_getversion (pMajor: PCardinal; pMinor: PCardinal; pMicro: PCardinal): TCalculatorResult; cdecl;

(**
* Returns the last error recorded on this object
*
* @param[in] pInstance - Instance Handle
* @param[in] nErrorMessageBufferSize - size of the buffer (including trailing 0)
* @param[out] pErrorMessageNeededChars - will be filled with the count of the written bytes, or needed buffer size.
* @param[out] pErrorMessageBuffer -  buffer of Message of the last error, may be NULL
* @param[out] pHasError - Is there a last error to query
* @return error code or 0 (success)
*)
function calculator_getlasterror (pInstance: TCalculatorHandle; nErrorMessageBufferSize: Cardinal; pErrorMessageNeededChars: PCardinal; pErrorMessageBuffer: PAnsiChar; pHasError: PByte): TCalculatorResult; cdecl;

(**
* Releases the memory of an Instance
*
* @param[in] pInstance - Instance Handle
* @return error code or 0 (success)
*)
function calculator_releaseinstance (pInstance: TCalculatorHandle): TCalculatorResult; cdecl;

(**
* Creates a new Variable instance
*
* @param[in] dInitialValue - Initial value of the new Variable
* @param[out] pInstance - New Variable instance
* @return error code or 0 (success)
*)
function calculator_createvariable (dInitialValue: Double; pInstance: PCalculatorHandle): TCalculatorResult; cdecl;

(**
* Creates a new Calculator instance
*
* @param[out] pInstance - New Calculator instance
* @return error code or 0 (success)
*)
function calculator_createcalculator (pInstance: PCalculatorHandle): TCalculatorResult; cdecl;

implementation

function calculator_variable_getvalue (pVariable: TCalculatorHandle; pValue: PDouble): TCalculatorResult; cdecl;
var
  ResultValue: Double;
  ObjectVariable: TObject;
  IntfVariable: ICalculatorVariable;
begin
  try
    if not Assigned (pValue) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);
    if not Assigned (pVariable) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ObjectVariable := TObject (pVariable);
    if Supports (ObjectVariable, ICalculatorVariable) then begin
      IntfVariable := ObjectVariable as ICalculatorVariable;
      ResultValue := IntfVariable.GetValue();

      pValue^ := ResultValue;
    end else
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := HandleCalculatorException(ObjectVariable , E);
    end;
    On E: Exception do begin
      Result := HandleStdException(ObjectVariable , E);
    end
    else begin
      Result := HandleUnhandledException(ObjectVariable);
    end;
  end;
end;

function calculator_variable_setvalue (pVariable: TCalculatorHandle; dValue: Double): TCalculatorResult; cdecl;
var
  ObjectVariable: TObject;
  IntfVariable: ICalculatorVariable;
begin
  try
    if not Assigned (pVariable) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ObjectVariable := TObject (pVariable);
    if Supports (ObjectVariable, ICalculatorVariable) then begin
      IntfVariable := ObjectVariable as ICalculatorVariable;
      IntfVariable.SetValue(dValue);

    end else
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := HandleCalculatorException(ObjectVariable , E);
    end;
    On E: Exception do begin
      Result := HandleStdException(ObjectVariable , E);
    end
    else begin
      Result := HandleUnhandledException(ObjectVariable);
    end;
  end;
end;

function calculator_calculator_enlistvariable (pCalculator: TCalculatorHandle; pVariable: TCalculatorHandle): TCalculatorResult; cdecl;
var
  ObjectVariable: TObject;
  ObjectCalculator: TObject;
  IntfCalculator: ICalculatorCalculator;
begin
  try
    ObjectVariable := TObject (pVariable);
    if (not Supports (ObjectVariable, ICalculatorVariable)) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);
    
    if not Assigned (pCalculator) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ObjectCalculator := TObject (pCalculator);
    if Supports (ObjectCalculator, ICalculatorCalculator) then begin
      IntfCalculator := ObjectCalculator as ICalculatorCalculator;
      IntfCalculator.EnlistVariable(ObjectVariable);

    end else
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := HandleCalculatorException(ObjectCalculator , E);
    end;
    On E: Exception do begin
      Result := HandleStdException(ObjectCalculator , E);
    end
    else begin
      Result := HandleUnhandledException(ObjectCalculator);
    end;
  end;
end;

function calculator_calculator_getenlistedvariable (pCalculator: TCalculatorHandle; nIndex: Cardinal; pVariable: PCalculatorHandle): TCalculatorResult; cdecl;
var
  ResultVariable: TObject;
  ObjectCalculator: TObject;
  IntfCalculator: ICalculatorCalculator;
begin
  try
    if not Assigned(pVariable) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);
    if not Assigned (pCalculator) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ObjectCalculator := TObject (pCalculator);
    if Supports (ObjectCalculator, ICalculatorCalculator) then begin
      IntfCalculator := ObjectCalculator as ICalculatorCalculator;
      ResultVariable := IntfCalculator.GetEnlistedVariable(nIndex);

      pVariable^ := ResultVariable;
    end else
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := HandleCalculatorException(ObjectCalculator , E);
    end;
    On E: Exception do begin
      Result := HandleStdException(ObjectCalculator , E);
    end
    else begin
      Result := HandleUnhandledException(ObjectCalculator);
    end;
  end;
end;

function calculator_calculator_clearvariables (pCalculator: TCalculatorHandle): TCalculatorResult; cdecl;
var
  ObjectCalculator: TObject;
  IntfCalculator: ICalculatorCalculator;
begin
  try
    if not Assigned (pCalculator) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ObjectCalculator := TObject (pCalculator);
    if Supports (ObjectCalculator, ICalculatorCalculator) then begin
      IntfCalculator := ObjectCalculator as ICalculatorCalculator;
      IntfCalculator.ClearVariables();

    end else
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := HandleCalculatorException(ObjectCalculator , E);
    end;
    On E: Exception do begin
      Result := HandleStdException(ObjectCalculator , E);
    end
    else begin
      Result := HandleUnhandledException(ObjectCalculator);
    end;
  end;
end;

function calculator_calculator_multiply (pCalculator: TCalculatorHandle; pInstance: PCalculatorHandle): TCalculatorResult; cdecl;
var
  ResultInstance: TObject;
  ObjectCalculator: TObject;
  IntfCalculator: ICalculatorCalculator;
begin
  try
    if not Assigned(pInstance) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);
    if not Assigned (pCalculator) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ObjectCalculator := TObject (pCalculator);
    if Supports (ObjectCalculator, ICalculatorCalculator) then begin
      IntfCalculator := ObjectCalculator as ICalculatorCalculator;
      ResultInstance := IntfCalculator.Multiply();

      pInstance^ := ResultInstance;
    end else
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := HandleCalculatorException(ObjectCalculator , E);
    end;
    On E: Exception do begin
      Result := HandleStdException(ObjectCalculator , E);
    end
    else begin
      Result := HandleUnhandledException(ObjectCalculator);
    end;
  end;
end;

function calculator_calculator_add (pCalculator: TCalculatorHandle; pInstance: PCalculatorHandle): TCalculatorResult; cdecl;
var
  ResultInstance: TObject;
  ObjectCalculator: TObject;
  IntfCalculator: ICalculatorCalculator;
begin
  try
    if not Assigned(pInstance) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);
    if not Assigned (pCalculator) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ObjectCalculator := TObject (pCalculator);
    if Supports (ObjectCalculator, ICalculatorCalculator) then begin
      IntfCalculator := ObjectCalculator as ICalculatorCalculator;
      ResultInstance := IntfCalculator.Add();

      pInstance^ := ResultInstance;
    end else
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := HandleCalculatorException(ObjectCalculator , E);
    end;
    On E: Exception do begin
      Result := HandleStdException(ObjectCalculator , E);
    end
    else begin
      Result := HandleUnhandledException(ObjectCalculator);
    end;
  end;
end;

function calculator_getversion (pMajor: PCardinal; pMinor: PCardinal; pMicro: PCardinal): TCalculatorResult; cdecl;
begin
  try
    if (not Assigned (pMajor)) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    if (not Assigned (pMinor)) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    if (not Assigned (pMicro)) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);


    TCalculatorWrapper.GetVersion(pMajor^, pMinor^, pMicro^);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := E.ErrorCode;
    end
    else begin
      Result := CALCULATOR_ERROR_GENERICEXCEPTION;
    end
  end;
end;

function calculator_getlasterror (pInstance: TCalculatorHandle; nErrorMessageBufferSize: Cardinal; pErrorMessageNeededChars: PCardinal; pErrorMessageBuffer: PAnsiChar; pHasError: PByte): TCalculatorResult; cdecl;
var
  ObjectInstance: TObject;
  ResultErrorMessage: String;
  LenErrorMessage: Cardinal;
  ResultHasError: Boolean;
begin
  try
    ObjectInstance := TObject (pInstance);
    if (not Supports (ObjectInstance, ICalculatorBase)) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);
    
    if ((not Assigned (pErrorMessageBuffer)) and (not Assigned(pErrorMessageNeededChars))) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);
    if not Assigned (pHasError) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ResultHasError := TCalculatorWrapper.GetLastError(ObjectInstance, ResultErrorMessage);

    LenErrorMessage := Length (ResultErrorMessage);
    if Assigned(pErrorMessageNeededChars) then
      pErrorMessageNeededChars^ := LenErrorMessage + 1;
    if Assigned(pErrorMessageBuffer) then begin
      if (LenErrorMessage >= nErrorMessageBufferSize) then
        raise ECalculatorException.Create (CALCULATOR_ERROR_BUFFERTOOSMALL);
      Move (PAnsiChar (ResultErrorMessage)^, pErrorMessageBuffer^, LenErrorMessage);
      pErrorMessageBuffer[LenErrorMessage] := Char(0);
    end;
    pHasError^ := Ord (ResultHasError);
    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := E.ErrorCode;
    end
    else begin
      Result := CALCULATOR_ERROR_GENERICEXCEPTION;
    end
  end;
end;

function calculator_releaseinstance (pInstance: TCalculatorHandle): TCalculatorResult; cdecl;
var
  ObjectInstance: TObject;
begin
  try
    ObjectInstance := TObject (pInstance);
    if (not Supports (ObjectInstance, ICalculatorBase)) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDCAST);
    

    TCalculatorWrapper.ReleaseInstance(ObjectInstance);

    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := E.ErrorCode;
    end
    else begin
      Result := CALCULATOR_ERROR_GENERICEXCEPTION;
    end
  end;
end;

function calculator_createvariable (dInitialValue: Double; pInstance: PCalculatorHandle): TCalculatorResult; cdecl;
var
  ResultInstance: TObject;
begin
  try
    if not Assigned(pInstance) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ResultInstance := TCalculatorWrapper.CreateVariable(dInitialValue);

    pInstance^ := ResultInstance;
    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := E.ErrorCode;
    end
    else begin
      Result := CALCULATOR_ERROR_GENERICEXCEPTION;
    end
  end;
end;

function calculator_createcalculator (pInstance: PCalculatorHandle): TCalculatorResult; cdecl;
var
  ResultInstance: TObject;
begin
  try
    if not Assigned(pInstance) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM);

    ResultInstance := TCalculatorWrapper.CreateCalculator();

    pInstance^ := ResultInstance;
    Result := CALCULATOR_SUCCESS;
  except
    On E: ECalculatorException do begin
      Result := E.ErrorCode;
    end
    else begin
      Result := CALCULATOR_ERROR_GENERICEXCEPTION;
    end
  end;
end;


end.
