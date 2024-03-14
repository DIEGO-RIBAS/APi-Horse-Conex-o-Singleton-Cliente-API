unit uModel.Usuario;

interface
     uses System.SysUtils, System.JSON,
          RESTRequest4D,
          uEntitity.Usuario;

  type
    TModelUsuario = class
      private
        FEntityUsuario : TEntityUsuario;

      public
        property EntityUsuario : TEntityUsuario read FEntityUsuario write FEntityUsuario;

        function Gravar : TJSONObject;
        function Listar : TJSONObject;

        constructor Create;
        Destructor Destroy;
    end;

implementation

{ TModelUsuario }

constructor TModelUsuario.Create;
begin
  FEntityUsuario := TEntityUsuario.Create;
end;

destructor TModelUsuario.Destroy;
begin
  FreeAndNil(FEntityUsuario);
end;

function TModelUsuario.Gravar: TJSONObject;
var
  Resp : IResponse;
begin
  try
      Resp := TRequest.New.BaseURL('localhost:9000/')
                                  .Resource('GravarUsuario')
                                  .Accept('application/json')
                                  .AddBody('{"Nome":"'+FEntityUsuario.Nome+'","Login":"'+FEntityUsuario.Longin+'","Pass":"'+FEntityUsuario.Pass+'"}')
                                  .Post;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;
end;

function TModelUsuario.Listar: TJSONObject;
var
  Resp : IResponse;
begin
  try
      Resp := TRequest.New.BaseURL('localhost:9000/')
                                  .Resource('ListarUsuario')
                                  .Accept('application/json')
                                  .Get;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;
end;

end.
