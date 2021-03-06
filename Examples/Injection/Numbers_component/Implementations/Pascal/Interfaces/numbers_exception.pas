(*++

Copyright (C) 2019 Numbers developers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0.

Abstract: This is an autogenerated Pascal exception class definition file in order to allow easy
development of Numbers library. The functions in this file need to be implemented. It needs to be generated only once.

Interface version: 1.0.0

*)

{$MODE DELPHI}
unit numbers_exception;

interface

uses
  numbers_types,
  numbers_interfaces,
  Classes,
  sysutils;

type
  ENumbersException = class(Exception)
  private
    FErrorCode: TNumbersResult;
    FCustomMessage: String;
  public
    property ErrorCode: TNumbersResult read FErrorCode;
    property CustomMessage: String read FCustomMessage;
    constructor Create(AErrorCode: TNumbersResult);
    constructor CreateCustomMessage(AErrorCode: TNumbersResult; AMessage: String);
  end;


(*************************************************************************************************************************
 Definition of exception handling functionality for Numbers
**************************************************************************************************************************)

function HandleNumbersException(ANumbersObject: TObject; E: ENumbersException): TNumbersResult;
function HandleStdException(ANumbersObject: TObject; E: Exception): TNumbersResult;
function HandleUnhandledException(ANumbersObject: TObject): TNumbersResult;


implementation

  constructor ENumbersException.Create(AErrorCode: TNumbersResult);
  var
    ADescription: String;
  begin
    FErrorCode := AErrorCode;
    case FErrorCode of
      NUMBERS_ERROR_NOTIMPLEMENTED: ADescription := 'functionality not implemented';
      NUMBERS_ERROR_INVALIDPARAM: ADescription := 'an invalid parameter was passed';
      NUMBERS_ERROR_INVALIDCAST: ADescription := 'a type cast failed';
      NUMBERS_ERROR_BUFFERTOOSMALL: ADescription := 'a provided buffer is too small';
      NUMBERS_ERROR_GENERICEXCEPTION: ADescription := 'a generic exception occurred';
      NUMBERS_ERROR_COULDNOTLOADLIBRARY: ADescription := 'the library could not be loaded';
      NUMBERS_ERROR_COULDNOTFINDLIBRARYEXPORT: ADescription := 'a required exported symbol could not be found in the library';
      NUMBERS_ERROR_INCOMPATIBLEBINARYVERSION: ADescription := 'the version of the binary interface does not match the bindings interface';
      else
        ADescription := 'unknown';
    end;

    inherited Create(Format('Numbers library Error - %s (#%d)', [ ADescription, AErrorCode ]));
  end;

  constructor ENumbersException.CreateCustomMessage(AErrorCode: TNumbersResult; AMessage: String);
  begin
    FCustomMessage := AMessage;
    FErrorCode := AErrorCode;
    inherited Create(Format('%s(%d)', [FCustomMessage, AErrorCode]));
  end;

(*************************************************************************************************************************
 Implementation of exception handling functionality for Numbers
**************************************************************************************************************************)

function HandleNumbersException(ANumbersObject: TObject; E: ENumbersException): TNumbersResult;
begin
  result := E.ErrorCode;
  if Supports(ANumbersObject, INumbersBase) then begin
    (ANumbersObject as INumbersBase).RegisterErrorMessage(E.CustomMessage)
  end;
end;
function HandleStdException(ANumbersObject: TObject; E: Exception): TNumbersResult;
begin
  Result := NUMBERS_ERROR_GENERICEXCEPTION;
  if Supports(ANumbersObject, INumbersBase) then begin
    (ANumbersObject as INumbersBase).RegisterErrorMessage(E.Message)
  end;
end;
function HandleUnhandledException(ANumbersObject: TObject): TNumbersResult;
begin
  Result := NUMBERS_ERROR_GENERICEXCEPTION;
  if Supports(ANumbersObject, INumbersBase) then begin
    (ANumbersObject as INumbersBase).RegisterErrorMessage('Unhandled Exception')
  end;
end;
end.
