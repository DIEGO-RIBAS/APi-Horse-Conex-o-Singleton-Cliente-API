unit uModel.Login;

interface

  uses System.SysUtils, System.JSON, IPPeerClient, system.Classes,
       RESTRequest4D,
       DataSet.Serialize.Adapter.RESTRequest4D,
       FireDAC.Comp.Client, FireDAC.Dapt;

  type

    TModelLogin = class
      private
        FLongin : string;
        FPass   : string;

        FQuery  : TFDQuery;
      public
         property Longin : string read FLongin write FLongin;
         property Pass   : string read FPass   write FPass;

         function Validar : TJSONObject;

         constructor Create;
         destructor Destroy;

    end;

implementation

{ TModelLogin }

constructor TModelLogin.create;
begin
  FQuery := TFDQuery.Create(nil);
end;

destructor TModelLogin.Destroy;
begin
  FreeAndNil(FQuery);
end;

function TModelLogin.Validar: TJSONObject;
var
  Resp : IResponse;
begin
  try
      Resp := TRequest.New.BaseURL('localhost:9000/')
                                  .Resource('Validar')
                                  .Accept('application/json')
                                  .AddBody('{"Login":"'+FLongin+'","Pass":"'+FPass+'"}')
                                  .Post;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;
end;

end.
